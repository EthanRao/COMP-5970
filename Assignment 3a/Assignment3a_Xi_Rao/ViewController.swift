//
//  ViewController.swift
//  Assignment3a_Xi_Rao
//
//  Created by Xi Rao on 7/11/20.
//  Copyright © 2020 Xi Rao. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {

    @IBOutlet weak var picker: UIPickerView!
    @IBOutlet weak var userInput: UITextField!
    @IBAction func selectButton(_ sender: Any) {
        let row = picker.selectedRow(inComponent: 0)
        let selected = pickerData[row]
        let title = "You selected '\(selected)';"
        let alert = UIAlertController(
            title: title,
            message: "Thank you for choosing!",
            preferredStyle: .alert)
        let action = UIAlertAction(
            title: "Close",
            style: .default,
            handler: nil)
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
    @IBAction func replaceButton(_ sender: Any) {
        let row = picker.selectedRow(inComponent: 0)
        if (userInput.text != "") {
            pickerData[row] = userInput.text!
        }
        picker.reloadAllComponents()
    }
    
    @IBAction func insertButton(_ sender: Any) {
        let newRow = picker.selectedRow(inComponent: 0) + 1
        if (userInput.text != "") {
            pickerData.insert(userInput.text!, at: newRow)
        }
        picker.reloadAllComponents()
        picker.selectRow(newRow, inComponent: 0, animated: true)
    }
    
    
    var pickerData: [String] = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.picker.delegate = self
        self.picker.dataSource = self
        
        pickerData = ["Thing One", "Thing Two", "Thing Three"]
    }

    // recreated
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerData.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerData[row]
    }
}
