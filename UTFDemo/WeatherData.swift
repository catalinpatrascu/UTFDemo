//
//  WeatherData.swift
//  UTFDemo
//
//  Created by Catalin Patrascu on 15.02.2023.
//

import Foundation

struct WeatherData: Decodable {
    let name: String
    let main: Main
}

struct Main: Decodable {
    let temp: Double
    let humidity: Int
}

enum WeatherDataMapper {
    static func map(dataJSON: Data) -> WeatherData? {
        let weatherData = try? JSONDecoder().decode(WeatherData.self, from: dataJSON)
        return weatherData
    }
}
