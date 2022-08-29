//
//  WeatherDataModel.swift
//  OpenWeather
//
//  Created by iMac on 2022-08-28.
//

import Foundation

class WeatherDataModel
{
    let apiID = "55c9a5bc40bb025eaed4b153c5a6514b"
    let apiURL = "https://api.openweathermap.org/data/2.5/weather"
    
    var temp: Int = 0
    var name: String = ""
    var condition: Int = 0
    var weatherIconName: String = ""
    
    func updateWeatherIcon(condition: Int) -> String
    {
        switch (condition) {
        case 0...300 :
            return "tstorm1"
        case 301...500 :
            return "light_rain"
        case 501...600 :
            return "shower3"
        case 601...700 :
            return "snow4"
        case 701...771 :
            return "fog"
        case 772...799 :
            return "tstorm3"
        case 800 :
            return "sunny"
        case 801...804 :
            return "cloudy2"
        case 900...903, 905...1000  :
            return "tstorm3"
        case 903 :
            return "snow5"
        case 904 :
            return "sunny"
        default :
            return "dunno"
        }
    }
}
