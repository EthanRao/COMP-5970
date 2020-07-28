//
//  AddItemViewController.swift
//  Todo-list
//
//  Created by Xi Rao on 7/20/20.
//  Copyright © 2020 Xi Rao. All rights reserved.
//

import UIKit

class AddItemViewController: UIViewController {

    @IBOutlet weak var addButton: UIButton!
    @IBOutlet weak var timePicker: UIDatePicker!
    @IBOutlet weak var titleBox: UITextField!
    
    @IBAction func onAdd(_ sender: UIButton) {
        let title=titleBox.text
        if title==nil{
            return
        }
        let time=timePicker.date
        
        let job=Job(title: title!, time: time)
        FirstViewController.todos.append(job)
        FirstViewController.save()
        print(title!,time)
        
        navigationController?.popViewController(animated: true)
       
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
