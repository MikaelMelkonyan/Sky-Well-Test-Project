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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(car.model!)
    }
    
}