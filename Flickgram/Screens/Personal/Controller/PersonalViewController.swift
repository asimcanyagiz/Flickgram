//
//  PersonalViewController.swift
//  Flickgram
//
//  Created by Asım can Yağız on 18.10.2022.
//

import UIKit
import FirebaseAuth

class PersonalViewController: UIViewController, AlertPresentable {
    
    private let personalViewModel: HomeScreenViewModel
    
    
    @IBOutlet weak var personalCollectionView: UICollectionView!
    
    // MARK: - Init View model
    init(personalViewModel: HomeScreenViewModel){
        self.personalViewModel = personalViewModel
        super.init(nibName: nil, bundle: nil)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - View Loads
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Navigation Bar control
        title = "Profile"
        self.parent?.title = "Profile"
        
        //Connect collection view extensions
        personalCollectionView.dataSource = self
        personalCollectionView.delegate = self
        
        let nib = UINib(nibName: "PersonalCollectionViewCell", bundle: nil)
        
        personalCollectionView.register(nib, forCellWithReuseIdentifier: "cell")
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        personalCollectionView.reloadData()

    }
    //MARK: - Functions
    //Functions for go to Auth Screen and sign out from Firebase
    @IBAction func didLogOutPressed(_ sender: UIButton) {
        
        showAlert(title: "Warning",
                  message: "Are you sure to sign out?",
                  cancelButtonTitle: "Cancel") { _ in
            do {
                try Auth.auth().signOut()
                self.navigationController?.popToRootViewController(animated: true)
            } catch {
                self.showError(error)
            }
        }
        
    }
    
    
    //Segmented Button control
    @IBAction func didSegmentedButtonPressed(_ sender: Any) {
        
        personalCollectionView.reloadData()
        
    }
}

//MARK: - Delegates
extension PersonalViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        //This are for design cell sizes
        let screenWidth = UIScreen.main.bounds.width
        let scaleFactor = (screenWidth / 2) - 6
        
        return CGSize(width: scaleFactor, height: scaleFactor)
    }
}

extension PersonalViewController: UICollectionViewDelegate {
    func tableView(_ collectionView: UICollectionView, didSelectRowAt indexPath: IndexPath) {
    }
}

extension PersonalViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        personalViewModel.personalNumberOfRows
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! PersonalCollectionViewCell

        guard let photo = personalViewModel.photosForIndexPaths(indexPath) else {
            fatalError("Photo not found")
        }
        cell.personalImageViewCell.kf.setImage(with: URL(string: photo))
        
        //Animate cells when they will appear or reload data
        cell.layer.transform = CATransform3DMakeScale(0.1,0.1,1)
        UIView.animate(withDuration: 0.25, animations: {
            cell.layer.transform = CATransform3DMakeScale(1,1,1)
        })
        return cell
    }
}
