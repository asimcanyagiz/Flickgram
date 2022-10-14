//
//  AuthViewController.swift
//  Flickgram
//
//  Created by Asım can Yağız on 14.10.2022.
//

import UIKit
import FirebaseAuth
import FirebaseAuth

final class AuthViewController: UIViewController {
    
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var confirmButton: UIButton!
    @IBOutlet weak var pageLabel: UILabel!
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    
    var currentScreen = 0
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    
    
    @IBAction func didSegmentedButtonPressed(_ sender: UISegmentedControl) {
        
        let title = segmentedControl.titleForSegment(at: segmentedControl.selectedSegmentIndex)!
        
        if title == "Sign In" {
            currentScreen = 0
            pageLabel.text = "Sign In"
            confirmButton.titleLabel?.text = "Login"
            
        } else {
            currentScreen = 1
            pageLabel.text = "Sign Up"
            confirmButton.titleLabel?.text = "Sign Up"
        }
        
    }
    
    
    
    
    @IBAction func didConfirmButtonPressed(_ sender: UIButton) {
        
        authOperations(screen: currentScreen)
        
    }
    
    //MARK: - Login Register Control
    func authOperations(screen Screen: Int = 0){
        
        if Screen == 0 {
            if let email = emailTextField.text, let password = passwordTextField.text{
                
                Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
                    if let e = error {
                        print(e.localizedDescription)
                    } else {
                        //Navigate to the ChatViewController
                        print("Succesfully Login")
                    }
                }
                
            }
        } else {
            if let email = emailTextField.text, let password = passwordTextField.text {
                
                Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
                    if let e = error {
                        print(e.localizedDescription)
                    } else {
                        //Navigate to the ChatViewController
                        print("Succesfully Registered")
                    }
                    
                }
            }
        }
    }
    
    
    
}
