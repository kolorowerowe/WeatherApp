//
//  ViewController.swift
//  WeatherApp_v1
//
//  Created by Student on 01.06.2020.
//  Copyright © 2020 agh. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    private var apiWeather = ApiWeather()
    private var weatherResult : [WeatherData] = []
    
    @IBOutlet weak var cityName: UITextField!
    @IBOutlet weak var tempDay: UITextField!
    @IBOutlet weak var pressure: UITextField!
    @IBOutlet weak var windSpeed: UITextField!
    @IBOutlet weak var weatherDesc: UITextField!
    @IBOutlet weak var icon: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        apiWeather.fetchWeather(){[weak self] (data: [WeatherData]) in
            self?.weatherResult = data
            DispatchQueue.main.async {
                self?.cityName.text = data[0].city
                self?.tempDay.text = String(data[0].temp)
                self?.pressure.text = String(data[0].pressure)
                self?.windSpeed.text = String(data[0].windSpeed)
                self?.weatherDesc.text = String(data[0].main)
                self?.icon.loadFromUrl(url: URL(string: "https://openweathermap.org/img/w/" + data[0].icon + ".png")!)
            }
        }
        
    }


}
