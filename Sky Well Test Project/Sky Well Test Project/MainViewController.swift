//
//  MainViewController.swift
//  Sky Well Test Project
//
//  Created by miki on 11/9/16.
//  Copyright © 2016 JesusCodes. All rights reserved.
//

import UIKit
import CoreLocation
import CoreData

class MainViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, CLLocationManagerDelegate {
    
    var navBar: UINavigationBar?
    @IBOutlet var carListTableView: UITableView!
    
    var locationManager = CLLocationManager()
    var location: CLLocation?
    var cars: [Car] = []
    
    @IBOutlet var weatherDegree: UILabel!
    @IBOutlet var weatherImage: UIImageView!
    @IBOutlet var weatherDescription: UILabel!
    @IBOutlet var weatherCity: UILabel!
    @IBOutlet var addCarButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navBar = navigationController?.navigationBar
        navBar?.topItem?.title = "Car list"
        
        let addButton = UIButton()
        addButton.setImage(UIImage(named: "circle-plus_32x32"), forState: .Normal)
        addButton.frame.size.height = 20
        addButton.frame.size.width = 20
        addButton.addTarget(self, action: #selector(MainViewController.addCar(_:)), forControlEvents: UIControlEvents.TouchUpInside)
        addCarButton.customView = addButton
        
        carListTableView.dataSource = self
        carListTableView.delegate = self
        
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        if CLLocationManager.locationServicesEnabled() {
            locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters
            locationManager.requestLocation()
        }
    }
    
    override func viewDidAppear(animated: Bool) {
        do {
            let resultsObject = try managedContext.executeFetchRequest(carsFetchRequest)
            cars = []
            for car in resultsObject {
                let carInArray = Car()
                carInArray.condition = car.valueForKey("condition") as? String
                carInArray.engine = car.valueForKey("engine") as? String
                carInArray.longDescription = car.valueForKey("longDescription") as? String
                carInArray.model = car.valueForKey("model") as? String
                carInArray.price = car.valueForKey("price") as? Int
                carInArray.transmission = car.valueForKey("transmission") as? String
                let imagesCount = car.valueForKey("imagesCount") as? Int
                for index in 0...imagesCount! - 1 {
                    if let data = car.valueForKey("carImage_\(index)") as? NSData {
                        if carInArray.images == nil {
                            carInArray.images = []
                        }
                        carInArray.images?.append(UIImage(data: data)!)
                    }
                }
                cars.append(carInArray)
            }
            self.carListTableView.reloadData()
        } catch {
            print("Some error in Core Data")
        }
    }
    
    func addCar(sender: AnyObject? ) {
        let addCarViewController = navigationController?.storyboard?.instantiateViewControllerWithIdentifier("AddCarVIewController") as! AddCarVIewController
        navigationController?.pushViewController(addCarViewController, animated: true)
    }
    
    //Location delegate
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        location = locations.last
        let locationTuple = (Float(location!.coordinate.longitude), Float(location!.coordinate.latitude))
        Api.getWeather(locationTuple) {
            (weather, error) in
            if let error = error {
                print("Weather getting error = \(error.localizedDescription)")
                self.updateWeatherInfo(true)
            } else {
                weatherObject.setValue(weather!.city, forKey: "city")
                weatherObject.setValue(weather!.title, forKey: "title")
                weatherObject.setValue(weather!.temperature > 0 ? "+\(weather!.temperature!)" : "-\(weather!.temperature!)", forKey: "temperature")
                let image = weather!.icon?.image
                let imageData = NSData(data: UIImagePNGRepresentation(image!)!)
                weatherObject.setValue(imageData, forKey: "image")
                
                do {
                    try managedContext.save()
                } catch {
                }
                self.updateWeatherInfo(false)
            }
        }
    }
    
    func updateWeatherInfo(error: Bool) {
        do {
            let resultsObject = try managedContext.executeFetchRequest(weatherFetchRequest).last
            self.weatherDescription.text = resultsObject?.valueForKey("title") as? String
            self.weatherCity.text = resultsObject?.valueForKey("city") as? String
            self.weatherDegree.text = resultsObject?.valueForKey("temperature") as? String
            if let data = resultsObject?.valueForKey("image") as? NSData {
                self.weatherImage.image = UIImage(data: data)
            }
        } catch {
            self.weatherDescription.text = "Some problems"
        }
        if error {
            self.weatherDescription.text = "Some problems"
        }
    }
    
    func locationManager(manager: CLLocationManager, didFailWithError error: NSError) {
        print("Error: " + error.localizedDescription)
        self.weatherDescription.text = "Some problems"
    }
    
    //TableView delegate
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("CarListCell", forIndexPath: indexPath) as! CarListCell
        if cars.count > 0 {
            cell.model.text = "Car: \(cars[indexPath.row].model!)"
            cell.price.text = "Price: \(cars[indexPath.row].price!)$"
            cell.carImage?.image = cars[indexPath.row].images![0]
        }
        return cell
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cars.count
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let carInfoViewController = navigationController?.storyboard?.instantiateViewControllerWithIdentifier("CarInfoViewController") as! CarInfoViewController
        carInfoViewController.car = cars[indexPath.row]
        navigationController?.pushViewController(carInfoViewController, animated: true)
    }
    
}

class CarListCell: UITableViewCell {
    
    @IBOutlet var carImage: UIImageView!
    @IBOutlet var model: UILabel!
    @IBOutlet var price: UILabel!
    
}