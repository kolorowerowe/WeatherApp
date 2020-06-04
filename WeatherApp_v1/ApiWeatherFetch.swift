//
//  ApiWeatherFetch.swift
//  WeatherApp_v1
//
//  Created by Student on 04.06.2020.
//  Copyright © 2020 agh. All rights reserved.
//

import Foundation

struct WeatherData {
    var tempDay = 0.0
    var city = ""
}

class ApiWeather {
    func fetchWeather (completion: @escaping ((_ data: [WeatherData]) -> Void)){
        
        var weatherResult : [WeatherData] = []
        let session = URLSession(configuration: .default, delegate: nil, delegateQueue: .main)
        let weatherApiUrl = URL(string: "https://samples.openweathermap.org/data/2.5/forecast/daily?id=524901&appid=0")
        let task = session.dataTask(with: weatherApiUrl!){ (data, respose, error) in
            let json = try! JSONSerialization.jsonObject(with: data!, options: []) as! [String: Any]
            
            let cityInfo = json["city"] as! [String: Any]
            let cityName = cityInfo["name"] as! String
            
            var weatherDataElement: WeatherData = WeatherData()
            weatherDataElement.city = cityName
            
            let dailyDataList = json["list"] as! [AnyObject]
            let dailyDataElement = dailyDataList[0]
            
            let temp = dailyDataElement["temp"] as! [String: Any]
            let tempDay = temp["day"] as! Double
            
            weatherDataElement.tempDay = tempDay
            
            weatherResult.append(weatherDataElement)
            completion(weatherResult)
        }
        
        
        task.resume()
    
    }
}

