//
//  Extension_WeatherViewController#.swift
//  WeatherAPI
//
//  Created by Rey on 31.01.24.
//

import Foundation
import UIKit

extension WeatherViewController: UITextViewDelegate {
    
    // funktions from protocol UITextFieldDelegate
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        // close keyboard  when user clicks return/search
        searchTextField.endEditing(true)
        return true
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if textField.text != "" { // wenn nutzer nix eintippt lass keyboard offen, solange nutzer was eintippt
            return true
        } else {
            
            // MARK: - Altert
            let alert = UIAlertController(title: "Warning", message: "Please insert city to proceed with weather app", preferredStyle: .alert)
            let alertAction = UIAlertAction(title: "ok", style: .default, handler: nil)
            alert.addAction(alertAction)
            
            present(alert, animated: true, completion: nil)
            
            return false
        }
        
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        // starte suche nach wetter data
        //  searchTextField.text ist ein optional also optional biding
        if let _cityname = searchTextField.text {
            print(_cityname)
            
            weatherManager.fetchWeather(cityName: _cityname)
        }
        searchTextField.text = ""
        
        
    }
    
}
