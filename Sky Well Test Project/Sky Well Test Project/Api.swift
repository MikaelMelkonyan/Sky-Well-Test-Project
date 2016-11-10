//
//  Api.swift
//  Sky Well Test Project
//
//  Created by miki on 11/10/16.
//  Copyright © 2016 JesusCodes. All rights reserved.
//

import Foundation

class Api {
    
    static func getWeather(location: (longitude: Float, latitude: Float)?) {
        print(location?.longitude)
        print(location?.latitude)
    }
    
}