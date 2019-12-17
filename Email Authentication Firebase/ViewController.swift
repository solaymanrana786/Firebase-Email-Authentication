//
//  ViewController.swift
//  Email Authentication Firebase
//
//  Created by Rana AITS on 12/17/19.
//  Copyright © 2019 Rana AITS. All rights reserved.
//

import UIKit
import FirebaseAuth

class ViewController: UIViewController {
    
    @IBOutlet weak var signInSelector: UISegmentedControl!
    @IBOutlet weak var signInLabel: UILabel!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var signInButton: UIButton!
    
    var isSignIn: Bool = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func signInSelectorChange(_ sender: Any) {
        
        isSignIn = !isSignIn
        
        if isSignIn{
            signInLabel.text = "Sign In"
            signInButton.setTitle("Sign In", for: .normal)
        } else {
            signInLabel.text = "Register"
            signInButton.setTitle("Register", for: .normal)

        }
    }
    
    @IBAction func signInButtonTapped(_ sender: Any) {
        
        if let email = emailTextField.text, let pass = passwordTextField.text {
            
            if isSignIn {
                // signn in with the user with firebase
                Auth.auth().signIn(withEmail: email, password: pass) { (user, error) in
                    // check that user isn't nil
                    if let u = user {
                        //user is found,go to home
                        self.performSegue(withIdentifier: "goToHome", sender: self)
                        
                    } else {
                        //check error send message
                        print("Error in SignIn")
                        }
                    }
                }
             else {
                // Register with Firebase
                                   
               Auth.auth().createUser(withEmail: email, password: pass) { (user, error) in
                // check that user isn't nil
                   if let u = user {
                      //user is found,go to home
                     self.performSegue(withIdentifier: "goToHome", sender: self)
                    
                   } else {
                        //check error send message
                       print("Error in Register")
                   }
                }
            }
        }
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        emailTextField.resignFirstResponder()
        passwordTextField.resignFirstResponder()
    }
}

