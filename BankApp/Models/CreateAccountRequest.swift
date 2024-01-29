//
//  CreateAccountRequest.swift
//  BankApp
//
//  Created by Jonattan Sousa on 26/01/24.
//

import Foundation

struct CreateAccountRequest: Codable {
    
    let name: String
    let accountType: String
    let balance: Double
    
}
