//
//  TwitSplit_ZaloraTests.swift
//  TwitSplit-ZaloraTests
//
//  Created by Đăng Trình on 4/17/19.
//  Copyright © 2019 Dang Trinh. All rights reserved.
//

import XCTest
@testable import TwitSplit_Zalora

class TwitSplit_ZaloraTests: XCTestCase {
    
    var splitter = TwitSplitZalora()
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testMessageShorter() {
        
        let input = "This test used for message shorter than limit"
        let expected = ["This test used for message shorter than limit"]
        
        let output = splitter.splitMessage(message: input, limit: 50)
        
        XCTAssertEqual(output.result.count, 1, "Result: 1 components")
        XCTAssertEqual(output.result, expected, "Expected: Short Message should be same the original")
    }
    
    func testMessageHaveWordLongerThanLimit() {
        
        let input = "<=======THIS_MESSAGE_LONGER_THAN_LIMIT_CHARACTER=======>"
        
        let expected = "The message contains a span of non-whitespace characters longer than 50 characters"
        
        let output = splitter.splitMessage(message: input, limit: 50)
        
        XCTAssertEqual(output.errorMessage, expected)
        
    }
    
    func testSplitMessage() {
        let input = "An opportunity to work and upgrade oneself, as well as being involved in an organizationstrongly believing in gaining a competitive edge and giving back to the community. I am presently expanding my solid experience in developing mobile software. I focus on using my interpersonal skill to build a good user experience and create a good impression."
        let expected = ["1/9 An opportunity to work and upgrade oneself, ", "2/9 as well as being involved in an ", "3/9 organizationstrongly believing in gaining a ", "4/9 competitive edge and giving back to the ", "5/9 community. I am presently expanding my solid ", "6/9 experience in developing mobile software. I ", "7/9 focus on using my interpersonal skill to ", "8/9 build a good user experience and create a ", "9/9 good impression. "]
        
        let output = splitter.splitMessage(message: input, limit: 50)
        XCTAssertEqual(output.result, expected)
        
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
