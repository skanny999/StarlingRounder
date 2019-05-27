//
//  SavingGoal.swift
//  StarlingRounderTests
//
//  Created by Riccardo on 26/05/2019.
//  Copyright © 2019 RiccardoScanavacca. All rights reserved.
//

import XCTest
@testable import StarlingRounder

class SavingGoal: XCTestCase {

    
    override func setUp() {

    }
    
    override func tearDown() {

    }
    
    func testAccountModel() {
        let data = FileExtractor.extractJsonFile(withName: "SavingsGoal", forClass: type(of: self))
        let root = try! JSONDecoder().decode(SavingGoalsRoot.self, from: data)
        let savingGoal = root.savingsGoalList?.first
        XCTAssert(savingGoal?.savingsGoalUid == "88c38dd2-1615-4c18-a6b9-f8ec13100128")
        XCTAssert(savingGoal?.name == "Vacation")
        XCTAssert(savingGoal?.target?.currencyType == .gbp)
        XCTAssert(savingGoal?.target?.minorUnits == 200000)
        XCTAssert(savingGoal?.totalSaved?.currencyType == .gbp)
        XCTAssert(savingGoal?.totalSaved?.minorUnits == 0)
        XCTAssert(savingGoal?.savedPercentage == 0)
    }

}
