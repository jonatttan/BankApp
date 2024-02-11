//
//  TransferFundRequest.swift
//  BankApp
//
//  Created by Jonattan Sousa on 29/01/24.
//

import Foundation

struct TransferFundRequest: Codable {
    
    let accountFromId: String
    let accountToId: String
    let amount: Double
    
}
