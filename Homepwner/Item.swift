//
//  Item.swift
//  Homepwner
//
//  Created by Zhishan Zhang on 3/31/16.
//  Copyright © 2016 Zhishan Zhang. All rights reserved.
//

import UIKit

class Item: NSObject, NSCoding {
    var name: String = ""
    var valueInDollars: Int = 0
    var serialNumber: String?
    var dateCreated: NSDate
    var itemKey: String
    
    init(name: String, serialNumber: String?, valueInDollars: Int) {
        self.name = name
        self.valueInDollars = valueInDollars
        self.serialNumber = serialNumber
        self.dateCreated = NSDate()
        self.itemKey = NSUUID().UUIDString
        
        super.init()
    }
    
    convenience init(random: Bool = false) {
        if random {
            let adjective = ["Fluffy", "Rusty", "Shiny"]
            let nouns = ["Bear", "Spork", "Mac"]
            
            var idx = arc4random_uniform(UInt32(adjective.count))
            let randomAdjective = adjective[Int(idx)]
            
            idx = arc4random_uniform(UInt32(adjective.count))
            let randomNoun = nouns[Int(idx)]
            
            let randomName = "\(randomAdjective) \(randomNoun)"
            let randomValue = Int(arc4random_uniform(100))
            let randomSerialNumber = NSUUID().UUIDString.componentsSeparatedByString("-").first!
            
            self.init(name: randomName,
                serialNumber: randomSerialNumber,
                valueInDollars: randomValue)
            
        }
        else {
            self.init(name: "", serialNumber: nil, valueInDollars: 0)
        }
    }
    
    
    required init(coder aCoder: NSCoder) {
        name = aCoder.decodeObjectForKey("name") as! String
        dateCreated = aCoder.decodeObjectForKey("dateCreated") as! NSDate
        itemKey = aCoder.decodeObjectForKey("itemKey") as! String
        serialNumber = aCoder.decodeObjectForKey("serialNumber") as! String?
        
        valueInDollars = aCoder.decodeIntegerForKey("valueInDollars")
        
        super.init()
    }
    
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(name, forKey: "name")
        aCoder.encodeObject(dateCreated, forKey: "dateCreated")
        aCoder.encodeObject(itemKey, forKey: "itemKey")
        aCoder.encodeObject(serialNumber, forKey: "serialNumber")
        
        aCoder.encodeInteger(valueInDollars, forKey: "valueInDollars")
        
    }
}
