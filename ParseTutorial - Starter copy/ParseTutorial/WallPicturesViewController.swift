//
//  WallPicturesViewController.swift
//  ParseTutorial
//
//  Created by Ron Kliffer on 3/6/15.
//  Copyright (c) 2015 Ron Kliffer. All rights reserved.
//

import UIKit

class WallPicturesViewController: UIViewController {

    @IBOutlet weak var wallScroll: UIScrollView!
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        //Clean the scroll view
        cleanWall()
        
        //Reload the wall
        getWallImages()
    }
    
    // MARK: - Wall
    func cleanWall()
    {
        for viewToRemove in wallScroll.subviews {
            if let viewToRemove = viewToRemove as? UIView {
                viewToRemove.removeFromSuperview()
            }
        }
    }
    
    func getWallImages() {
        //TODO: Get the wall objects from the server
        //TODO: Put the wall objects in the scroll view
        
        //1- create a simple query to retrieve WallPost objects, and sort the query by creation date as we defined earlier in WallPost.swift
        let query = WallPost.query()!
        query.findObjectsInBackgroundWithBlock { objects, error in
            if error == nil {
                //2- Find the object that matches the query. in this case, show all the objects of the type WallPost. If everythign went fine, load the posts to the wall
                if let objects = objects as? [WallPost] {
                    self.loadWallViews(objects)
                }
            } else if let error = error {
                //3- if there was an error, then inform the user
                self.showErrorView(error)
            }
        }
    }
    
    
    // MARK: - Actions
    @IBAction func logOutPressed(sender: AnyObject) {
        //If logout succesful:
        PFUser.logOut()
        navigationController?.popToRootViewControllerAnimated(true)
    }
    
    func loadWallViews(objects: [WallPost]) {
        cleanWall()
    // the first step here is to clean the scroll view of any other UIView objects that maybif you reload the screen.
        
        var originY: CGFloat = 0
        
    //1 - create a view to display the image and post details
        for wallPost in objects {
            let wallView = UIView(frame: CGRect(x: 0, y: originY, width: self.wallScroll.frame.size.width, height: 270))
    
    //2- download the image data
            wallPost.image.getDataInBackgroundWithBlock { data, error in
                if let data = data, image = UIImage(data: data) {
                    //3 - add the image view to the wall view
                    // Add the image
                        let imageView = UIImageView(image: image)
                    imageView.frame = CGRect(x:10, y: 10, width: wallView.frame.size.width - 20, height: 200)
                    imageView.contentMode = UIViewContentMode.ScaleAspectFit
                    wallView.addSubview(imageView)
                    
                    //4- Get the user that uploaded the image, and put it in a label with the creation date
                    // add the info label (user and creation date)
                    let creationDate = wallPost.createdAt
                    let dateFormatter = NSDateFormatter()
                    dateFormatter.dateFormat = "HH:mm dd/MM yyyy"
                    
                    let infoLabel = UILabel(frame: CGRect(x:10, y: 220, width: 0, height: 0))
                    
                    let dateString = dateFormatter.stringFromDate(creationDate!)
                    
                    if let username = wallPost.user.username {
                        infoLabel.text = "Uploaded by: \(username), \(dateString)"
                    } else {
                        infoLabel.text = "Uploaded by anonymous: , \(dateString)"
                    }
                    
                    infoLabel.text = "Uploaded by: \(wallPost.user.username), \(dateString)"
                    infoLabel.font = UIFont(name: "HelveticaNeue", size: 12)
                    infoLabel.textColor = UIColor.whiteColor()
                    infoLabel.backgroundColor = UIColor.clearColor()
                    infoLabel.sizeToFit()
                    wallView.addSubview(infoLabel)
                    
                    
                //5- Add a label with the comment
                // Add the comment label (user and creation date)
                    let commentLabel = UILabel(frame: CGRect(x: 10, y: CGRectGetMaxY(infoLabel.frame)+5, width: 0, height: 0))
                    commentLabel.text = wallPost.comment
                    commentLabel.font = UIFont(name: "HelveticaNeue", size: 16)
                    commentLabel.textColor = UIColor.whiteColor()
                    commentLabel.backgroundColor = UIColor.clearColor()
                    commentLabel.sizeToFit()
                    wallView.addSubview(commentLabel)
                }
            }
            
            //6- Add it to the scroll view and increment the next post's position
            wallScroll.addSubview(wallView)
            originY += 270
        }
    //7- set the ScrollView's content size
        wallScroll.contentSize.height = CGFloat(originY)
    }
 
    
        
}


















