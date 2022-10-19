//
//  PersonalViewController.swift
//  Flickgram
//
//  Created by Asım can Yağız on 18.10.2022.
//

import UIKit

class PersonalViewController: UIViewController, AlertPresentable {
    
    private let personalViewModel: HomeScreenViewModel
    
    private var isAnyCoinAddedToFavorites: Bool = true
    
    
    @IBOutlet weak var personalCollectionView: UICollectionView!
    
    // MARK: - Init
    init(personalViewModel: HomeScreenViewModel){
        self.personalViewModel = personalViewModel
        super.init(nibName: nil, bundle: nil)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Profile"
        
//        personalViewModel.fetchFavorites { error in
//            if let error = error {
//                self.showError(error)
//            } else {
//                self.reloadInputViews()
//            }
//        }
        
        personalCollectionView.dataSource = self
        personalCollectionView.delegate = self
        
        let nib = UINib(nibName: "PersonalCollectionViewCell", bundle: nil)
        
        personalCollectionView.register(nib, forCellWithReuseIdentifier: "cell")
        
       
        
//        personalViewModel.fetchPhotos()
//
//        personalViewModel.changeHandler = { change in
//            switch change {
//            case .didFetchPhotos:
//                self.personalCollectionView.reloadData()
//
//            case .didErrorOccurred(let error):
//                print(error.localizedDescription)
//            }
//        }
    }
    override func viewWillAppear(_ animated: Bool) {
        personalCollectionView.reloadData()
    }
    
    // MARK: - Methods
    private func fetchFavorites() {
        if isAnyCoinAddedToFavorites {
            isAnyCoinAddedToFavorites = false
            personalViewModel.fetchFavorites { error in
                if let error = error {
                    self.showError(error)
                } else {
                    self.reloadInputViews()
                }
            }
        }
    }
    
    @objc private func didAnyCoinAddedToFavorites() {
        isAnyCoinAddedToFavorites = true
    }
}

extension PersonalViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
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
        
//        guard let photo = personalViewModel.photoForIndexPath(indexPath) else {
//            fatalError("Photo not found")
//        }
//
//        cell.personalImageViewCell.kf.setImage(with: photo.iconUrl)
        guard let photo = personalViewModel.coinForIndexPath(indexPath) else {
                    fatalError("Photo not found")
                }
        cell.personalImageViewCell.kf.setImage(with: URL(string: photo))
        return cell
    }
}
