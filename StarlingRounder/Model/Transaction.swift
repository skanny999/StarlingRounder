//
//  Transaction.swift
//  StarlingRounder
//
//  Created by Riccardo on 26/05/2019.
//  Copyright © 2019 RiccardoScanavacca. All rights reserved.
//

import Foundation

struct TransactionsRoot: Codable {
    
    enum CodingKeys: String, CodingKey {
        case transactions = "feedItems"
    }
    
    let transactions: [Transaction]?
}

struct Transaction: Codable {
    
    enum CodingKeys: String, CodingKey {
        
        case feedItemUid
        case categoryUid
        case amount
        case sourceAmount
        case direction
        case updatedAtString = "updatedAt"
        case transactionTimeString = "transactionTime"
        case settlementTimeString = "settlementTime"
        case source
        case sourceSubType
        case status
        case counterPartyType
        case counterPartyUid
        case counterPartyName
        case counterPartySubEntityUid
        case reference
        case country
        case spendingCategory
    }
    
    var updatedAt: Date? {
        return updatedAtString?.dateValue
    }
    var transactionTime: Date? {
        return transactionTimeString?.dateValue
    }
    var settlementTime: Date? {
        return settlementTimeString?.dateValue
    }
    let feedItemUid: String?
    let categoryUid: String?
    let amount: Amount?
    let sourceAmount: Amount?
    let direction: String?
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
    
    private let updatedAtString: String?
    private let transactionTimeString: String?
    private let settlementTimeString: String?
}

