//
//  AccountListView.swift
//  BankApp
//
//  Created by Jonattan Sousa on 25/01/24.
//

import SwiftUI

struct AccountListView: View {
    
    let accounts: [AccountViewModel]
    
    var body: some View {
        List(accounts, id: \.accountId) { account in
            AccountListCell(account: account)
        }
    }
}

