//
//  ViewController.swift
//  WeatherAPI
//
//  Created by Rey on 30.01.24.
//

import UIKit

class WeatherViewController: UIViewController, UISearchTextFieldDelegate, WeatherManagerDelegate {

    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var tempLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var weatherImageView: UIImageView!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var searchTextField: UITextField!
    
    var timer = Timer()
    var weatherManager = WeatherManager()
    var _weatherInfoObject : WeatherModel? = nil
    // user will be able to click on screen only if they input data
    var isData = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchTextField.delegate = self
        weatherManager.delegate = self
        
        //timer and date
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(self.currentTime), userInfo: nil, repeats: true)
        setDate()
    }
    
    // click search button
    @IBAction func searchPressed(_ sender: UIButton) {
        searchTextField.endEditing(true)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        if isData == true {
            
            performSegue(withIdentifier: "moreWeatherInfo", sender: nil)
        }
    }
    
    //
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "moreWeatherInfo" {
            let weatherInfoVC = segue.destination as! WeatherInfoViewController
            weatherInfoVC.WeatherInfoObject = _weatherInfoObject
        }
        
    }
    
    // load time
    @objc func currentTime() {
        let formatter =  DateFormatter()
        formatter.dateFormat = "HH:mm:ss"
        timeLabel.text = formatter.string(from: Date())
        
    }
    
    // show date
    func setDate() {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.yy"
        formatter.locale = Locale(identifier: "en_gb")
        dateLabel.text = formatter.string(from: Date())
        
    }

    func didUpdateWeather(weather: WeatherModel) {
        DispatchQueue.main.async {
            self.tempLabel.text = weather.tempToString
            self.cityLabel.text = weather.cityName
            self.statusLabel.text = weather.description
            // object der klasse UIImage
            self.weatherImageView.image = UIImage(systemName: weather.conditionName)
            self._weatherInfoObject = weather
            self.isData = true
        
        }
      
    }
    
    func didFailWithError(error: Error) {
        print(error)
        
    }
    
    
    
        
    }
    


