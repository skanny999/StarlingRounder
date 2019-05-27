//
//  DataProvider.swift
//  StarlingRounder
//
//  Created by Riccardo on 26/05/2019.
//  Copyright © 2019 RiccardoScanavacca. All rights reserved.
//

import Foundation

class DataManager {
    
    static func getAccount(completion:@escaping(Account?, Error?) -> Void) {
        
        NetworkProvider.getAccountData { (data: Data?, error: Error?) in
            if let error = error {
                completion(nil, error)
                return
            }
            
            guard let data = data else {
                completion(nil, nil)
                return
            }
            
            DataProcessor.processAccountsData(data, completion: { (account, error) in
                completion(account, error)
            })
        }
    }
    
    static func getSavingGoal(forAccount account: Account, completion:@escaping(SavingGoal?, Error?) -> Void) {
        
        NetworkProvider.getSavingGoalData(forAccount: account) { (data: Data?, error: Error?) in
            if let error = error {
                completion(nil, error)
                return
            }
            
            guard let data = data else {
                completion(nil, nil)
                return
            }
            
            DataProcessor.processSavingGoalData(data, completion: { (savingGoal, error) in
                completion(savingGoal, error)
            })
        }
    }
    
    static func getTransactions(for account: Account, completion: @escaping([Transaction]?, Error?) -> Void) {
        
        NetworkProvider.getTransactionsData(forAccont: account) { (data: Data?, error: Error?) in
            if let error = error {
                completion(nil, error)
                return
            }
            
            guard let data = data else {
                completion(nil, nil)
                return
            }
            
            DataProcessor.processTransactionsData(data, completion: { (transactions, error) in
                completion(transactions, error)
            })
        }
    }
    
    
    static func transferMoney(_ amount: Int, from account: Account, toSavingGoal saving: SavingGoal, completion:@escaping(Bool, String?) -> Void) {
        
        NetworkProvider.putTransferMoney(amount, from: account, toSavingGoal: saving) { (data, error) in
            if let error = error {
                completion(false, error.localizedDescription)
                return
            }
            
            guard let data = data else {
                completion(false, nil)
                return
            }
            
            DataProcessor.processTransferResult(data, completion: { (success, message) in
                
                completion(success, message)
            })
        }
    }
    
    
    
}
