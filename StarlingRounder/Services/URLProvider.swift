//
//  URLProvider.swift
//  StarlingRounder
//
//  Created by Riccardo on 26/05/2019.
//  Copyright © 2019 RiccardoScanavacca. All rights reserved.
//

import Foundation

struct URLProvider {

    static func accountsURL() -> URL? {
        
        return url(forEndpoint: accountsEndpoint)
    }
    
    static func savingAccountsURL(forAccountUid accountUid: String?) -> URL? {
        guard let uid = accountUid else { return nil }
        return url(forEndpoint: savingAccountsEndpoint(forAccountUid: uid))
    }
    
    static func transactionUrl(forAccountUid accountUid: String?, category: String?, sinceDate date: Date?) -> URL? {
        
        guard let uid = accountUid,
            let category = category,
            let date = date else { return nil }
        
        return url(forEndpoint: transactionsEndpoint(forAccountUid: uid, category: category, sinceDate: date))
    }
    
    static func savingTransferUrl(fromAccountUid fromUid: String?, toSavingGoalUid toUid: String?) -> URL? {
        guard let accountUid = fromUid, let savingGoalUid = toUid else { return nil }
        
        return url(forEndpoint: transferEndpoint(from: accountUid, to: savingGoalUid))
    }
    
}

private extension URLProvider {
    
    static let baseUrl = "https://api-sandbox.starlingbank.com/api/v2"
    static let accountsEndpoint = "/accounts"
    
    static func url(forEndpoint endpoint: String) -> URL? {
        
        return URL(string: "\(baseUrl)\(endpoint)")
    }
    
    static func savingAccountsEndpoint(forAccountUid accountUid: String) -> String {
        
        return "/account/\(accountUid)/savings-goals"
    }
    
    static func transferEndpoint(from accountUid: String, to savingUid: String) -> String {
        
        let generatedUuid = UUID().uuidString
        return "\(savingAccountsEndpoint(forAccountUid: accountUid))/\(savingUid)/add-money/\(generatedUuid)"
    }
    
    static func transactionsEndpoint(forAccountUid accountUid: String, category: String, sinceDate date: Date) -> String {
        
        return "/feed/account/\(accountUid)/category/\(category)?changesSince=\(date.iso8601)"
    }
}
