//
//  MainViewController.swift
//  Sky Well Test Project
//
//  Created by miki on 11/9/16.
//  Copyright © 2016 JesusCodes. All rights reserved.
//

import UIKit
import CoreLocation

class MainViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, CLLocationManagerDelegate {
    
    var navBar: UINavigationBar?
    @IBOutlet var carListTableView: UITableView!
    
    var locationManager = CLLocationManager()
    var location: CLLocation?
    
    @IBOutlet var weatherDegree: UILabel!
    @IBOutlet var weatherImage: UIImageView!
    @IBOutlet var weatherDescription: UILabel!
    @IBOutlet var weatherCity: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navBar = navigationController?.navigationBar
        navBar?.topItem?.title = "Car list"
        
        carListTableView.dataSource = self
        carListTableView.delegate = self
        
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        if CLLocationManager.locationServicesEnabled() {
            locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters
            locationManager.requestLocation()
        }
    }
    
    
    //Location delegate
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        location = locations.last
        let locationTuple = (Float(location!.coordinate.longitude), Float(location!.coordinate.latitude))
        Api.getWeather(locationTuple) {
            (weather, error) in
            if let error = error {
                print(error)
            } else {
                self.weatherCity.text = weather!.city
                self.weatherDescription.text = weather!.title
                self.weatherDegree.text = weather!.temperature > 0 ? "+\(weather!.temperature!)" : "-\(weather!.temperature!)"
                self.weatherImage.image = weather!.icon?.image
            }
        }
    }
    
    func locationManager(manager: CLLocationManager, didFailWithError error: NSError) {
        print("Error: " + error.localizedDescription)
    }
    
    //TableView delegate
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("CarListCell", forIndexPath: indexPath) as! CarListCell
        return cell
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 100
    }
    
}

class CarListCell: UITableViewCell {
    
}