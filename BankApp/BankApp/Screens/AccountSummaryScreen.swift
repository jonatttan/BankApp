//
//  AccountSummaryScreen.swift
//  BankApp
//
//  Created by Jonattan Sousa on 25/01/24.
//

import SwiftUI

struct AccountSummaryScreen: View {
    @ObservedObject private var accountSummaryVM = AccountSummaryViewModel()
    
    
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
        
        .navigationBarTitle("Account Summary")
        .embedInNavigationView()
    }
}


struct AccountSummaryScreen_Preview: PreviewProvider {
    static var previews: some View {
        AccountSummaryScreen()
    }
}
