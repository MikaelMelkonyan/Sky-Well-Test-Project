//
//  Global.swift
//  Sky Well Test Project
//
//  Created by miki on 11/11/16.
//  Copyright © 2016 JesusCodes. All rights reserved.
//

import Foundation
import UIKit
import CoreData

let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
let managedContext = appDelegate.managedObjectContext

let weatherEntity =  NSEntityDescription.entityForName("Weather", inManagedObjectContext: managedContext)
let weatherFetchRequest = NSFetchRequest(entityName: "Weather")
let weatherObject = NSManagedObject(entity: weatherEntity!, insertIntoManagedObjectContext:managedContext)

let carsEntity =  NSEntityDescription.entityForName("Cars", inManagedObjectContext: managedContext)
let carsFetchRequest = NSFetchRequest(entityName: "Cars")
let carsObject = NSManagedObject(entity: carsEntity!, insertIntoManagedObjectContext:managedContext)

func ui(dispatchBlock:()->()){
    dispatchBlock()
}

func post(dispatchBlock:()->()){
    dispatch_async(dispatch_get_main_queue(), dispatchBlock)
}