//
//  WeatherModel.swift
//  WeatherAPI
//
//  Created by Rey on 31.01.24.
//


import Foundation

struct WeatherModel {

    let conditionId: Int
    let cityName: String
    let temperature: Double
    let description: String
    
   
    let sunrise: Double
    let sunset: Double
    let temp_max: Double
    let temp_min: Double
    let pressure: Int
    let humidity: Int
    let rain: Double
    let windSpeed: Double
    
    //  computed property -> value will always be calculated
    
    var tempToString: String {
        return String(format: "%.1f", temperature)
}
    
    var conditionName: String {
        switch conditionId {
        case 200...232:
            
            return "cloud.bolt"
        case 300...321:
            return "cloud.drizzle"
        case 500...531:
            return "cloud.rain"
        case 600...622:
            return "cloud.snow"
        case 701...781:
            return "cloud.fog"
        case 800:
            return "sun.max"
        case 801...804:
            return "cloud.bolt"
        default:
            return "cloud"
        
        }
    }
}
