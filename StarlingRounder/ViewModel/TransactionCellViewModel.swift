//
//  TransactionCellViewModel.swift
//  StarlingRounder
//
//  Created by Riccardo on 27/05/2019.
//  Copyright © 2019 RiccardoScanavacca. All rights reserved.
//

import Foundation

struct TransactionCellData {
    
    let transaction: Transaction
    
    var category: String {
        return transaction.spendingCategory ?? "N/A"
    }
    
    var date: String {
        return transaction.updatedAt.longDescription ?? "No date available"
    }
    
    var amount: String {
        
        guard let pence = transaction.amount?.minorUnits,
            let currency = transaction.amount?.currencyType,
            let direction = transaction.direction else {
                return "N/A"
        }
        
        let prefix = direction == "OUT" ? "- " : ""
        let formattedAmount = pence.toWholeCurrency
        
        return "\(prefix)\(currency.symbol)\(formattedAmount)"
    }

}
