//
//  AccountTest.swift
//  StarlingRounderTests
//
//  Created by Riccardo on 26/05/2019.
//  Copyright © 2019 RiccardoScanavacca. All rights reserved.
//

import XCTest
@testable import StarlingRounder

class AccountTest: XCTestCase {
    
    var accountData: Data?
    var decoder: JSONDecoder!

    override func setUp() {
        accountData = FileExtractor.extractJsonFile(withName: "Accounts", forClass: type(of: self))

    }

    override func tearDown() {
        accountData = nil
    }
    
    func testAccountModel() {
        
        let root = try! JSONDecoder().decode(AccountsRoot.self, from: accountData!)
        let account = root.accounts?.first
        XCTAssert(account?.accountUid == "70fd5f31-7115-4696-b3e3-074644e6d8e8")
        XCTAssert(account?.defaultCategory == "1514238e-52da-4ff0-9374-b5843ef90fe5")
        XCTAssert(account?.currencyType == .gbp)
        XCTAssert(account?.createdAt?.component.day == 26)
        XCTAssert(account?.createdAt?.component.hour == 11)

        
    }

}
