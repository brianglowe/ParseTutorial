//
//  RegisterViewController.swift
//  ParseTutorial
//
//  Created by Ron Kliffer on 3/6/15.
//  Copyright (c) 2015 Ron Kliffer. All rights reserved.
//

import UIKit

class RegisterViewController: UIViewController {

    @IBOutlet weak var userTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    let scrollViewWallSegue = "SignupSuccesful"
    let tableViewWallSegue = "SignupSuccesfulTable"
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    // MARK: - Actions
    @IBAction func signUpPressed(sender: AnyObject) {
    //1 - create a new PFUser object named user. You will use this object for both the login and register processes. It stores your authenticated user, so you can access the data for this user any time you want.
        let user = PFUser()
    //2 - Assign the username and password to user from the text fields in the view
        user.username = userTextField.text
        user.password = passwordTextField.text
    //3 - call the method that registers the user in the background and check the response in a closure. there are two possible responses
        user.signUpInBackgroundWithBlock { (succceeded, error) in
            if (succceeded)  {
                // The registration was successful, go to the wall
                self.performSegueWithIdentifier(self.scrollViewWallSegue, sender: nil)
            } else if let error = error {
                // Something bad has occured
                self.showErrorView(error)
            }
        }
    }
}
