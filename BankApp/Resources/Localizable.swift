//
//  Localizable.swift
//  BankApp
//
//  Created by Jonattan Sousa on 11/02/24.
//

import Foundation

enum Localizable: String {
    
    // MARK: - AccountSummaryScreen
    case summaryScreenTitle = "summary_screen_title"
    case transferFundsButtonText = "transfer_funds_button_text"
    case addAccountButtonText = "add_account_button_text"
    
    // MARK: - CreateAccountScreen
    case createAccountScreenTitle = "create_account_screen_title"
    case placeholderName = "placeholder_name"
    case placeholderBalance = "placeholder_balance"
    case submitButtonText = "submit_button_text"
    
    // MARK: - TransferFundsScreen
    case transferFundsScreenTitle = "transfer_funds_screen_title"
    case submitTransferButtonText = "submit_transfer_button_text"
    case actionSheetTitle = "action_sheet_title"
    case actionSheetMessage = "action_sheet_message"
    
    // MARK: - TransferFundsAccountSelectionView
    case fromButtonText = "from_button_text"
    case toButtonText = "to_button_text"
    case amountPlaceholder = "amount_placeholder"
    
    // MARK: - HTTP Headers value
    case applicationJson = "application_json"
    case contentType = "content_type"
    
    // MARK: - TransferFoundsViewModel
    case invalidAmountMessage = "invalid_amount_message"
    
}

extension Localizable {
    var value: String {
        NSLocalizedString(self.rawValue, comment: "Localizable")
    }
}
