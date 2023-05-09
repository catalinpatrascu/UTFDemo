//
//  Weather.swift
//  UTFDemo
//
//  Created by Catalin Patrascu on 15.02.2023.
//

import Foundation

struct Weather: Decodable {
    let name: String
    let main: Main
}

struct Main: Decodable {
    let temp: Double
    let humidity: Int
}

enum WeatherDataMapper {
    static func map(dataJSON: Data) -> Weather? {
        let weatherData = try? JSONDecoder().decode(Weather.self, from: dataJSON)
        return weatherData
    }
}
