//
//  Account.swift
//  StarlingRounder
//
//  Created by Riccardo on 26/05/2019.
//  Copyright © 2019 RiccardoScanavacca. All rights reserved.
//

import Foundation

struct AccountsRoot: Codable {
    let accounts: [Account]?
}

struct Account: Codable {
    
    enum CodingKeys: String, CodingKey {
        case accountUid
        case defaultCategory
        case currency
        case createdAtString = "createdAt"
    }
    
    var currencyType: Currency? {
        return Currency(rawValue: currency ?? "")
    }
    let currency: String?
    let accountUid: String?
    let defaultCategory: String?

    var createdAt: Date? {
        return createdAtString?.dateValue
    }
    private let createdAtString: String?
}
