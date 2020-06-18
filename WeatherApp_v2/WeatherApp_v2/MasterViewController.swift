//
//  MasterViewController.swift
//  WeatherApp_v2
//
//  Created by Student on 16.06.2020.
//  Copyright © 2020 agh. All rights reserved.
//

import UIKit

struct CityWeather {
    var name = ""
    var icon = ""
    var temp = 0.0
}

class MasterViewController: UITableViewController {

    var detailViewController: DetailViewController? = nil
    var citiesForecast = [CityWeather]()
    
    private var apiWeather = ApiWeather()
    

    private var weatherResult : [WeatherData] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        navigationItem.leftBarButtonItem = editButtonItem

        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(insertNewObject(_:)))
        navigationItem.rightBarButtonItem = addButton
        if let split = splitViewController {
            let controllers = split.viewControllers
            detailViewController = (controllers[controllers.count-1] as! UINavigationController).topViewController as? DetailViewController
        }
        
       initCities()
    }
    
    func initCities(){
        addCityWeather("Paris")
        addCityWeather("Warsaw")
        addCityWeather("Tokio")
        addCityWeather("Miami")

    }
    
    func addCityWeather(_ city: String) {
        apiWeather.fetchWeather(city, 1){[weak self] (data: [WeatherData]) in
            let result = data
            
            var cityWeather: CityWeather = CityWeather()
            cityWeather.name = city
            cityWeather.temp = result[0].temp
            cityWeather.icon = result[0].icon
            
            self?.citiesForecast.insert(cityWeather, at: 0)
            let indexPath = IndexPath(row: 0, section: 0)
            self?.tableView.insertRows(at: [indexPath], with: .automatic)
        }
        
    }

    override func viewWillAppear(_ animated: Bool) {
        clearsSelectionOnViewWillAppear = splitViewController!.isCollapsed
        super.viewWillAppear(animated)
    }

    @objc
    func insertNewObject(_ sender: Any) {
        addCityWeather("Krakow")
//        let indexPath = IndexPath(row: 0, section: 0)
//        tableView.insertRows(at: [indexPath], with: .automatic)
    }
    
    
  

    // MARK: - Segues

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetail" {
            if let indexPath = tableView.indexPathForSelectedRow {
                let cityWeather = citiesForecast[indexPath.row]
                let controller = (segue.destination as! UINavigationController).topViewController as! DetailViewController
                controller.cityNameRequest = cityWeather.name
                controller.navigationItem.leftBarButtonItem = splitViewController?.displayModeButtonItem
                controller.navigationItem.leftItemsSupplementBackButton = true
            }
        }
    }

    // MARK: - Table View

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return citiesForecast.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! CityCellView

        let cityForecast = citiesForecast[indexPath.row]
        
        cell.cityName?.text = cityForecast.name
        cell.temp?.text = cityForecast.temp.formatAsTemp
        cell.icon?.loadByIcon(icon: cityForecast.icon)
        
        return cell
    }

    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }

    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            citiesForecast.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
        }
    }


}

