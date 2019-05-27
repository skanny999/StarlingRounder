//
//  TransferResponse.swift
//  StarlingRounder
//
//  Created by Riccardo on 27/05/2019.
//  Copyright © 2019 RiccardoScanavacca. All rights reserved.
//

import Foundation

//body

struct TransferBody: Codable {

    let amount: Amount?
}

//response

struct TransferResponce: Codable {
    
    let transferUid: String?
    let success: Bool?
    let errors: [ErrorMessage]?
}

struct ErrorMessage: Codable {
    
    let message: String?
}
