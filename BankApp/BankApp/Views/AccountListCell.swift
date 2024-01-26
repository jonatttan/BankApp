//
//  AccountListCell.swift
//  BankApp
//
//  Created by Jonattan Sousa on 26/01/24.
//

import SwiftUI

struct AccountListCell: View {
    
    let account: AccountViewModel
    
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 10) {
                Text(account.name)
                    .font(.headline)
                
                Text(account.accountType)
                    .opacity(0.5)
            }
            Spacer()
            Text("\(account.balance.formatAsCurrency())")
                .foregroundStyle(.green)
        }
    }
    
}


struct AccountListCell_Previews: PreviewProvider {
    
    static var previews: some View {
        let account = Account(id: UUID(),
                              name: "Sample name",
                              accountType: .checking,
                              balance: 20.05)
        AccountListCell(account: AccountViewModel(account: account))
    }
    
}
