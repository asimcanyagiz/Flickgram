//
//  AuthViewController.swift
//  Flickgram
//
//  Created by Asım can Yağız on 14.10.2022.
//

import UIKit
import FirebaseAuth

final class AuthViewController: UIViewController, AlertPresentable {
    
    private let viewModel: AuthViewModel
    
    enum AuthType: String {
        case signIn = "Sign In"
        case signUp = "Sign Up"
        
        init(text: String) {
            switch text {
            case "Sign In":
                self = .signIn
            case "Sign Up":
                self = .signUp
            default:
                self = .signIn
            }
        }
    }
    
    var authType: AuthType = .signIn {
        didSet {
            pageLabel.text = title
            confirmButton.setTitle(title, for: .normal)
        }
    }
    
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var confirmButton: UIButton!
    @IBOutlet weak var pageLabel: UILabel!
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    
    // MARK: - Init
    init(viewModel: AuthViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.changeHandler = { change in
            switch change {
            case .didErrorOccurred(let error):
                self.showError(error)
            case .didSignUpSuccessful:
                self.showAlert(title: "SIGN UP SUCCESSFUL!")
            }
        }
        
        title = "Auth"
        
        viewModel.fetchRemoteConfig { isSignUpDisabled in
            self.segmentedControl.isHidden = isSignUpDisabled
        }
        
    }
    
    
    
    @IBAction func didSegmentedButtonPressed(_ sender: UISegmentedControl) {
        
        let title = segmentedControl.titleForSegment(at: segmentedControl.selectedSegmentIndex)
        authType = AuthType(text: title ?? "Sign In")
        
    }
    
    
    
    
    @IBAction func didConfirmButtonPressed(_ sender: UIButton) {
        
        guard let credential = emailTextField.text,
              let password = passwordTextField.text else {
            return
        }
        switch authType {
        case .signIn:
            viewModel.signIn(email: credential,
                             password: password,
                             completion: { [weak self] in
                guard let self = self else { return }
                let homeScreenViewModel = HomeScreenViewModel()
                let homeScreenViewController = HomeScreenViewController(viewModel: homeScreenViewModel)
                let searchScreenViewController = SearchViewController(searchViewModel: homeScreenViewModel)
                
                homeScreenViewController.tabBarItem = UITabBarItem(title: "Home", image: UIImage(named: "house"), selectedImage: UIImage(named: "house"))
                searchScreenViewController.tabBarItem = UITabBarItem(title: "Home", image: UIImage(named: "house"), selectedImage: UIImage(named: "house"))
                
                let tabBarController = UITabBarController()
                tabBarController.viewControllers = [homeScreenViewController, searchScreenViewController]
                self.navigationController?.pushViewController(tabBarController, animated: true)
            })
        case .signUp:
            viewModel.signUp(email: credential,
                             password: password)
        }
        
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


