//
//  AccountSummaryScreen.swift
//  BankApp
//
//  Created by Jonattan Sousa on 25/01/24.
//

import SwiftUI

fileprivate struct ConstantValues {
    static let screenDivisorValue: CGFloat = 2
}

struct AccountSummaryScreen: View {
    
    @ObservedObject private var accountSummaryVM = AccountSummaryViewModel()
    @State private var presentCreateAccountSheet: Bool = false
    @State private var presentTransferFundSheet: Bool = false
    
    var body: some View {
        VStack {
            GeometryReader { g in
                VStack {
                    AccountListView(accounts: accountSummaryVM.accounts)
                        .frame(height: g.size.height/ConstantValues.screenDivisorValue)
                    Text("\(accountSummaryVM.total.formatAsCurrency())")
                    Spacer()
                    Button(Localizable.transferFundsButtonText.value) {
                        self.presentTransferFundSheet = true
                    }.padding()
                }
            }
        }
        
        .onAppear() {
            self.accountSummaryVM.getAllAccounts()
        }
        
        .toolbar(content: {
            Button(Localizable.addAccountButtonText.value) {
                self.presentCreateAccountSheet = true
            }
        })
        
        .navigationTitle(Localizable.summaryScreenTitle.value)
        .embedInNavigationView()
        
        .sheet(isPresented: $presentCreateAccountSheet, onDismiss: {
            self.accountSummaryVM.getAllAccounts()
        }) {
            CreateAccountScreen()
        }
     
        .sheet(isPresented: $presentTransferFundSheet, onDismiss: {
            self.accountSummaryVM.getAllAccounts()
        }) {
            TransferFundsScreen()
        }
    }
    
}


struct AccountSummaryScreen_Preview: PreviewProvider {
    static var previews: some View {
        AccountSummaryScreen()
    }
}
