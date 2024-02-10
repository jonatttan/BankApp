//
//  TransferFundsScreen.swift
//  BankApp
//
//  Created by Jonattan Sousa on 08/02/24.
//

import SwiftUI

struct TransferFundsScreen: View {
    
    @Environment(\.presentationMode) private var presentationMode
    @ObservedObject private var transferFundsVM = TransferFundsViewModel()
    @State private var isShowSheet: Bool = false
    @State private var isFromAccount: Bool = false
    
    var actionSheetButtons: [Alert.Button] {
        var actionButtons = transferFundsVM.filteredAccounts.map { account in
            Alert.Button.default(Text("\(account.name) (\(account.accountType))")) {
                if self.isFromAccount {
                    transferFundsVM.fromAccount = account
                } else {
                    transferFundsVM.toAccount = account
                }
            }
        }
        actionButtons.append(.cancel())
        return actionButtons
    }
    
    var body: some View {
        ScrollView {
            VStack {
                AccountListView(accounts: transferFundsVM.accounts)
                    .frame(height: 200) // TODO: - Alocate in the enum to sizes/ spacing
                TransferFundsAccountSelectionView(transferFundsVM: transferFundsVM,
                                                  showSheet: $isShowSheet, 
                                                  isFromAccount: $isFromAccount)
                Spacer()
                
                    .onAppear {
                        transferFundsVM.populateAccounts()
                    }
                
                Text(transferFundsVM.message ?? .empty)
                
                Button("Submit transfer") { // TODO: Alocate in the struct of strings
                    transferFundsVM.submitTransfer() {
                        presentationMode.wrappedValue.dismiss()
                    }
                }.padding()
                    .actionSheet(isPresented: $isShowSheet) {
                        ActionSheet(title: Text("Transfer funds"), // TODO: Alocate in the struct of strings
                                    message: Text("Chose an option"), // TODO: Alocate in the struct of strings
                                    buttons: actionSheetButtons)
                    }
            }
        }
        .navigationBarTitle("Transfer Funds") // TODO: - Alocate strings to shared constant struct
        .embedInNavigationView()
    }
}

struct TransferFundsScreen_Previews: PreviewProvider {
    static var previews: some View {
        TransferFundsScreen()
    }
}
