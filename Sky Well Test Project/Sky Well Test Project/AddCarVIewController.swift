//
//  Car.swift
//  Sky Well Test Project
//
//  Created by miki on 11/13/16.
//  Copyright © 2016 JesusCodes. All rights reserved.
//

import Foundation
import UIKit

class AddCarVIewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    var currentTextField = UITextField()
    
    @IBOutlet var model: UITextField!
    @IBOutlet var price: UITextField!
    @IBOutlet var engine: UITextField!
    @IBOutlet var transmission: UITextField!
    @IBOutlet var condition: UITextField!
    @IBOutlet var longDescription: UITextView!
    
    let engineCases = ["inline", "straight", "vee", "flat"]
    let transmissionCases = ["manual", "automate"]
    let conditionCases = ["good", "bad"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.tintColor = UIColor.whiteColor()
        setPickerViews()
    }
    
    // PickerView Delegate
    func setPickerViews() {
        engine.text = "Engine: \(engineCases.first!)"
        transmission.text = "Transmission: \(transmissionCases.first!)"
        condition.text = "Condition: \(conditionCases.first!)"
        
        createPicker(engine)
        createPicker(transmission)
        createPicker(condition)
    }
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch currentTextField {
        case engine:
            return engineCases.count
        case transmission:
            return transmissionCases.count
        case condition:
            return conditionCases.count
        default:
            return 0
        }
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        switch currentTextField {
        case engine:
            return engineCases[row]
        case transmission:
            return transmissionCases[row]
        case condition:
            return conditionCases[row]
        default:
            return ""
        }
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        switch currentTextField {
        case engine:
            engine.text = "Engine: \(engineCases[row])"
        case transmission:
            transmission.text = "Transmission: \(transmissionCases[row])"
        case condition:
            condition.text = "Condition: \(conditionCases[row])"
        default:
            break
        }
    }
    
    func createPicker(sender: UITextField){
        sender.inputView = nil
        
        let newPickerView = UIPickerView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 150))
        newPickerView.backgroundColor = UIColor.whiteColor()
        newPickerView.delegate = self
        newPickerView.dataSource = self
        
        let toolBar = UIToolbar()
        toolBar.tintColor = UIColor(red: 39/255, green: 184/255, blue: 141/255, alpha: 1)
        toolBar.sizeToFit()
        
        //Create buttons
        let doneButton = UIBarButtonItem(title: "Done", style: UIBarButtonItemStyle.Plain, target: self, action: #selector(AddCarVIewController.donePicker))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.FlexibleSpace, target: nil, action: nil)
        toolBar.setItems([spaceButton, doneButton], animated: false)
        toolBar.userInteractionEnabled = true
        
        sender.inputView = newPickerView
        sender.inputAccessoryView = toolBar
    }
    
    func donePicker() {
        currentTextField.resignFirstResponder()
    }
    
    @IBAction func textFieldEditingBeginned(sender: UITextField) {
        currentTextField = sender
    }
    
    
}

class Car: NSObject {
    
    var model: String?
    var price: Int?
    var images: [UIImage]?
    var engine: String?
    var transmission: String?
    var condition: String?
    var longDescription: String?
}