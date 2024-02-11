//
//  Account.swift
//  BankApp
//
//  Created by Jonattan Sousa on 25/01/24.
//

import Foundation

enum AccountType: String, Codable, CaseIterable {
    case checking, saving
}

extension AccountType {
    var title: String {
        switch self {
        case .checking:
            return "Checking"
        case .saving:
            return "Saving"
        }
    }
}

struct Account: Codable {
    let id: UUID
    let name: String
    let accountType: AccountType
    let balance: Double
}
