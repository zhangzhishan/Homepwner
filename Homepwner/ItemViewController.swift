//
//  ItemViewController.swift
//  Homepwner
//
//  Created by Zhishan Zhang on 3/31/16.
//  Copyright © 2016 Zhishan Zhang. All rights reserved.
//

import UIKit

class ItemViewController: UITableViewController {
    
    
    var itemStore: ItemStore!
    var imageStore: ImageStore!
    var edting = false
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        navigationItem.leftBarButtonItem = editButtonItem()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.estimatedRowHeight = 65
        tableView.rowHeight = UITableViewAutomaticDimension
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemStore.allItems.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
//        let cell = UITableViewCell(style: .Value1, reuseIdentifier: "UITableViewCell")
        let cell = tableView.dequeueReusableCellWithIdentifier("ItemCell", forIndexPath: indexPath) as! ItemCell
        
        // update the labels for the new preferred text size
        cell.updateLabels()
        
        let item = itemStore.allItems[indexPath.row]
        
        cell.nameLabel.text = item.name
        cell.serialNumberLabel.text = item.serialNumber
        cell.valueLabel.text = "$\(item.valueInDollars)"
        if(item.valueInDollars > 50) {
            cell.valueLabel.textColor = UIColor.redColor()
        }
        else {
            cell.valueLabel.textColor = UIColor.greenColor()
        }
        
        return cell
    }
    
    @IBAction func addNewItem(sender: AnyObject) {
        
        let newItem = itemStore.createItem()
        if let index = itemStore.allItems.indexOf(newItem) {
            let indexPath = NSIndexPath(forRow: index, inSection: 0)
            
            tableView.insertRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)
        }

    }
//    
//    @IBAction func toggleEditingMode(sender: AnyObject) {
//        if edting {
//            sender.setTitle("Edit", forState: .Normal)
//            
//            setEditing(false, animated: true)
//            
//            edting = false
//        }
//        else {
//            sender.setTitle("Done", forState: .Normal)
//            setEditing(true, animated: true)
//            edting = true
//        }
//        
//    }
    
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        
        if editingStyle == .Delete {
            
            let item = itemStore.allItems[indexPath.row]
            
            let title = "Delete \(item.name)?"
            let message = "Are you sure you want to delete this item?"
            
            let ac = UIAlertController(title: title, message: message, preferredStyle: .ActionSheet)
            
            let cancelActinon = UIAlertAction(title: "Cancel", style: .Cancel, handler: nil)
            ac.addAction(cancelActinon)
            
            let deleteAction = UIAlertAction(title: "Delete", style: .Destructive, handler:{ (action) -> Void in
               
                self.itemStore.removeItem(item)
                
                self.imageStore.deleteImageForKey(item.itemKey)
                
                self.tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)
            })
            ac.addAction(deleteAction)
            
            presentViewController(ac, animated: true, completion: nil)
            
            
        }
    }
    
    override func tableView(tableView: UITableView, moveRowAtIndexPath sourceIndexPath: NSIndexPath, toIndexPath destinationIndexPath: NSIndexPath) {
        itemStore.moveItemAtIndex(sourceIndexPath.row, toIndex: destinationIndexPath.row)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "ShowItem" {
            if let row = tableView.indexPathForSelectedRow?.row {
                let item = itemStore.allItems[row]
                let detailViewController = segue.destinationViewController as! DetailViewController
                detailViewController.item = item
                detailViewController.imageStore = imageStore
            }
        }
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        tableView.reloadData()
    }
    

    
    
}
