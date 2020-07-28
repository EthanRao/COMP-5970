//
//  FirstViewController.swift
//  Todo-list
//
//  Created by Xi Rao on 7/20/20.
//  Copyright © 2020 Xi Rao. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController ,UITableViewDataSource,UITableViewDelegate{
    
    let todoCellId="todocell"
    let checkedIcon=UIImage(named: "icons8-checked-checkbox-50")
    let uncheckedIcon=UIImage(named: "icons8-unchecked-checkbox-50")
    
    @IBOutlet weak var editButton: UIBarButtonItem!
    @IBOutlet weak var tableView: UITableView!
    public static var todos:[Job]=[]
    
    @IBAction func onEditTodos(_ sender: UIBarButtonItem) {
        tableView.isEditing = !tableView.isEditing
        if tableView.isEditing{
            sender.title="Finish"
        }else{
            sender.title="Edit"
        }
    }
    func  onCheck(tableView:UITableView,row:IndexPath) {
        let cell=tableView.cellForRow(at: row)
        let text=cell?.textLabel?.text
        let alert=UIAlertController(title: "Move to history", message: "It will be kept in the history page: "+text!, preferredStyle:.alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler:{
            action in
            SecondViewController.history.append(FirstViewController.todos[row.row])
            SecondViewController.save()
            FirstViewController.todos.remove(at: row.row)
            tableView.reloadSections([0], with: .bottom)
        }))
        self.present(alert, animated: true, completion: nil)
     
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell=tableView.cellForRow(at: indexPath)
        if cell?.imageView?.image==uncheckedIcon{
            cell?.imageView?.image=checkedIcon
        }else{
            cell?.imageView?.image=uncheckedIcon
        }
        
        onCheck(tableView: tableView, row: indexPath)
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return FirstViewController.todos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var item=tableView.dequeueReusableCell(withIdentifier: todoCellId)
        if item==nil{
            item=UITableViewCell(style: .subtitle, reuseIdentifier: todoCellId)
        }
     
        let cell=item!
        
        cell.imageView?.image=uncheckedIcon
        let job=FirstViewController.todos[indexPath.row]
        cell.textLabel?.text=job.title
        let timeText=job.time.description(with: Locale.autoupdatingCurrent)
        cell.detailTextLabel?.text=timeText
        
        return cell
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    public static func save(){
        let archive=NSKeyedArchiver.archiveRootObject(FirstViewController.todos, toFile: getURL(fileName: "todos.data")!.path)
        print("save todos ",archive)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
       FirstViewController.save()
        tableView.isEditing=false
        editButton.title="Edit"
    }
    
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle==UITableViewCellEditingStyle.delete{
            let row=indexPath.row
            FirstViewController.todos.remove(at: row)
            FirstViewController.save()
            tableView.reloadData()
        }
    }
    
    public static func loadTodos(){
        let obj = NSKeyedUnarchiver.unarchiveObject(withFile: getURL(fileName: "todos.data")!.path)
        if obj==nil{
            FirstViewController.todos=[]
        }else{
            FirstViewController.todos=obj as! [Job]
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        FirstViewController.loadTodos()
        tableView.reloadData()
    }

    
    public static   func getURL(fileName:String)->URL?{
        let urls=FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return urls.first?.appendingPathComponent(fileName)
    }

}

