//
//  NetworkProvider.swift
//  StarlingRounder
//
//  Created by Riccardo on 26/05/2019.
//  Copyright © 2019 RiccardoScanavacca. All rights reserved.
//

import Foundation

enum HTTPMethod: String {
    
    case get = "GET"
    case put = "PUT"
    case post = "POST"
    case delete = "DELETE"
}

class NetworkProvider {
    
    private static let authorizationToken = "Bearer \(Constant.accessToken)"
    
    static func getAccountData(completion: @escaping(Data?, Error?) -> Void) {
        
        httpRequest(for: URLProvider.accountsURL(), method: .get) { (data: Data?, error: Error?) in
            completion(data, error)
        }
    }
    
    static func getSavingGoalData(forAccount account: Account, completion: @escaping(Data?, Error?) -> Void) {

        httpRequest(for: URLProvider.savingAccountsURL(forAccountUid: account.accountUid), method: .get) { (data: Data?, error: Error?) in
            completion(data, error)
        }
    }
    
    static func getTransactionsData(forAccont account: Account, completion: @escaping(Data?, Error?) -> Void) {
        
        let lastWeek = Calendar.current.date(byAdding: .day, value: -7, to: Date())
        let url = URLProvider.transactionUrl(forAccountUid: account.accountUid, category: account.defaultCategory, sinceDate:lastWeek)
        
        httpRequest(for: url, method: .get) { (data, error) in
            completion(data, error)
        }
    }
    
    static func putTransferMoney(_ amount: Int, from account: Account, toSavingGoal saving: SavingGoal, completion:@escaping(Data?, Error?) -> Void) {
        
        let url = URLProvider.savingTransferUrl(fromAccountUid: account.accountUid, toSavingGoalUid:saving.savingsGoalUid )
        let amount = Amount(currency: account.currency, minorUnits: amount)
        let tranferBody = TransferBody(amount: amount)
        let body = try? JSONEncoder().encode(tranferBody)
        
        httpRequest(for: url, method: .put, body: body) { (data, error) in
            completion(data, error)
        }
    }

}

private extension NetworkProvider {
    
    static func httpRequest(for url: URL?, method: HTTPMethod, body: Data? = nil, completion: @escaping(Data?, Error?) -> Void) {
        
        guard let url = url else {
            print("incorrect url string")
            completion(nil, nil)
            return
        }
        
        let session = URLSession.shared.dataTask(with: urlRequest(forUrl: url, method: method, body: body)) { (data, response, error) in
            
            if let error = error {
                completion(nil, error)
                return
            }
            
            if let response = response as? HTTPURLResponse {
                
                if response.statusCode != 200 {
                    print("Error \(response.statusCode), \(response.debugDescription)")
                    completion(nil, nil)
                } else {
                    completion(data, nil)
                }
            }
        }
        session.resume()
    }
}



// MARK: - Requests

private extension NetworkProvider {
    
    static func urlRequest(forUrl url: URL, method: HTTPMethod, body: Data?) -> URLRequest {
        
        var request = authorizedRequest(for: url)
        request.httpMethod = method.rawValue
        request.httpBody = body
        if method == .put {
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        }
        return request
    }
    
    static func authorizedRequest(for url: URL) -> URLRequest {
    
        var request = URLRequest(url: url)
        request.addValue(authorizationToken, forHTTPHeaderField: "Authorization")
        return request
    }
}



