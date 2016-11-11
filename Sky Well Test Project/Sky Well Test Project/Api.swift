//
//  Api.swift
//  Sky Well Test Project
//
//  Created by miki on 11/10/16.
//  Copyright © 2016 JesusCodes. All rights reserved.
//

import Foundation
import Alamofire

class Api {
    
    static func getWeather(location: (longitude: Float, latitude: Float), callback:(Float?, String?, String?, String?, NSError?)->()) {
        Alamofire.request(.GET, "http://api.openweathermap.org/data/2.5/weather?lat=\(location.latitude)&lon=\(location.longitude)&appid=05b7c567ea8c258ed3ac44205b548310", encoding: .JSON)
            .responseJSON { response in
                switch response.result {
                case .Success:
                    if let json = response.result.value {
                        let city = json["name"] as! String
                        let weatherArray = json["weather"] as! [AnyObject]
                        var weatherImage = ""
                        var weatherTitle = ""
                        for weather in weatherArray {
                            weatherImage = weather["icon"] as! String
                            weatherTitle = weather["main"] as! String
                        }
                        let main = json["main"]!!
                        let temperature: Float = main["temp"] as! Float - 273.15
                        ui {
                            callback(temperature, city, weatherTitle, weatherImage, nil)
                        }
                        
                    }
                case .Failure(let error):
                    ui {
                        callback(nil, nil, nil, nil, error)
                    }
                }
        }
    }
    
}