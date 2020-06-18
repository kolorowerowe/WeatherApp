//
//  AddCityViewController.swift
//  WeatherApp_v2
//
//  Created by Student on 17.06.2020.
//  Copyright © 2020 agh. All rights reserved.
//

import UIKit

class AddCityViewController: UIViewController {
    
    @IBOutlet weak var cityToAdd: UITextField!

    @IBAction func returnButtonCallback(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBOutlet weak var searchButton: UIButton!
    
    @IBAction func searchButtonCallback(_ sender: Any) {
        let city = cityToAdd.text!

    }
}
