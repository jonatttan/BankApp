//
//  TransferFundsScreen.swift
//  BankApp
//
//  Created by Jonattan Sousa on 08/02/24.
//

import SwiftUI

fileprivate struct ConstantValues {
    static let accountListViewHeight: CGFloat = 200
}

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
                    .frame(height: ConstantValues.accountListViewHeight)
                TransferFundsAccountSelectionView(transferFundsVM: transferFundsVM,
                                                  showSheet: $isShowSheet,
                                                  isFromAccount: $isFromAccount)
                Spacer()
                
                    .onAppear {
                        transferFundsVM.populateAccounts()
                    }
                
                Text(transferFundsVM.message ?? .empty)
                
                Button(Localizable.submitTransferButtonText.value) {
                    transferFundsVM.submitTransfer() {
                        presentationMode.wrappedValue.dismiss()
                    }
                }.padding()
                    .actionSheet(isPresented: $isShowSheet) {
                        ActionSheet(title: Text(Localizable.actionSheetTitle.value),
                                    message: Text(Localizable.actionSheetMessage.value),
                                    buttons: actionSheetButtons)
                    }
            }
        }
        .navigationBarTitle(Localizable.transferFundsScreenTitle.value)
        .embedInNavigationView()
    }
}

struct TransferFundsScreen_Previews: PreviewProvider {
    static var previews: some View {
        TransferFundsScreen()
    }
}
