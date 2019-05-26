//
//  Transaction.swift
//  StarlingRounder
//
//  Created by Riccardo on 26/05/2019.
//  Copyright © 2019 RiccardoScanavacca. All rights reserved.
//

import Foundation

struct Transaction: Codable {
    
    let feedItemUid: String?
    let categoryUid: String?
    let amount: Amount?
    let sourceAmount: Amount?
    let direction: String?
    let updatedAt: Date?
    let transactionTime: Date?
    let settlementTime: Date?
    let source: String?
    let sourceSubType: String?
    let status: String?
    let counterPartyType: String?
    let counterPartyUid: String?
    let counterPartyName: String?
    let counterPartySubEntityUid: String?
    let reference: String?
    let country: String?
    let spendingCategory: String?
}

