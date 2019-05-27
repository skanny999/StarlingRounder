//
//  SavingGoal.swift
//  StarlingRounder
//
//  Created by Riccardo on 26/05/2019.
//  Copyright © 2019 RiccardoScanavacca. All rights reserved.
//

import Foundation

struct SavingGoalsRoot: Codable {
    let savingsGoalList: [SavingGoal]?
}

struct SavingGoal: Codable {
    let savingsGoalUid: String?
    let name: String?
    let savedPercentage: Int?
    let target: Amount?
    let totalSaved: Amount?
}

