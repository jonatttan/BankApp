//
//  CreateAccountViewModel.swift
//  BankApp
//
//  Created by Jonattan Sousa on 26/01/24.
//

import Foundation

class CreateAccountViewModel: ObservableObject {
    
    @Published var name: String = .empty
    @Published var accountType: AccountType = .checking
    @Published var balance: String = .empty
    @Published var errorMessage: String = .empty
    
}

// MARK: - Business Logic Validation
extension CreateAccountViewModel {
    
    private var isNameValid: Bool {
        !self.name.isEmpty
    }
    
    private var isBalanceValid: Bool {
        guard let userBalance = Double(self.balance) else {
            return false
        }
        return !(userBalance <= 0)
    }
    
    private var isValid: Bool {
        var errors = [String]()
        
        if !isNameValid {
            errors.append("Name is not valid")
        }
        
        if !isBalanceValid {
            errors.append("Balance is not valid")
        }
        
        if !errors.isEmpty {
            DispatchQueue.main.async {
                self.errorMessage = errors.joined(separator: "/n")
            }
            return false
        }
        
        return true
    }
}

extension CreateAccountViewModel {
    
    func createAccount(completion: @escaping(Bool) -> Void) {
        guard self.isValid,
        let balance = Double(self.balance) else {
            return completion(false)
        }
        
        let createAccountRequest = CreateAccountRequest(name: self.name,
                                                        accountType: self.accountType.rawValue,
                                                        balance: balance)
        
        AccountService.shared.createAccount(createAccountRequest: createAccountRequest) { result in
            switch result {
            case .success(let createAccountResponse):
                
                guard createAccountResponse.success else {
                    if let error = createAccountResponse.error {
                        DispatchQueue.main.async {
                            self.errorMessage = error
                        }
                        completion(false)
                    }
                    return
                }
                
                completion(true)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
}
