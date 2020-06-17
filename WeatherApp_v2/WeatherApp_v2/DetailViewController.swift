//
//  DetailViewController.swift
//  WeatherApp_v2
//
//  Created by Student on 16.06.2020.
//  Copyright © 2020 agh. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    public var detailItem = "AAAA"
    
    private var apiWeather = ApiWeather()
    
    private var day = 0
    private var maxDay = 5
    private var weatherResult : [WeatherData] = []
    
    @IBOutlet weak var cityName: UITextView!
    @IBOutlet weak var tempDay: UITextView!
    @IBOutlet weak var pressure: UITextView!
    @IBOutlet weak var windSpeed: UITextView!
    @IBOutlet weak var weatherDesc: UITextView!
    @IBOutlet weak var icon: UIImageView!
    @IBOutlet weak var dateTime: UITextView!
    
    @IBOutlet weak var prevButton: UIButton!
    @IBOutlet weak var nextButton: UIButton!
    

    func configureView() {
        // Update the user interface for the detail item.
        apiWeather.fetchWeather(){[weak self] (data: [WeatherData]) in
            self?.weatherResult = data
            self?.UpdateController()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        configureView()
    }

    
    func UpdateController(){
        DispatchQueue.main.async {
            self.cityName.text = self.weatherResult[self.day].city
            self.tempDay.text = String(self.weatherResult[self.day].temp)
            self.pressure.text = String(self.weatherResult[self.day].pressure)
            self.windSpeed.text = String(self.weatherResult[self.day].windSpeed)
            self.weatherDesc.text = String(self.weatherResult[self.day].main)
            self.icon.loadFromUrl(url: URL(string: "https://openweathermap.org/img/w/" + self.weatherResult[self.day].icon + ".png")!)
            self.dateTime.text = self.weatherResult[self.day].dateTime
            
            if self.day == 0 {
                self.prevButton.isEnabled = false
            } else {
                self.prevButton.isEnabled = true
            }
            
            if self.day == self.maxDay {
                self.nextButton.isEnabled = false
            } else {
                self.nextButton.isEnabled = true
            }
            
        }
    }
    
    @IBAction func previousDay(_ sender: UIButton){
        if (self.day > 0){
            self.day -= 1
            self.UpdateController()
        }
    }
    
    @IBAction func nextDay(_ sender: UIButton){
        if (self.day < maxDay){
            self.day += 1
            self.UpdateController()
        }
        
    }


}

