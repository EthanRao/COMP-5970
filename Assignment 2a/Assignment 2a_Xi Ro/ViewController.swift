//
//  ViewController.swift
//  Assignment 2a_Xi Ro
//
//  Created by Xi Rao on 6/21/20.
//  Copyright © 2020 Xi Rao. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var numOfPayments: UITextField!
    @IBOutlet weak var prinple: UITextField!
    @IBOutlet weak var interestRate: UITextField!
    @IBOutlet weak var result: UITextField!
    
    @IBAction func calculate(_ sender: Any) {
        
        if numOfPayments.text == "" || prinple.text == "" || interestRate.text == "" {
            result.text = "error"
            return
        }
        
        let payments = Double(numOfPayments.text!)!
        let rate = Double(interestRate.text!)!
        let principal = Double(prinple.text!)!
        
        let resultFromCalc = paymentCalculator(payments, rate, principal)
        
        result.text = "$ " + resultFromCalc
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        result.text = ""
    }

    func paymentCalculator(_ months: Double, _ apr: Double, _ principle: Double)-> String {
        var payment = 0.0
        payment = (pow((1 + (apr / 100)), (1 * months)) / (months)) * principle
        
        // payment = ((apr / 100 * principle * months + principle) / (months))
        
        return "\(round(100*payment)/100)"
    }

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return UIInterfaceOrientationMask(rawValue: (UIInterfaceOrientationMask.portrait.rawValue | UIInterfaceOrientationMask.landscapeLeft.rawValue | UIInterfaceOrientationMask.landscapeRight.rawValue))
    }
}
