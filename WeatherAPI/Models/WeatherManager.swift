//
//  WeatherManager.swift
//  WeatherAPI
//
//  Created by Rey on 31.01.24.
//

import Foundation

protocol WeatherManagerDelegate {
    func didUpdateWeather(weather: WeatherModel)
    func didFailWithError(error: Error)
}

struct WeatherManager {
    let UNIT = "Metric"
    let LANGUAGE = "de"
    let id = "c1f5f57580ab1b3366f3392c08c20df9"
    let WEATHER_URL_BY_CITY_NAME = "https://api.openweathermap.org/data/2.5/weather?q="
    
    var delegate: WeatherManagerDelegate? // optional da eine var immer nen wert haben muss, haben wir aber nicht UND hiers weather view controller drin, da weather CV delegate übernommen hat
    
    func fetchWeather(cityName: String) {
        let urlAsSAtring = WEATHER_URL_BY_CITY_NAME + cityName + "&appid=\(id)"  + "&units=\(UNIT)" + "&lang=\(LANGUAGE)"
        print(urlAsSAtring)
        performRequest(urlString: urlAsSAtring)
    }
    
    func performRequest(urlString: String){ 
        // create URL
        guard let url =  URL(string: urlString) else { return }
        // create session
        let session = URLSession(configuration: .default)
        // 3. task erstellen, was soll url session machen:
        let task = session.dataTask(with: url) { data, URLResponse, error in
            if error != nil {
                print(error!)
                return
            }
            // wenn kein error vorhanden, dann haben wir daten:
            //da data auch ein optional ist, optional binding:
            if let _data = data { // _data -> JSON
                // umschreiben damit JSON file leserlich wird
                //let dataString = String(data: _data, encoding: .utf8)
                if let weather =  parseJSON(weatherData: _data) {
                    
                    // MARK:  weather object zum viewcontroller senden
                    self.delegate?.didUpdateWeather(weather: weather)
                }}
        }
        // 4. task starten
        task.resume()
    }
        //JSON umwandeln
        func parseJSON(weatherData: Data) -> WeatherModel?{ // parsejson hat optional rückgabe RETURN typ damit wir des an viewcontroller schicken können -
            // decoden
            let decoder = JSONDecoder()
            // put in do catch block, if it throws error
            do {
                // in decodeData sind die dekodierten daten
                let decodeData =  try decoder.decode(WeatherData.self, from: weatherData)
                // MARK: create object from decoded data
                // decoded data
                let id = decodeData.weather[0].id
                let temp = decodeData.main.temp
                let description = decodeData.weather[0].description
                let name = decodeData.name
                // Zusatzinfos decodieren aus dem JSON Format
                let sunrise = decodeData.sys.sunrise
                let sunset = decodeData.sys.sunset
                let temp_max = decodeData.main.temp_max
                let temp_min = decodeData.main.temp_min
                let pressure = decodeData.main.pressure
                let humidity = decodeData.main.humidity
                let rain = decodeData.clouds.all
                let windSpeed = decodeData.wind.speed
                // create object from decoded data
                let weather = WeatherModel(conditionId: id, cityName: name, temperature: temp, description: description, sunrise: sunrise, sunset: sunset, temp_max: temp_max, temp_min: temp_min, pressure: pressure, humidity: humidity, rain: Double(rain), windSpeed: windSpeed)
                
                return weather
                
            } catch {
                print(error)
                return nil
            }
            
            
        }
    }
