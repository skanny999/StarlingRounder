//
//  SavingGoalViewModel.swift
//  StarlingRounder
//
//  Created by Riccardo on 27/05/2019.
//  Copyright © 2019 RiccardoScanavacca. All rights reserved.
//

import Foundation

struct SavingGoalViewData {
    
    let savingGoal: SavingGoal
    
    var name: String {
        return savingGoal.name ?? "N/A"
    }
    
    var amount: String {
        guard  let amount = savingGoal.totalSaved?.minorUnits,
            let currency = savingGoal.totalSaved?.currencyType else {
                return "N/A"
        }
        return "\(currency.symbol) \(amount.toWholeCurrency)"
    }
    
    var savingGoalTarget: String {
        
        guard  let amount = savingGoal.target?.minorUnits,
            let currency = savingGoal.target?.currencyType else {
                return "N/A"
        }
        return "\(currency.symbol) \(amount.toWholeCurrency)"
    }
    
    var percentageReached: String {
        
        guard let percentage = savingGoal.savedPercentage else {
            return "N/A"
        }
        return "\(percentage)%"
    }
}
