//
//  String+Utils.swift
//  StarlingRounder
//
//  Created by Riccardo on 26/05/2019.
//  Copyright © 2019 RiccardoScanavacca. All rights reserved.
//

import Foundation

extension String {
    
    var dateValue: Date? {
        
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_GB")
        dateFormatter.timeZone = TimeZone.autoupdatingCurrent
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        let dateString = self.count > 19 ? String(self[..<self.index(self.startIndex, offsetBy: 19)]) : self
        
        return  dateFormatter.date(from:dateString)
    }
}
