//
//  CreateAccountResponse.swift
//  BankApp
//
//  Created by Jonattan Sousa on 26/01/24.
//

import Foundation

struct CreateAccountResponse: Decodable {
    
    let success: Bool
    let error: String?
    
}
