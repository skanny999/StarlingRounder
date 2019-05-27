//
//  Int+Utils.swift
//  StarlingRounder
//
//  Created by Riccardo on 26/05/2019.
//  Copyright © 2019 RiccardoScanavacca. All rights reserved.
//

import Foundation

extension Int {
    
    var toWholeCurrency: String {
        
        let wholeCurrency = Float(self)
        return String(format: "%.2f", wholeCurrency / 100)
    }
}
