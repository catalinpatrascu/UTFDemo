//
//  WeatherServiceTests.swift
//  UTFDemoTests
//
//  Created by Catalin Patrascu on 15.02.2023.
//

import XCTest
@testable import UTFDemo

final class WeatherServiceTests: XCTestCase {
    
    private var sut: WeatherService!
    private var mockSession: NetworkSessionMock!
    private let dummyCity = "Whatever"
    
    override func setUpWithError() throws {
        mockSession = NetworkSessionMock()        
        sut = WeatherService(session: mockSession)
    }

    override func tearDownWithError() throws {
        sut = nil
        mockSession = nil
    }

    func test_getTemperatureFromCity_returnsInvalidURLFromBadURL() {
        // GIVEN
        var result: Result<Double, WeatherError>?
        
        // WHEN
        sut.getTemperatureFromCity("city name with spaces resulting in bad url without escaping characters") { result = $0 }
        
        // THEN
        XCTAssertEqual(result, .failure(WeatherError.invalidURL))
    }
    
    func test_getTemperatureFromCity_returnsInvalidURLFromSession() {
        // GIVEN
        var result: Result<Double, WeatherError>?
        mockSession.error = WeatherError.invalidURL
        
        // WHEN
        sut.getTemperatureFromCity(dummyCity) { result = $0 }
        
        // THEN
        XCTAssertEqual(result, .failure(WeatherError.invalidURL))
    }
    
    func test_getTemperatureFromCity_returnsInvalidResponse() {
        // GIVEN
        var result: Result<Double, WeatherError>?
        mockSession.statusCode = 403
        
        // WHEN
        sut.getTemperatureFromCity(dummyCity) { result = $0 }
        
        // THEN
        XCTAssertEqual(result, .failure(WeatherError.invalidResponse))
    }
    
    func test_getTemperatureFromCity_returnsNoData() {
        // GIVEN
        var result: Result<Double, WeatherError>?
        
        // WHEN
        sut.getTemperatureFromCity(dummyCity) { result = $0 }
        
        // THEN
        XCTAssertEqual(result, .failure(WeatherError.noData))
    }
        
    func test_getTemperatureFromCity_returnsJsonParsingError() {
        // GIVEN
        var result: Result<Double, WeatherError>?
        mockSession.data = """
        {
            "name1": "\(dummyCity)",
            "main2": {"temp": 5.23, "humidity": 72}
        }
        """.data(using: .utf8)!
        
        // WHEN
        sut.getTemperatureFromCity(dummyCity) { result = $0 }
        
        // THEN
        XCTAssertEqual(result, .failure(WeatherError.jsonParsingError))
    }
    
    func test_getTemperatureFromCity_returnsValidData() {
        // GIVEN
        var result: Result<Double, WeatherError>?
        mockSession.data = """
        {
            "name": "London",
            "main": {"temp": 5.1, "humidity": 72}
        }
        """.data(using: .utf8)!
        
        // WHEN
        sut.getTemperatureFromCity(dummyCity) { result = $0 }
        
        // THEN
        XCTAssertEqual(result, .success(5.1))
    }
}

private class NetworkSessionMock: NetworkSession {
    var data: Data?
    var error: Error?
    var statusCode: Int = 200

    func loadData(from url: URL, completionHandler: @escaping (Data?, Int, Error?) -> Void) {
        completionHandler(data, statusCode, error)
    }
}
