//
//  AccountService.swift
//  BankApp
//
//  Created by Jonattan Sousa on 25/01/24.
//

import Foundation

enum NetworkError: Error {
    case badUrl, noData, decodingError
}

class AccountService {
    static let share = AccountService()
    
    private init() {}
    
    func getAllAccounts(completion: @escaping (Result<[Account]?, NetworkError> ) -> Void) {
        
        guard let url = URL.urlForAccounts() else {
            return completion(.failure(.badUrl))
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            
            guard let data = data, error == nil else {
                return completion(.failure(.noData))
            }
            
            let accounts = try? JSONDecoder().decode([Account].self, from: data)
            
            // TODO: - Can be a switch?
            if accounts == nil {
                return completion(.failure(.decodingError))
            } else {
                return completion(.success(accounts))
            }
            
        }.resume()
    }
    
}
