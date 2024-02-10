//
//  TransferFundsAccountSelectionView.swift
//  BankApp
//
//  Created by Jonattan Sousa on 09/02/24.
//

import SwiftUI

struct TransferFundsAccountSelectionView: View {
    
    @ObservedObject var transferFundsVM: TransferFundsViewModel
    @Binding var showSheet: Bool
    @Binding var isFromAccount: Bool
    
    var body: some View {
        VStack(spacing: 10) {
            Button("From \(transferFundsVM.fromAccountType)") { // TODO: - Alocate strings to shared constant struct
                self.isFromAccount = true
                self.showSheet = true
            }
            .padding()
            .frame(maxWidth: .infinity)
            .background(Color.green)
            .foregroundColor(Color.white)
            
            Button("To \(transferFundsVM.toAccountType)") { // TODO: - Alocate strings to shared constant struct
                self.isFromAccount = false
                self.showSheet = true
            }
            .padding()
            .frame(maxWidth: .infinity)
            .background(Color.green)
            .foregroundColor(Color.white)
            .opacity(self.transferFundsVM.fromAccount == nil ? 0.5 : 1.0)
            .disabled(self.transferFundsVM.fromAccount == nil)
            
            TextField("Amount", text: self.$transferFundsVM.amount) // TODO: - Alocate strings to shared constant struct
                .textFieldStyle(.roundedBorder)
        }.padding()
    }
}
