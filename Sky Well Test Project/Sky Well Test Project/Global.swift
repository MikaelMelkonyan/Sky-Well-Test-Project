//
//  Global.swift
//  Sky Well Test Project
//
//  Created by miki on 11/11/16.
//  Copyright © 2016 JesusCodes. All rights reserved.
//

import Foundation


func ui(dispatchBlock:()->()){
    if let threadName = NSThread.currentThread().name where threadName == "main_thread" {
        dispatchBlock()
    } else {
        dispatch_async(dispatch_get_main_queue(), dispatchBlock)
    }
}

func post(dispatchBlock:()->()){
    dispatch_async(dispatch_get_main_queue(), dispatchBlock)
}