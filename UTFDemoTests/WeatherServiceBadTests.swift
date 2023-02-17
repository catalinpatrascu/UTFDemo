//
//  WeatherServiceBadTests.swift
//  UTFDemoTests
//
//  Created by Catalin Patrascu on 15.02.2023.
//

import XCTest
@testable import UTFDemo

final class WeatherServiceBadTests: XCTestCase {
    
    private var sut: WeatherService!
    
    override func setUpWithError() throws {
        sut = WeatherService()
    }

    override func tearDownWithError() throws {
        sut = nil
    }

    func test_getTemperatureFromCity_hittingNetwork() {
        // GIVEN
        let expectation = self.expectation(description: "Expecting weather data")
        var temperatureResult: Double?
        
        // WHEN
        sut.getTemperatureFromCity("Constanta") { result in
            switch result {
            case .success(let temperature):
                temperatureResult = temperature
                expectation.fulfill()
            case .failure(let error):
                XCTFail("Error fetching weather data: \(error)")
            }
        }
        
        waitForExpectations(timeout: 10, handler: nil)
        
        // THEN
        XCTAssertNotNil(temperatureResult)
    }
}
