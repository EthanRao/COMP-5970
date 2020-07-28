//
//  Job.swift
//  Todo-list
//
//  Created by Xi Rao on 7/20/20.
//  Copyright © 2020 Xi Rao. All rights reserved.
//

import UIKit

class Job: NSObject,NSCoding{
    public var title:String
    public var time :Date
    
    public init(title:String,time:Date){
        self.time=time
        self.title=title
    }
    
    required init?(coder aDecoder: NSCoder) {
        title=aDecoder.decodeObject(forKey: "title") as! String
        time=aDecoder.decodeObject(forKey: "time") as! Date
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(title, forKey: "title")
        aCoder.encode(time, forKey: "time")
    }
    
}
