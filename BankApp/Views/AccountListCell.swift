//
//  AccountListCell.swift
//  BankApp
//
//  Created by Jonattan Sousa on 26/01/24.
//

import SwiftUI

fileprivate struct ConstantValues {
    static let verticalSpacingValue: CGFloat = 10
    static let opacityForAccountType: Double = 0.5
}

struct AccountListCell: View {
    
    let account: AccountViewModel
    
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: ConstantValues.verticalSpacingValue) {
                Text(account.name)
                    .font(.headline)
                
                Text(account.accountType)
                    .opacity(ConstantValues.opacityForAccountType)
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
                              name: "Sample name", // TODO: - Alocate strings to shared constant struct
                              accountType: .checking,
                              balance: 20.05)
        AccountListCell(account: AccountViewModel(account: account))
    }
    
}
