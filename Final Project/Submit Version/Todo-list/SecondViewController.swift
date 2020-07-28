//
//  SecondViewController.swift
//  Todo-list
//
//  Created by Xi Rao on 7/20/20.
//  Copyright © 2020 Xi Rao. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController ,UITableViewDataSource,UITableViewDelegate{
    let cellId="historyCellId"
    public static   var history:[Job]=[]
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var editButton: UIBarButtonItem!
    @IBAction func onEditHistory(_ sender: UIBarButtonItem) {
        tableView.isEditing = !tableView.isEditing
        if tableView.isEditing{
            editButton.title="Finish"
        }else{
            editButton.title="Edit"
        }
    }
    
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle==UITableViewCellEditingStyle.delete{
            let row=indexPath.row
            SecondViewController.history.remove(at: row)
            SecondViewController.save()
            tableView.reloadData()
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return SecondViewController.history.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell=tableView.dequeueReusableCell(withIdentifier: cellId)
        if cell==nil{
            cell=UITableViewCell(style: .subtitle, reuseIdentifier: cellId)
        }
        let initJob=SecondViewController.history[indexPath.row]
        cell!.textLabel?.text=initJob.title
        cell!.detailTextLabel?.text=initJob.time.description(with: Locale.autoupdatingCurrent)
        return cell!
    }    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        SecondViewController.loadHis()
        tableView.reloadData()
    }

    override func viewWillDisappear(_ animated: Bool) {
        SecondViewController.save()
        tableView.isEditing=false
        editButton.title="Edit"
    }
    
    public static func save(){
        let url=FirstViewController.getURL(fileName: "his.data")!
        let s=NSKeyedArchiver.archiveRootObject(history, toFile: url.path)
        print("save his ",s)
    }
    
    public static func loadHis(){
        let url=FirstViewController.getURL(fileName: "his.data")!
        let h=NSKeyedUnarchiver.unarchiveObject(withFile: url.path)
        if h==nil{
            history=[]
        }else{
            history=h as! [Job]
        }
        
    }

}

