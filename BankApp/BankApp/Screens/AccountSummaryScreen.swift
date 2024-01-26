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
    
    
    var body: some View {
        VStack {
            GeometryReader { g in
                VStack {
                    AccountListView(accounts: accountSummaryVM.accounts)
                        .frame(height: g.size.height/2)
                    Text("\(accountSummaryVM.total.formatAsCurrency())")
                    Spacer()
                }
            }
        }
        
        .onAppear() {
            self.accountSummaryVM.getAllAccounts()
        }
        
        .toolbar(content: {
            Button("Add Account") {
                self.presentCreateAccountSheet = true
            }
        })
        
        .navigationBarTitle("Account Summary")
        .embedInNavigationView()
        
        .sheet(isPresented: $presentCreateAccountSheet, onDismiss: {
            self.accountSummaryVM.getAllAccounts()
        }) {
            CreateAccountScreen()
        }
        
    }
}


struct AccountSummaryScreen_Preview: PreviewProvider {
    static var previews: some View {
        AccountSummaryScreen()
    }
}
