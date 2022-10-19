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
    
    //Cases for auth screen calls
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
    
    
    //MARK: - View Loads
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Control the inputs for cases and catch the results
        viewModel.changeHandler = { change in
            switch change {
            case .didErrorOccurred(let error):
                self.showError(error)
            case .didSignUpSuccessful:
                self.showAlert(title: "SIGN UP SUCCESSFUL!")
            }
        }
        
        title = "Auth"
        
        //Catch the data for remoteconfig
        viewModel.fetchRemoteConfig { isSignUpDisabled in
            self.segmentedControl.isHidden = isSignUpDisabled
        }
        
    }
    
    
    //MARK: - Functions
    //When you pressed segmented button title change
    @IBAction func didSegmentedButtonPressed(_ sender: UISegmentedControl) {
        
        let title = segmentedControl.titleForSegment(at: segmentedControl.selectedSegmentIndex)
        authType = AuthType(text: title ?? "Sign In")
        
    }
    
    
    
    //Input orianted functions with button
    @IBAction func didConfirmButtonPressed(_ sender: UIButton) {
        
        //inputs
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
                
                //MARK: - Navigation/Tabbar connections
                //With this area we create and push navigations when user sign in
                let homeScreenViewModel = HomeScreenViewModel()
                let homeScreenViewController = HomeScreenViewController(viewModel: homeScreenViewModel)
                let searchScreenViewController = SearchViewController(searchViewModel: homeScreenViewModel)
                let personalViewController = PersonalViewController(personalViewModel: homeScreenViewModel)
                
                homeScreenViewController.tabBarItem = UITabBarItem(title: "Home", image: UIImage(named: "house"), selectedImage: UIImage(named: "house"))
                searchScreenViewController.tabBarItem = UITabBarItem(title: "Search", image: UIImage(named: "magnifyingglass.circle"), selectedImage: UIImage(named: "magnifyingglass"))
                personalViewController.tabBarItem = UITabBarItem(title: "Profile", image: UIImage(named: "person"), selectedImage: UIImage(named: "person"))
                
                let tabBarController = UITabBarController()
                tabBarController.viewControllers = [homeScreenViewController, searchScreenViewController, personalViewController]
                self.navigationController?.pushViewController(tabBarController, animated: true)
                self.navigationController?.navigationItem.hidesBackButton = true
                tabBarController.navigationItem.hidesBackButton = true
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


