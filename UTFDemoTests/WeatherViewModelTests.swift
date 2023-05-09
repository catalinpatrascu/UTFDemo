//
//  WeatherViewModelTests.swift
//  UTFDemoTests
//
//  Created by Catalin Patrascu on 15.02.2023.
//

import XCTest
@testable import UTFDemo

final class WeatherViewModelTests: XCTestCase {
    
    private var sut: WeatherViewModel!
    private var mockService: WeatherServiceMock!
    private let dummyCity = "Whatever"
    
    override func setUpWithError() throws {
        mockService = WeatherServiceMock()
        sut = WeatherViewModel(weatherService: mockService)
    }

    override func tearDownWithError() throws {
        sut = nil
        mockService = nil
    }
    
    func test_onStart_returnsDefaultText() {
        // GIVEN
        var result: String?
        sut.temperatureChanged = { result = $0 }
        
        // WHEN
        sut.onStart()
        
        // THEN
        XCTAssertEqual(result, "The current temperature in Constanta,RO is unknown atm.")
    }
    
    func test_getCurrentTemperature_returnSuccess() {
        // GIVEN
        var result: String?
        sut.temperatureChanged = { result = $0 }
        
        mockService.result = .success(3.1)
        
        // WHEN
        sut.getCurrentTemperature()
        
        // THEN
        XCTAssertEqual(mockService.cityParameterLastCall, "Constanta,RO")
        XCTAssertEqual(result, "The current temperature in Constanta,RO is 3.1 °C.")
    }
    
    func test_getCurrentTemperature_failsWithError() {
        // GIVEN
        var result: String?
        sut.temperatureChanged = { result = $0 }
        
        mockService.result = .failure(.noData)
        
        // WHEN
        sut.getCurrentTemperature()
        
        // THEN
        XCTAssertEqual(mockService.cityParameterLastCall, "Constanta,RO")
        XCTAssertEqual(result, "The current temperature in Constanta,RO is unknown due to noData.")
    }
}

private class WeatherServiceMock: WeatherServiceable {
    var cityParameterLastCall: String?
    var result: Result<Double, UTFDemo.WeatherError>?
    
    func getTemperatureFromCity(_ cityName: String, completion: @escaping (Result<Double, UTFDemo.WeatherError>) -> Void) {
        cityParameterLastCall = cityName // it spies on this one
        completion(result!)
    }
}
