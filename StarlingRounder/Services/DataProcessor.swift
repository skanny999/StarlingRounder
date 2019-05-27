//
//  DataProcessor.swift
//  StarlingRounder
//
//  Created by Riccardo on 26/05/2019.
//  Copyright © 2019 RiccardoScanavacca. All rights reserved.
//

import Foundation

class DataProcessor {

    static func processAccountsData(_ data: Data, completion:@escaping(Account?, Error?) -> Void) {
        
        do {
            let root = try JSONDecoder().decode(AccountsRoot.self, from: data)
            completion(root.accounts?.first, nil)
        } catch {
            completion(nil, error)
        }
    }
    
    static func processSavingGoalData(_ data: Data, completion: @escaping (SavingGoal?, Error?) -> Void) {
        
        do {
            let root = try JSONDecoder().decode(SavingGoalsRoot.self, from: data)
            completion(root.savingsGoalList?.first, nil)
        } catch {
            completion(nil, error)
        }
    }
    
    static func processTransactionsData(_ data: Data, completion: @escaping ([Transaction]?, Error?) -> Void) {
        
        do {
            let root = try JSONDecoder().decode(TransactionsRoot.self, from: data)
            let sortedTransactions = root.transactions?.sorted(by:{ $0.updatedAt ?? Date() > $1.updatedAt ?? Date()})
            completion(sortedTransactions, nil)
        } catch {
            completion(nil, error)
        }
    }
    
    static func processTransferResult(_ data: Data, completion: @escaping (Bool, String?) -> Void) {
        
        do {
            let response = try JSONDecoder().decode(TransferResponce.self, from: data)
            let success = response.success ?? false
            let message = response.errors?.first?.message
            completion(success, message)
            
        } catch {
            completion(false, error.localizedDescription)
        }
    }
}


