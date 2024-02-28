//
//  WeatherData.swift
//  WeatherAPI
//
//  Created by Rey on 31.01.24.
//

import Foundation

// use protocol "decodable"
struct WeatherData: Decodable {
    let name: String
    let main: Main
    let wind: Wind
    let sys: Sys
    let clouds: Clouds
    // since weather is an object within an array:
    let weather: [Weather]
}

// for objectas use struct and decodable

struct Main: Decodable {
    let temp: Double
    let temp_min: Double
    let temp_max: Double
    let pressure: Int
    let humidity: Int
    
}

struct Wind: Decodable {
    let speed: Double
}

struct Sys: Decodable {
    let sunrise: Double
    let sunset: Double
}

struct Clouds: Decodable {
    let all: Int
}

struct Weather: Decodable {
    let id: Int
    let description: String
}
