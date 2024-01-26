//
//  CreateAccountScreen.swift
//  BankApp
//
//  Created by Jonattan Sousa on 26/01/24.
//

import SwiftUI

struct CreateAccountScreen: View {
    
    @Environment(\.dismiss) var dismiss
    @ObservedObject private var createAccountVM = CreateAccountViewModel()
    
    var body: some View {
        Form {
            TextField("Name", text: $createAccountVM.name)
            Picker(selection: $createAccountVM.accountType, label: EmptyView()) {
                ForEach(AccountType.allCases, id: \.self) { accountType in
                    Text(accountType.title).tag(accountType)
                }
            }.pickerStyle(.palette)
            TextField("Balance", text: $createAccountVM.balance)
            
            HStack {
                Spacer()
                Button("Submit") {
                    self.createAccountVM.createAccount { success in
                        if success {
                            self.dismiss()
                        }
                    }
                }
                Spacer()
            }
        }
    }
}

struct CreateAccountScreen_Preview: PreviewProvider {
    static var previews: some View {
        CreateAccountScreen()
    }
}
