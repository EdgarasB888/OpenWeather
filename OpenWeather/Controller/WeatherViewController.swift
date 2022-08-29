//
//  WeatherViewController.swift
//  OpenWeather
//
//  Created by iMac on 2022-08-26.
//

import UIKit
import CoreLocation
import Alamofire
import SwiftyJSON

class WeatherViewController: UIViewController, CLLocationManagerDelegate
{
    @IBOutlet weak var weatherIcon: UIImageView!
    @IBOutlet weak var tempLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    
    let weatherDataModel = WeatherDataModel()
    let locationManager = CLLocationManager()
    var cityToChangeName: String = ""
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        print("cityToChangeName: ", cityToChangeName)
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters
        locationManager.requestAlwaysAuthorization()
        locationManager.startUpdatingLocation()
    }
    
    override func viewWillAppear(_ animated: Bool)
    {
        super.viewWillAppear(animated)
        print("cityToChangeName: ", cityToChangeName)
        getWeatherData(url: weatherDataModel.apiURL, params: ["appid": weatherDataModel.apiID, "q": cityToChangeName])
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation])
    {
        let location = locations[locations.count - 1]
        
        if location.horizontalAccuracy > 0
        {
            locationManager.stopUpdatingLocation()
            
            print("longtitude: \(location.coordinate.longitude), latitude: \(location.coordinate.latitude)")
            
            let long = String(location.coordinate.longitude)
            let lat = String(location.coordinate.latitude)
            
            //let params: [String:String] = ["lat": lat, "lon": long, "appid": weatherDataModel.apiID]
            var params = [String: String]()
            
            print("cityToChangeName:", cityToChangeName)
            if cityToChangeName == ""
            {
                params = ["lat": lat, "lon": long, "appid": weatherDataModel.apiID]
                getWeatherData(url: weatherDataModel.apiURL, params: params)
            }
            else
            {
                params = ["appid": weatherDataModel.apiID, "q": cityToChangeName]
            }
        }
    }
    
    func getWeatherData(url: String, params: [String : String])
    {
        AF.request(url, method: .get, parameters: params).responseData { response in
            if response.value != nil
            {
                let weatherJSON: JSON = JSON(response.value!)
                print("weatherJSON:", weatherJSON)
                self.updateWeatherData(json: weatherJSON)
            }
            else
            {
                self.cityLabel.text = "Weather unavailable! 😿"
            }
        }
    }
    
    func updateWeatherData(json: JSON)
    {
        if let tempResult = json["main"]["temp"].double
        {
            weatherDataModel.temp = Int(tempResult - 273.1)
            weatherDataModel.name = json["name"].stringValue
            weatherDataModel.condition = json["weather"][0]["id"].intValue
            weatherDataModel.weatherIconName = weatherDataModel.updateWeatherIcon(condition: weatherDataModel.condition)
            updateUI()
        }
        else
        {
            self.cityLabel.text = "Weather unavailable! 😿"
        }
    }
    
    func updateUI()
    {
        cityLabel.text = weatherDataModel.name
        tempLabel.text = "\(weatherDataModel.temp)º"
    }
    
    //unwinds back to home view controller (WeatherViewController)
    @IBAction func unwindToHomeView(_ sender: UIStoryboardSegue) {}
}
