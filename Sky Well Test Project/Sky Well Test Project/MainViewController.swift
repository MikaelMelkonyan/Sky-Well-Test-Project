//
//  MainViewController.swift
//  Sky Well Test Project
//
//  Created by miki on 11/9/16.
//  Copyright © 2016 JesusCodes. All rights reserved.
//

import UIKit

class MainViewController: UIViewController{//, UITableViewDelegate, UITableViewDataSource {
    
    var navBar: UINavigationBar?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navBar = navigationController?.navigationBar
        navBar?.topItem?.title = "Car list"

    }
    
}