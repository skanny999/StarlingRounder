//
//  Account.swift
//  StarlingRounder
//
//  Created by Riccardo on 26/05/2019.
//  Copyright © 2019 RiccardoScanavacca. All rights reserved.
//

import Foundation

struct Account: Codable {
    
    let accountUid: String
    let defaultCategory: String
    let currency: String
    let createdAt: Date    
}
