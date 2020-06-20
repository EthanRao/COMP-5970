//
//  ViewController.swift
//  Assignment 1b
//
//  Created by Xi Rao on 6/5/20.
//  Copyright © 2020 Xi Rao. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imageView.image = UIImage(named: "sec")
    }
    @IBAction func auburnButton(_ sender: UIView) {
        imageView.image = UIImage(named: "auburn")
    }
    
    @IBAction func secButton(_ sender: UIView) {
        imageView.image = UIImage(named: "sec")
    }
    
    @IBAction func bamaButton(_ sender: UIView) {
        imageView.image = UIImage(named: "bama")
    }


}
