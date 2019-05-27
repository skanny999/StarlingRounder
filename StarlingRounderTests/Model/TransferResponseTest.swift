//
//  TRansferResponseTest.swift
//  StarlingRounderTests
//
//  Created by Riccardo on 27/05/2019.
//  Copyright © 2019 RiccardoScanavacca. All rights reserved.
//


import XCTest
@testable import StarlingRounder

class TransferResponse: XCTestCase {
    
    override func setUp() {
        
    }
    
    override func tearDown() {
        
    }
    
    func testAccountModel() {
        let responseData = FileExtractor.extractJsonFile(withName: "TransferResponse", forClass: type(of: self))
        let response = try! JSONDecoder().decode(TransferResponce.self, from: responseData)
        
        XCTAssert(response.transferUid == "d8770f9d-4ee9-4cc1-86e1-83c26bcfcc4f")
        XCTAssert(response.success == true)
        XCTAssert(response.errors?.first?.message == "Something about the validation error")
    }
    
}
