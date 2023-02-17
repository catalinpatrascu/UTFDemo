//
//  WeatherData.swift
//  UTFDemo
//
//  Created by Catalin Patrascu on 15.02.2023.
//

import Foundation

struct WeatherData: Codable {
    let name: String
    let main: Main
}

struct Main: Codable {
    let temp: Double
    let humidity: Int
}
