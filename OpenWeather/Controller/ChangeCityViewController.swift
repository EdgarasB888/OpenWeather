//
//  ViewController.swift
//  OpenWeather
//
//  Created by iMac on 2022-08-26.
//

import UIKit

protocol IsAbleToReceive
{
    func passDataBack(data: String)
}

class ChangeCityViewController: UIViewController
{
    
    @IBOutlet weak var cityToChangeTextField: DesignableTextField!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        let weatherViewVC = segue.destination as! WeatherViewController
        weatherViewVC.cityToChangeName = cityToChangeTextField.text ?? ""
    }
    
    
}
