//
//  SavingGoal.swift
//  StarlingRounder
//
//  Created by Riccardo on 26/05/2019.
//  Copyright © 2019 RiccardoScanavacca. All rights reserved.
//

import Foundation

struct SavingGoal: Codable {
    let savingGoalUid: String?
    let name: String?
    let savedPercentage: Int?
    let target: Amount
    let totalSaved: Amount
    
}

