//
//  AccountSummaryViewModel.swift
//  BankApp
//
//  Created by Jonattan Sousa on 25/01/24.
//

import Foundation

class AccountSummaryViewModel: ObservableObject {
    
    private var _accountsViewModel = [Account]()
    
    @Published var accounts = [AccountViewModel]()
    
    var total: Double {
        _accountsViewModel.map { $0.balance }.reduce(0, +)
    }
    
    func getAllAccounts() {
        AccountService.share.getAllAccounts { result in
            switch result {
            case .success(let accounts):
                if let accountList = accounts {
                    self._accountsViewModel = accountList
                    DispatchQueue.main.async {
                        self.accounts = accountList.map(AccountViewModel.init)
                    }
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
}

class AccountViewModel {
    
    var account: Account
    
    init(account: Account) {
        self.account = account
    }
    
    var name: String {
        account.name
    }
    
    var accountId: String {
        account.id.uuidString
    }
    
    var accountType: String {
        account.accountType.title
    }
    
    var balance: Double {
        account.balance
    }
    
}
