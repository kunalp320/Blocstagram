//
//  ImagesTableViewController.swift
//  Blocstagram
//
//  Created by Kunal Patel on 3/29/16.
//  Copyright © 2016 bootcamp. All rights reserved.
//

import UIKit

class ImagesTableViewController: UITableViewController {

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "imageCell")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return DataSource.sharedInstance.mediaItems.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("imageCell", forIndexPath: indexPath)

        let imageViewTag = 1234
        var imageView = {
            if let imageView = cell.contentView.viewWithTag(imageViewTag) as! UIImageView? {
                return imageView
            } else {
                let imageView = UIImageView()
                imageView.contentMode = .ScaleAspectFill
                imageView.frame = cell.contentView.bounds
                imageView.autoresizingMask = [.FlexibleHeight, .FlexibleWidth]
                
                imageView.tag = imageViewTag
                cell.contentView.addSubview(imageView)
                return imageView
            }
        }
        let item = DataSource.sharedInstance.mediaItems[indexPath.row]
        imageView.image = item.image
        
        return cell
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        
        let item = DataSource.sharedInstance.mediaItems[indexPath.row]
        let image = item.image
        
        return (CGRectGetWidth(self.view.frame) / image.size.width) * image.size.height
    }
    

    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    
    
    
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            DataSource.sharedInstance.mediaItems..removeAtIndex(indexPath.row)
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)

        }
    }

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
