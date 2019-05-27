//
//  Transaction.swift
//  StarlingRounderTests
//
//  Created by Riccardo on 26/05/2019.
//  Copyright © 2019 RiccardoScanavacca. All rights reserved.
//

import XCTest
@testable import StarlingRounder

class Transaction: XCTestCase {

    var transactionData: Data?
    var decoder: JSONDecoder!
    
    override func setUp() {
        transactionData = FileExtractor.extractJsonFile(withName: "Transaction", forClass: type(of: self))
        
    }
    
    override func tearDown() {
        transactionData = nil
    }
    
    func testAccountModel() {
        
        let root = try! JSONDecoder().decode(TransactionsRoot.self, from: transactionData!)
        let transaction = root.transactions?.first
        XCTAssert(transaction?.feedItemUid == "70fee09e-4c70-402b-b7c9-26f20b9dc3e8")
        XCTAssert(transaction?.categoryUid == "1514238e-52da-4ff0-9374-b5843ef90fe5")
        XCTAssert(transaction?.amount?.currencyType == .gbp)
        XCTAssert(transaction?.amount?.minorUnits == 3675)
        XCTAssert(transaction?.sourceAmount?.currencyType == .gbp)
        XCTAssert(transaction?.sourceAmount?.minorUnits == 3675)
        XCTAssert(transaction?.direction == "OUT")
        XCTAssert(transaction?.source == "MASTER_CARD")
        XCTAssert(transaction?.sourceSubType == "CHIP_AND_PIN")
        XCTAssert(transaction?.status == "SETTLED")
        XCTAssert(transaction?.counterPartyUid == "a62b802a-e675-4f54-ae9f-f1065e40e905")
        XCTAssert(transaction?.counterPartyType == "MERCHANT")
        XCTAssert(transaction?.counterPartyName == "593ed4b2-232d-4bb0-Bdf4-E5ab7fb3b1a1gb")
        XCTAssert(transaction?.counterPartySubEntityUid == "9f9cabe9-2fc0-4a9c-bd4f-fe93f4ee9509")
        XCTAssert(transaction?.reference == "  69e70436-7ff0-4b43-9eb8-eaabd1aeff9bGB")
        XCTAssert(transaction?.country == "GB")
        XCTAssert(transaction?.spendingCategory == "GENERAL")
        XCTAssert(transaction?.updatedAt?.component.day == 26)
        XCTAssert(transaction?.updatedAt?.component.hour == 12)
        XCTAssert(transaction?.transactionTime?.component.year == 2019)
        XCTAssert(transaction?.transactionTime?.component.month == 5)
        XCTAssert(transaction?.settlementTime?.component.day == 26)
        XCTAssert(transaction?.settlementTime?.component.hour == 11)
        
        
    }
}
