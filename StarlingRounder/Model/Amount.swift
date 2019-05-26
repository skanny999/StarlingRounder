//
//  Amount.swift
//  StarlingRounder
//
//  Created by Riccardo on 26/05/2019.
//  Copyright © 2019 RiccardoScanavacca. All rights reserved.
//

import Foundation

struct Amount: Codable {
    
    let currencyRaw: String?
    let minorUnits: Int?
    var currency: Currency? {
        return Currency(rawValue: currencyRaw ?? "")
    }
    
}
