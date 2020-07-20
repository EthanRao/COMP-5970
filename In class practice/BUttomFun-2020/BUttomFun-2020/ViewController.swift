//
//  ViewController.swift
//  BUttomFun-2020
//
//  Created by Xi Rao on 6/5/20.
//  Copyright © 2020 Xi Rao. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBOutlet weak var statusLabel: UILabel!
    
    @IBAction func  buttonPressed(_ sender: UIButton) {
        let title = sender.title(for: .selected)
        let text = "\(title) pressed"
        statusLabel.text = text
    }
}

