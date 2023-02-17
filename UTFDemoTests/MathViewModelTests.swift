//
//  MathViewModelTests.swift
//  UTFDemoTests
//
//  Created by Catalin Patrascu on 15.02.2023.
//

import XCTest
@testable import UTFDemo

final class MathViewModelTests: XCTestCase {
    private var sut: MathViewModel!
    
    override func setUpWithError() throws {
        sut = MathViewModel()
    }

    override func tearDownWithError() throws {
        sut = nil
    }
    
    func test_add_withInvalidValues() throws {
        let result1 = sut.add(nil, and: nil)
        let result2 = sut.add("1", and: nil)
        
        XCTAssertEqual(result1, 0)
        XCTAssertEqual(result2, 0)
    }
    
    func test_add_withValidValues() throws {
        let result1 = sut.add("0", and: "0")
        let result2 = sut.add("1", and: "2")
        let result3 = sut.add("1", and: "-2")
        
        XCTAssertEqual(result1, 0)
        XCTAssertEqual(result2, 3)
        XCTAssertEqual(result3, -1)
    }
    
    func test_substract_withInvalidValues() throws {
        let result1 = sut.substract(nil, and: nil)
        let result2 = sut.substract("1", and: nil)
        
        XCTAssertEqual(result1, 0)
        XCTAssertEqual(result2, 0)
    }
    
    func test_substract_withValidValues() throws {
        let result1 = sut.substract("0", and: "0")
        let result2 = sut.substract("1", and: "2")
        let result3 = sut.substract("1", and: "-2")
        
        XCTAssertEqual(result1, 0)
        XCTAssertEqual(result2, -1)
        XCTAssertEqual(result3, 3)
    }
}
