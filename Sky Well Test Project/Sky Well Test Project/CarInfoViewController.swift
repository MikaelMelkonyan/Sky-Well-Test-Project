//
//  CarInfoViewController.swift
//  Sky Well Test Project
//
//  Created by miki on 11/14/16.
//  Copyright © 2016 JesusCodes. All rights reserved.
//

import Foundation
import UIKit

class CarInfoViewController: UIViewController {
    
    var car = Car()
    var currentImageIndex = 0
    
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var model: UILabel!
    @IBOutlet var price: UILabel!
    @IBOutlet var engine: UILabel!
    @IBOutlet var transmission: UILabel!
    @IBOutlet var condition: UILabel!
    @IBOutlet var longDescription: UITextView!
    @IBOutlet var imageControl: UIPageControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.tintColor = UIColor.whiteColor()
        self.navigationItem.title = car.model
        imageView.image = car.images![0]
        imageControl.currentPage = 0
        imageControl.numberOfPages = car.images!.count
        model.text = "Car: \(car.model!)"
        price.text = "Price: \(car.price!)$"
        engine.text = "Engine: \(car.engine!)"
        transmission.text = "Transmission: \(car.transmission!)"
        condition.text = "Condition: \(car.condition!)"
        longDescription.text = "\(car.longDescription!)"
    }
    
    @IBAction func prevImage(sender: UIButton) {
        if currentImageIndex != 0 {
            currentImageIndex -= 1
            imageView.image = car.images![currentImageIndex]
            imageControl.currentPage = currentImageIndex
        }
    }
    @IBAction func nextImage(sender: UIButton) {
        if currentImageIndex != car.images!.count - 1 {
            currentImageIndex += 1
            imageView.image = car.images![currentImageIndex]
            imageControl.currentPage = currentImageIndex
        }
    }
    
    
}