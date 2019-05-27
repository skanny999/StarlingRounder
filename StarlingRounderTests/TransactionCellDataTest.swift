//
//  TransactionCellDataTest.swift
//  StarlingRounderTests
//
//  Created by Riccardo on 26/05/2019.
//  Copyright © 2019 RiccardoScanavacca. All rights reserved.
//

import XCTest
@testable import StarlingRounder

class TransactionCellDataTest: XCTestCase {
    
    override func setUp() {

    }
    
    override func tearDown() {

    }
    
    func testCellDataModel() {
        
        let transactionData = FileExtractor.extractJsonFile(withName: "Transaction", forClass: type(of: self))
        let root = try! JSONDecoder().decode(TransactionsRoot.self, from: transactionData)
        let transaction = root.transactions?.first
        let cellData = TransactionCellData(transaction: transaction!)
        
        XCTAssert(cellData.amount == "- £36.75", cellData.amount)
        XCTAssert(cellData.category == "GENERAL")
    }

}
