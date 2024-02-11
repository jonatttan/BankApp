//
//  TransferFoundsViewModel.swift
//  BankApp
//
//  Created by Jonattan Sousa on 07/02/24.
//

import Foundation

class TransferFundsViewModel: ObservableObject {
    
    var fromAccount: AccountViewModel?
    var toAccount: AccountViewModel?
    
    @Published var accounts = [AccountViewModel]()
    @Published var message: String?
    var amount: String = .empty
    
    var isAmountValid: Bool {
        guard let amount = Double(amount) else {
            return false
        }
        return (amount > 0)
    }
    
    // TODO: - Refactor to use guard
    var filteredAccounts: [AccountViewModel] {
        if fromAccount == nil {
            return accounts
        } else {
            return accounts.filter {
                guard let fromAccount = fromAccount else {
                    return false
                }
                
                return $0.accountId != fromAccount.accountId
            }
        }
    }
    
    var fromAccountType: String {
        guard let fromAccount =  fromAccount else { return .empty }
        return fromAccount.accountType
    }
    
    var toAccountType: String {
        guard let toAccount = toAccount else { return .empty }
        return toAccount.accountType
    }
    
    private func isValid() -> Bool {
        message = "Invalid amount" // TODO: - Alocate strings to shared constant struct
        return isAmountValid
    }
    
    func populateAccounts () {
        AccountService.shared.getAllAccounts { result in
            switch result {
            case .success(let accounts):
                if let accounts = accounts {
                    DispatchQueue.main.async {
                        self.accounts = accounts.map(AccountViewModel.init)
                    }
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func submitTransfer(completion: @escaping() -> Void) {
        
        if !isValid() {
            return
        }
        
        guard  let fromAccount = fromAccount,
               let toAccount = toAccount,
               let amount = Double(amount) else {
            return
        }
        
        let transferFundRequest = TransferFundRequest(
            accountFromId: fromAccount.accountId.lowercased(),
            accountToId: toAccount.accountId.lowercased(),
            amount: amount
        )
        
        AccountService.shared.transferFunds(transferFundRequest: transferFundRequest) { result in
            switch result {
            case .success(let response):
                if response.success {
                    completion()
                } else {
                    DispatchQueue.main.async {
                        self.message = response.error
                    }
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    self.message = error.localizedDescription
                }
            }
        }
    }
    
}
