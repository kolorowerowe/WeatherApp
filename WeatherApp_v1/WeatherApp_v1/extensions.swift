//
//  extensions.swift
//  WeatherApp_v1
//
//  Created by Student on 10.06.2020.
//  Copyright © 2020 agh. All rights reserved.
//

import Foundation
import UIKit


extension UIImageView {
    func loadFromUrl(url: URL) {
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            }
        }
    }
}
