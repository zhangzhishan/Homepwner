//
//  ItemStore.swift
//  Homepwner
//
//  Created by Zhishan Zhang on 3/31/16.
//  Copyright © 2016 Zhishan Zhang. All rights reserved.
//

import UIKit

class ItemStore {
    var allItems = [Item]()
    
    let itemAchiveURL: NSURL = {
        let documentsDirectories =
            NSFileManager.defaultManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask)
        let documentDirectory = documentsDirectories.first!
        return documentDirectory.URLByAppendingPathComponent("items.archieve")
    }()
    
    init() {
        if let archievedItems = NSKeyedUnarchiver.unarchiveObjectWithFile(itemAchiveURL.path!) as? [Item] {
            allItems += archievedItems
        }
    }
    
    func createItem() -> Item {
        let newItem = Item(random: true)
        
        allItems.append(newItem)
        
        return newItem
    }
    
    func removeItem(item: Item) {
        if let index = allItems.indexOf(item) {
            allItems.removeAtIndex(index)
        }
    }
    
    func moveItemAtIndex(fromIndex: Int, toIndex: Int) {
        if fromIndex == toIndex {
            return
        }
        
        let movedItem = allItems[fromIndex]
        
        allItems.removeAtIndex(fromIndex)
        
        allItems.insert(movedItem, atIndex: toIndex)
    }
    
    func saveChanges() -> Bool {
        print("Saving items to : \(itemAchiveURL.path!)")
        
        return NSKeyedArchiver.archiveRootObject(allItems, toFile: itemAchiveURL.path!)
    }
    
    
//    init() {
//        for _ in 0..<5 {
//            createItem()
//        }
//    }
}


