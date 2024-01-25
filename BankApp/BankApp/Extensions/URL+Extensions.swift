//
//  URL+Extensions.swift
//  BankApp
//
//  Created by Jonattan Sousa on 25/01/24.
//

import Foundation

extension URL {
    
    private static let baseUrl: String = "https://bloom-miniature-basin.glitch.me"
    
    static func urlForAccounts() -> URL? {
        return URL(string: "\(baseUrl)/api/accounts")
    }
    
}
