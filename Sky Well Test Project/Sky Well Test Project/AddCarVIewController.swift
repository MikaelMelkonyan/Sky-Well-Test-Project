//
//  Car.swift
//  Sky Well Test Project
//
//  Created by miki on 11/13/16.
//  Copyright © 2016 JesusCodes. All rights reserved.
//

import Foundation
import UIKit

class AddCarVIewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, UITextViewDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UICollectionViewDelegate, UICollectionViewDataSource {
    
    var currentTextField = UITextField()
    let imagePicker = UIImagePickerController()
    
    var images: [UIImage] = []
    
    let engineCases = ["inline", "straight", "vee", "flat"]
    let transmissionCases = ["manual", "automate"]
    let conditionCases = ["good", "bad"]
    
    @IBOutlet var model: UITextField!
    @IBOutlet var price: UITextField!
    @IBOutlet var engine: UITextField!
    @IBOutlet var transmission: UITextField!
    @IBOutlet var condition: UITextField!
    @IBOutlet var longDescription: UITextView!
    
    @IBOutlet var imagesCollectionView: UICollectionView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.tintColor = UIColor.whiteColor()
        setPickerViews()
        model.inputAccessoryView = createTollbar()
        price.inputAccessoryView = createTollbar()
        engine.inputAccessoryView = createTollbar()
        transmission.inputAccessoryView = createTollbar()
        condition.inputAccessoryView = createTollbar()
        longDescription.inputAccessoryView = createTollbar()
        
        longDescription.delegate = self
        model.placeholder = "Car model"
        price.placeholder = "Price, $"
        longDescription.text = "Description..."
        
        imagePicker.delegate = self
        imagesCollectionView.delegate = self
        imagesCollectionView.dataSource = self
    }
    
    //UIImagePicker and UICollectionView Delegate
    @IBAction func addCarPhoto(sender: UIButton) {
        imagePicker.allowsEditing = false
        imagePicker.sourceType = .PhotoLibrary
        
        presentViewController(imagePicker, animated: true, completion: nil)
    }
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        if let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            images.append(pickedImage)
        }
        
        dismissViewControllerAnimated(true) {
            self.imagesCollectionView.reloadData()
        }
    }
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("ImagesCollectionViewCell", forIndexPath: indexPath) as! ImagesCollectionViewCell
        if images.count > 0 {
            cell.carImage.image = images[indexPath.row]
        }
        return cell
    }
    
    //UITextView Delegate
    func textViewDidBeginEditing(textView: UITextView) {
        if longDescription.text == "Description..." {
            longDescription.text = ""
        }
    }
    
    func textViewDidEndEditing(textView: UITextView) {
        if longDescription.text == "" {
            longDescription.text = "Description..."
        }
    }
    
    // PickerView Delegate
    func setPickerViews() {
        engine.text = "Engine: \(engineCases.first!)"
        transmission.text = "Transmission: \(transmissionCases.first!)"
        condition.text = "Condition: \(conditionCases.first!)"
        
        createPickerView(engine)
        createPickerView(transmission)
        createPickerView(condition)
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
    
    func createTollbar() -> UIToolbar {
        let toolBar = UIToolbar()
        toolBar.tintColor = UIColor(red: 39/255, green: 184/255, blue: 141/255, alpha: 1)
        toolBar.sizeToFit()
        
        let doneButton = UIBarButtonItem(title: "Done", style: UIBarButtonItemStyle.Plain, target: self, action: #selector(AddCarVIewController.donePicker))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.FlexibleSpace, target: nil, action: nil)
        toolBar.setItems([spaceButton, doneButton], animated: false)
        toolBar.userInteractionEnabled = true
        return toolBar
    }
    
    func createPickerView(sender: UITextField) {
        sender.inputView = nil
        
        let newPickerView = UIPickerView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 150))
        newPickerView.backgroundColor = UIColor.whiteColor()
        newPickerView.delegate = self
        newPickerView.dataSource = self
        
        sender.inputView = newPickerView
    }
    
    func donePicker() {
        view.endEditing(true)
    }
    
    @IBAction func textFieldEditingBeginned(sender: UITextField) {
        currentTextField = sender
    }
    
    
}

class ImagesCollectionViewCell: UICollectionViewCell {
    @IBOutlet var carImage: UIImageView!
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