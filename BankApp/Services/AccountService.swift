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
    static let shared = AccountService()
    
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
    
    // TODO: - Alocate strings to shared constant struct
    func createAccount(createAccountRequest: CreateAccountRequest, completion: @escaping(Result<CreateAccountResponse, NetworkError>) -> Void) {
        
        guard let url = URL.urlForCreateAccounts() else {
            return completion(.failure(.badUrl))
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try? JSONEncoder().encode(createAccountRequest)
        
        URLSession.shared.dataTask(with: request) { data, _, error in
            
            guard let data = data, error == nil else {
                return completion(.failure(.noData))
            }
            
            guard let createAccountResponse = try? JSONDecoder().decode(CreateAccountResponse.self, from: data) else {
                return completion(.failure(.decodingError))
            }
            
            completion(.success(createAccountResponse))
            
        }.resume()
        
    }
    
    // TODO: - Allocate strings to shared constant struct
    func transferFunds(transferFundRequest: TransferFundRequest, completion: @escaping(Result<TransferFundsResponse, NetworkError>) -> Void) {
        
        guard let url = URL.urlForTransferFunds() else {
            return completion(.failure(.badUrl))
        }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "POST"
        urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
        urlRequest.httpBody = try? JSONEncoder().encode(transferFundRequest)
        
        URLSession.shared.dataTask(with: urlRequest) { data, _, error in
            
            guard let data = data, error == nil else {
                return completion(.failure(.noData))
            }
            
            // TODO: - Could it be a guard?
            let transferFundResponse = try? JSONDecoder().decode(TransferFundsResponse.self, from: data)
            
            if let transferFundResponse = transferFundResponse {
                completion(.success(transferFundResponse))
            } else {
                completion(.failure(.decodingError))
            }
            
        }.resume()
        
    }
}
