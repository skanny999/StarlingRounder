//
//  Date+Utils.swift
//  StarlingRounder
//
//  Created by Riccardo on 26/05/2019.
//  Copyright © 2019 RiccardoScanavacca. All rights reserved.
//

import Foundation

extension ISO8601DateFormatter {
    
    convenience init(_ formatOptions: Options, timeZone: TimeZone = TimeZone(secondsFromGMT: 0)!) {
        self.init()
        self.formatOptions = formatOptions
        self.timeZone = timeZone
    }
}

extension Formatter {
    
    static let iso8601 = ISO8601DateFormatter([.withInternetDateTime, .withFractionalSeconds])
}

extension Date {
    
    var iso8601: String {
        return Formatter.iso8601.string(from: self)
    }
    
    var lastWeek: Date? {
        return Calendar.current.date(byAdding: .day, value: -7, to: Date())
    }
    
    var component: (day: Int, month: Int, year: Int, hour: Int) {
        
        let calendar = Calendar.current
        let day = calendar.component(.day, from: self)
        let month = calendar.component(.month, from: self)
        let hour = calendar.component(.hour, from: self)
        let year = calendar.component(.year, from: self)
        
        return (day: day, month: month, year: year , hour:hour)
    }
}

extension Optional where Wrapped == Date {
    
    var longDescription: String? {
        
        guard let date = self else { return nil }
        
        let formatter = DateFormatter()
        formatter.dateStyle = .long
        formatter.timeStyle = .short
        
        return formatter.string(from: date)
    }
}
