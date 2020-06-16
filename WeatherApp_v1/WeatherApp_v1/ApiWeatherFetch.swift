//
//  ApiWeatherFetch.swift
//  WeatherApp_v1
//
//  Created by Student on 04.06.2020.
//  Copyright © 2020 agh. All rights reserved.
//

import Foundation

struct WeatherData {
    var main = ""
    var icon = ""
    var temp = 0.0
    var pressure = 0.0
    var windSpeed = 0.0
    var city = ""
    var dateTime = ""
    
}

class ApiWeather {
    private var days = 5
    
    private var elementsPerDay = 8
    
    func fetchWeather (completion: @escaping ((_ data: [WeatherData]) -> Void)){
        let dateFormater = DateFormatter()
        dateFormater.dateFormat = "dd MMM YYYY"
        
        var weatherResult : [WeatherData] = []
        let session = URLSession(configuration: .default, delegate: nil, delegateQueue: .main)
        
        let city = "Krakow"
        let apiKey = "cf65a17c32c5f1524267174091d6548b"
        let weatherApiUrl = URL(string: "https://api.openweathermap.org/data/2.5/forecast?q=" + city + "&units=metric&appid=" + apiKey)
        
        let task = session.dataTask(with: weatherApiUrl!){ (data, respose, error) in
            let json = try! JSONSerialization.jsonObject(with: data!, options: []) as! [String: Any]
            
            let cityInfo = json["city"] as! [String: Any]
            let cityName = cityInfo["name"] as! String
            
            var weatherDataElement: WeatherData = WeatherData()
            weatherDataElement.city = cityName
            
            let dailyDataList = json["list"] as! [AnyObject]
            
            for i in stride(from: 0, to: self.days * self.elementsPerDay, by: self.elementsPerDay){
            
                let dailyDataElement = dailyDataList[i]
                
                let dateTime = dailyDataElement["dt"] as! Double
                weatherDataElement.dateTime = dateFormater.string(from: Date(timeIntervalSince1970: dateTime))
                
                let mainInfo = dailyDataElement["main"] as! [String: Any]
                let temp = mainInfo["temp"] as! Double
                weatherDataElement.temp = temp
                let pressure = mainInfo["pressure"] as! Double
                weatherDataElement.pressure = pressure
                
                let windInfo = dailyDataElement["wind"] as! [String: Any]
                let windSpeed = windInfo["speed"] as! Double
                weatherDataElement.windSpeed = windSpeed
                
                let weatherInfo = dailyDataElement["weather"] as! [AnyObject]
                let weatherInfoMain = weatherInfo[0]
                let main = weatherInfoMain["main"] as! String
                weatherDataElement.main = main
                let icon = weatherInfoMain["icon"] as! String
                weatherDataElement.icon = icon
                
                
                weatherResult.append(weatherDataElement)
            }
           
            completion(weatherResult)
        }
        
        
        task.resume()
    
    }
}

