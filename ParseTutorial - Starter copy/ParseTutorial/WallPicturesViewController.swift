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
    }
    
    // MARK: - Actions
    @IBAction func logOutPressed(sender: AnyObject) {
        //TODO
        //If logout succesful:
        navigationController?.popToRootViewControllerAnimated(true)
    }
    
    func loadWallViews(objects: [WallPost]) {
        cleanWall()
        
        var originY: CGFloat = 0
        
    //1
        for wallPost in objects {
            let wallView = UIView(frame: CGRect(x: 0, y: originY, width: self.wallScroll.frame.size.width, height: 270))
    
    //2
            wallPost.image.getDataInBackgroundWithBlock { data, error in
                if let data = data, image = UIImage(data: data) {
                    //3
                    // Add the image
                        let imageView = UIImageView(image: image)
                    imageView.frame = CGRect(x:10, y: 10, width: wallView.frame.size.width - 20, height: 200)
                    imageView.contentMode = UIViewContentMode.ScaleAspectFit
                    wallView.addSubview(imageView)
                    
                    //4 
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
                    
                    
                //5 
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
            
            //6 
            wallScroll.addSubview(wallView)
            originY += 270
        }
    //7
        wallScroll.contentSize.height = CGFloat(originY)
    }
 
    
        
}


















