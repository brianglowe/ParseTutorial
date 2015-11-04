//
//  WallPost.swift
//  ParseTutorial
//
//  Created by Ron Kliffer on 3/8/15.
//  Copyright (c) 2015 Ron Kliffer. All rights reserved.
//

import Foundation

class WallPost: PFObject {
    @NSManaged var image: PFFile
    @NSManaged var user: PFUser
    @NSManaged var comment: String?
    
 // lets write an initializer
    init(image: PFFile, user: PFUser, comment: String?) {
        super.init()
        
        self.image = image
        self.user = user
        self.comment = comment
    }
    override init() {
        super.init()
    }
    

    
    
    
 // lets define the PFQuery object this subclass returns when calling query()
    override class func query() -> PFQuery? {
      // 1 - create a PFQuery object for the WallPost class
        let query = PFQuery(className: WallPost.parseClassName())
      //2 - Request that this query return the full user details. without this line of code below, the query will just return the object reference of the user without details
        query.includeKey("user")
      //3- Sort the results by their creation date
        query.orderByDescending("createdAt")
        return query
    }
    
    
    
    
}

extension WallPost: PFSubclassing {
    // Table view delegate methods here
    //1 - set the name of the class as seen in the backend database
        class func parseClassName() -> String {
            return "WallPost"
        }
    
    //2- let parse konw that you intend to use this subclass for all objects with class type WallPost. You want to be sure to only do this once, so using dispatch_once_t will make sure of it.
    override class func initialize() {
        var onceToken: dispatch_once_t = 0
        dispatch_once(&onceToken) {
            self.registerSubclass()
        }
    }
}
