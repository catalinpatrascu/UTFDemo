//
//  WeatherService.swift
//  UTFDemo
//
//  Created by Catalin Patrascu on 15.02.2023.
//

import Foundation

enum WeatherError: Error {
    case invalidURL
    case invalidResponse
    case noData
    case jsonParsingError
}

protocol WeatherServiceable {
    func getTemperatureFromCity(_ cityName: String, completion: @escaping (Result<Double, WeatherError>) -> Void)
}

struct WeatherService: WeatherServiceable {
    private let session: NetworkSession
    
    init(session: NetworkSession = URLSession.shared) {
        self.session = session
    }
    
    func getTemperatureFromCity(_ cityName: String, completion: @escaping (Result<Double, WeatherError>) -> Void) {
        let weatherApiUrl = URL(string: "https://api.openweathermap.org/data/2.5/weather?q=\(cityName)&units=metric&appid=\(APIKeys.weather.rawValue)")
        
        guard let weatherApiUrl = weatherApiUrl else {
            completion(.failure(.invalidURL))
            return
        }
        
        session.loadData(from: weatherApiUrl) { data, statusCode, error in
            if let _ = error {
                completion(.failure(.invalidURL))
                return
            }
            
            guard (200...299).contains(statusCode) else {
                completion(.failure(.invalidResponse))
                return
            }
            
            guard let data = data else {
                completion(.failure(.noData))
                return
            }
            
            guard let weather = WeatherMapper.map(dataJSON: data) else {
                completion(.failure(.jsonParsingError))
                return
            }
            
            completion(.success(weather.main.temp))
        }
    }
}
