//
//  TransferFundsAccountSelectionView.swift
//  BankApp
//
//  Created by Jonattan Sousa on 09/02/24.
//

import SwiftUI

fileprivate struct ConstantValues {
    static let verticalSpacingValue: CGFloat = 10
    static let opacityForDisableButton: Double = 0.5
    static let opacityForEnableButton: Double = 1.0
}

struct TransferFundsAccountSelectionView: View {
    
    @ObservedObject var transferFundsVM: TransferFundsViewModel
    @Binding var showSheet: Bool
    @Binding var isFromAccount: Bool
    
    var body: some View {
        VStack(spacing: ConstantValues.verticalSpacingValue) {
            Button("\(Localizable.fromButtonText.value) \(transferFundsVM.fromAccountType)") {
                self.isFromAccount = true
                self.showSheet = true
            }
            .padding()
            .frame(maxWidth: .infinity)
            .background(Color.green)
            .foregroundColor(Color.white)
            
            Button("\(Localizable.toButtonText.value) \(transferFundsVM.toAccountType)") {
                self.isFromAccount = false
                self.showSheet = true
            }
            .padding()
            .frame(maxWidth: .infinity)
            .background(Color.green)
            .foregroundColor(Color.white)
            .opacity(self.transferFundsVM.fromAccount == nil ? ConstantValues.opacityForDisableButton :
                        ConstantValues.opacityForEnableButton)
            .disabled(self.transferFundsVM.fromAccount == nil)
            
            TextField(Localizable.amountPlaceholder.value, text: self.$transferFundsVM.amount)
                .textFieldStyle(.roundedBorder)
        }.padding()
    }
}
