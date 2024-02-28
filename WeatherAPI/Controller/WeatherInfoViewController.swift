//
//  WeatherInfoViewController.swift
//  WeatherAPI
//
//  Created by Rey on 30.01.24.
//


import UIKit

class WeatherInfoViewController: UIViewController {
    
    @IBOutlet weak var sunriseLabel: UILabel!
    @IBOutlet weak var sunsetLabel: UILabel!
    @IBOutlet weak var maxTempLabel: UILabel!
    @IBOutlet weak var minTemplabel: UILabel!
    @IBOutlet weak var luftdruckLabel: UILabel!
    @IBOutlet weak var luftfeuchtigkeitLabel: UILabel!
    @IBOutlet weak var rainLabel: UILabel!
    @IBOutlet weak var windSpeedLabel: UILabel!
    
    var WeatherInfoObject :  WeatherModel? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        showData(weatherObject: WeatherInfoObject)
    }
    
    func showData(weatherObject: WeatherModel?) {
        guard let weatherDtata = weatherObject else {return}
        
        sunriseLabel.text = "Sunrise \(createTime(time: weatherDtata.sunrise))"
        sunsetLabel.text = "Sonnenuntergang: \(createTime(time: weatherDtata.sunset))"
        maxTempLabel.text = "Max Temp: \(weatherDtata.temp_max)°"
        minTemplabel.text = "Min Temp: \(weatherDtata.temp_min)°"
        luftdruckLabel.text = "Luftdruck: \(weatherDtata.pressure)hPa"
        luftfeuchtigkeitLabel.text = "Luftfeuchtigkeit: \(weatherDtata.humidity)%"
        rainLabel.text = "Regen: \(weatherDtata.rain)%"
        windSpeedLabel.text = "Windgeschwindigkeit: \(weatherDtata.windSpeed)m/s"
        
    }
    // adjust sunrise etc. time
    func createTime(time: Double) -> String{
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm:ss"
        let dateTime = Date(timeIntervalSince1970: time) // returns time
        let timeToString = formatter.string(from: dateTime)
        
        return timeToString
        
    }
}
