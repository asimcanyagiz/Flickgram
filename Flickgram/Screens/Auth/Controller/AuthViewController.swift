//
//  AuthViewController.swift
//  Flickgram
//
//  Created by Asım can Yağız on 14.10.2022.
//

import UIKit

final class AuthViewController: UIViewController {
    
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var confirmButton: UIButton!
    @IBOutlet weak var pageLabel: UILabel!
    
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    
    
    @IBAction func didSegmentedButtonPressed(_ sender: UISegmentedControl) {
        
        let title = segmentedControl.titleForSegment(at: segmentedControl.selectedSegmentIndex)
        print(title)
        
    }
    

}
