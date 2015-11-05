//
//  WallPicturesTableViewController.swift
//  ParseTutorial
//
//  Created by Ron Kliffer on 3/8/15.
//  Copyright (c) 2015 Ron Kliffer. All rights reserved.
//

import UIKit

class WallPicturesTableViewController: PFQueryTableViewController {
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(animated: Bool) {
        loadObjects()
    }
    
    override func queryForTable() -> PFQuery {
        let query = WallPost.query()
        return query!
    }

    // MARK: - Actions
    @IBAction func logOutPressed(sender: AnyObject) {
        //TODO
        //If logout succesful:
        navigationController?.popToRootViewControllerAnimated(true)
    }
 // the method below replaces the UITableView data source method with a more suitable form. you get the returned PFObject as a parameter, without the need to search it in a results array using an index path.
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath, object: PFObject?) -> PFTableViewCell? {
        //1- Dequeue a cell from the table view, and cast it to a WallPostTableViewCell
        let cell = tableView.dequeueReusableCellWithIdentifier("WallPostCell", forIndexPath: indexPath) as! WallPostTableViewCell
        
        //2- cast the given PFObject to a WallPost object
        let wallPost = object as! WallPost
        
        //3- Download the post image using PFImageView's loadInBackground method. in the compeltion closure you track the downloads progress. here you fill a UIProgressBar as the image downloads
        cell.postImage.file = wallPost.image
        cell.postImage.loadInBackground(nil) { percent in
        cell.progressView.progress = Float(percent)*0.01
            print("\(percent)%")
        }
        
        //4- Add the creation date, the user's name and the comment to the cell.
        let creationDate = wallPost.createdAt
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "HH:mm dd/mm yyyy"
        let dateString = dateFormatter.stringFromDate(creationDate!)
        
        if let username = wallPost.user.username {
            cell.createdByLabel.text = "Uploaded by: \(username), \(dateString)"
        } else {
            cell.createdByLabel.text = "Uploaded by anonymous: , \(dateString)"
        }
        
        cell.createdByLabel.text = "Uploaded by: \(wallPost.user.username), \(dateString)"
        
        cell.commentLabel.text = wallPost.comment
        
        return cell
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
}





















