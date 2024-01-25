//
//  Double+Extensions.swift
//  BankApp
//
//  Created by Jonattan Sousa on 25/01/24.
//

import Foundation

extension Double {
    
    func formatAsCurrency() -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        let formattedCurrency = formatter.string(from: self as NSNumber)
        return formattedCurrency ?? .empty
    }
    
}
