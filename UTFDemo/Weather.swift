//
//  Weather.swift
//  UTFDemo
//
//  Created by Catalin Patrascu on 15.02.2023.
//

import Foundation

struct Weather {
    let name: String
    let main: Main
}

struct Main {
    let temp: Double
    let humidity: Int
}

// Networking mapping
enum WeatherMapper {
    static func map(dataJSON: Data) -> Weather? {
        try? JSONDecoder().decode(JSONWeather.self, from: dataJSON).model
    }
    
    private struct JSONWeather: Decodable {
        let name: String
        let main: JSONMain
        
        var model: Weather {
            Weather(name: name, main: main.model)
        }
    }

    private struct JSONMain: Decodable {
        let temp: Double
        let humidity: Int
                
        var model: Main {
            Main(temp: temp, humidity: humidity)
        }
    }
}
