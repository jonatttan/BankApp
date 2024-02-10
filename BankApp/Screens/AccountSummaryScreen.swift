//
//  AccountSummaryScreen.swift
//  BankApp
//
//  Created by Jonattan Sousa on 25/01/24.
//

import SwiftUI

struct AccountSummaryScreen: View {
    
    @ObservedObject private var accountSummaryVM = AccountSummaryViewModel()
    @State private var presentCreateAccountSheet: Bool = false
    @State private var presentTransferFundSheet: Bool = false
    
    var body: some View {
        VStack {
            GeometryReader { g in
                VStack {
                    AccountListView(accounts: accountSummaryVM.accounts)
                        .frame(height: g.size.height/2)
                    Text("\(accountSummaryVM.total.formatAsCurrency())")
                    Spacer()
                    Button("Transfer funds") { // TODO: - Alocate strings to shared constant struct
                        self.presentTransferFundSheet = true
                    }.padding()
                }
            }
        }
        
        .onAppear() {
            self.accountSummaryVM.getAllAccounts()
        }
        
        .toolbar(content: {
            Button("Add Account") { // TODO: - Alocate strings to shared constant struct
                self.presentCreateAccountSheet = true
            }
        })
        
        .navigationTitle("Account Summary") // TODO: - Alocate strings to shared constant struct
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
