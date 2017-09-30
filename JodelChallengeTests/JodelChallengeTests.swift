//
//  JodelChallengeTests.swift
//  JodelChallengeTests
//
//  Created by Michal Ciurus on 21/09/2017.
//  Copyright © 2017 Jodel. All rights reserved.
//

import XCTest
@testable import JodelChallenge

class JodelChallengeTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testPageInfo() {
      
      let cell_0 = SwiftyCollectionCell(); cell_0.row = 1
      let cell_1 = SwiftyCollectionCell(); cell_1.row = 35
      let cell_2 = SwiftyCollectionCell(); cell_2.row = 45
      let cell_3 = SwiftyCollectionCell(); cell_3.row = 49
      let cell_4 = SwiftyCollectionCell(); cell_4.row = 100
      
      // CASE 1: normal small range
      let case1 = [cell_1, cell_2].pageInfo()!
      XCTAssert(case1.page == 3)
      XCTAssert(case1.perPage == 15)
      
      // CASE 2: when just one cell
      let case2 = [cell_1].pageInfo()!
      XCTAssert(case2.page == 3)
      XCTAssert(case2.perPage == 15)
      
      // CASE 3: when one cell which happens to be last item the last one
      let case3 = [cell_1].pageInfo(total: 40)!
      XCTAssert(case3.page == 3)
      XCTAssert(case3.perPage == 15)
      
      // CASE 4: when contains first page item, limit results to 20
      let case4 = [cell_0, cell_4].pageInfo()!
      XCTAssert(case4.page == 1)
      XCTAssert(case4.perPage == 20)
      
      // CASE 5: when page 1, but we just have 10, less than limit
      let case5 = [cell_0].pageInfo(total: 10)!
      XCTAssert(case5.page == 1)
      XCTAssert(case5.perPage == 10)
      
      // CASE 6: when the array is empty
      let case6 = [].pageInfo()
      XCTAssert(case6 == nil)
      
      // CASE 6: check if page size overflows
      for i in 1...1000 {
        let cell = SwiftyCollectionCell()
        cell.row = Int16(i)
        XCTAssert([cell].pageInfo()!.perPage < 40)
      }
    }
}
