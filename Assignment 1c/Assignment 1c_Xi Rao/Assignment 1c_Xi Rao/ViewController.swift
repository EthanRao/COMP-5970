//
//  ViewController.swift
//  Assignment 1c_Xi Rao
//
//  Created by Xi Rao on 6/9/20.
//  Copyright © 2020 Xi Rao. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let auburnImage = #imageLiteral(resourceName: "auburn.png")
    let bamaImage = #imageLiteral(resourceName: "bama.png")
    let maxLabel = UILabel()
    let minLabel = UILabel()
    
    //@IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var auburnView: UIImageView!
    @IBOutlet weak var bamaView: UIImageView!
    
    @IBOutlet weak var slider: UISlider!
    @IBAction func slider(_ sender: UISlider) {
        
        let value = sender.value
        auburnView.alpha = CGFloat(slider.maximumValue - value)
        bamaView.alpha = CGFloat(value)
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        slider.value = 0.5
        
        auburnView.image = auburnImage
        auburnView.alpha = 0.5
        
        bamaView.image = bamaImage
        bamaView.alpha = 0.5
    }

    func calcSlider() {
        
    }

}
