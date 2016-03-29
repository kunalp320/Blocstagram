//
//  ImagesTableViewController.swift
//  Blocstagram
//
//  Created by Kunal Patel on 3/29/16.
//  Copyright © 2016 bootcamp. All rights reserved.
//

import UIKit

class ImagesTableViewController: UITableViewController {

    var images = [UIImage()]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        for i in 1...10 {
            let imageName = "\(i).jpg"
            let image = UIImage(imageLiteral: imageName)
            self.images.append(image)
        }
        
        self.tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "imageCell")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 0
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.images.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("imageCell", forIndexPath: indexPath)

        let imageViewTag = 1234
        let imageView = cell.contentView.viewWithTag(imageViewTag) as! UIImageView?
        
        if let _ = imageView {
        } else {
            let imageView = UIImageView()
            imageView.contentMode = .ScaleAspectFill
            imageView.frame = cell.contentView.bounds
            imageView.autoresizingMask = [.FlexibleHeight, .FlexibleWidth]
            
            imageView.tag = imageViewTag
            cell.contentView.addSubview(imageView)
        }
        
        let image = self.images[indexPath.row];
        imageView!.image = image;
        
        return cell
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

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
