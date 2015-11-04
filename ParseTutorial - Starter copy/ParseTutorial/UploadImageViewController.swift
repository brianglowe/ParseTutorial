//
//  UploadImageViewController.swift
//  ParseTutorial
//
//  Created by Ron Kliffer on 3/6/15.
//  Copyright (c) 2015 Ron Kliffer. All rights reserved.
//

import UIKit

class UploadImageViewController: UIViewController {

    @IBOutlet weak var imageToUpload: UIImageView!
    @IBOutlet weak var commentTextField: UITextField!
    @IBOutlet weak var loadingSpinner: UIActivityIndicatorView!
    
    var username: String?
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    func saveWallPost(file: PFFile) {
        //1
        let wallPost = WallPost(image: file, user: PFUser.currentUser()!, comment: self.commentTextField.text)
        //2
        wallPost.saveInBackgroundWithBlock { succeeded, error in
            if succeeded {
                //3
                self.navigationController?.popViewControllerAnimated(true)
            } else {
                //4
                if let errorMessage = error?.userInfo["error"] as? String {
                    self.showErrorView(error!)
                }
            }
        }
    }
    
    // MARK: - Actions
    @IBAction func selectPicturePressed(sender: AnyObject) {
        //Open a UIImagePickerController to select the picture
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
        presentViewController(imagePicker, animated: true, completion: nil)
    }

    @IBAction func sendPressed(sender: AnyObject) {
        commentTextField.resignFirstResponder()
        
        //Disable the send button until we are ready
        navigationItem.rightBarButtonItem?.enabled = false
        
        loadingSpinner.startAnimating()
        
        //TODO: Upload a new picture
        let pictureData = UIImagePNGRepresentation((imageToUpload.image)!)
        
    // Upload a new picture
    //1 - create the PFFIle object with the data of the image, and save it in the background
        let file = PFFile(name: "image", data: pictureData!)
        file!.saveInBackgroundWithBlock ({ (succeeded, error) -> Void in
            if succeeded {
             //2- if successful, save the PostWall object with the fileyou just successfully uploaded
                self.saveWallPost(file!)
            } else if let error = error {
             //3- If not, inform the user
                self.showErrorView(error)
            }
            }, progressBlock: { percent in
            //4- when saving the file, Parse lets you track the progress with the progress block (closure in swift)
                print("Uploaded: \(percent)%")
        })
        
    }
}

extension UploadImageViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingImage image: UIImage!, editingInfo: [NSObject : AnyObject]!) {
        //Place the image in the imageview
        imageToUpload.image = image
        picker.dismissViewControllerAnimated(true, completion: nil)
    }
}








