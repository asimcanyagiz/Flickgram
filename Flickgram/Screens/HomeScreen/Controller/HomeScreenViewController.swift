//
//  HomeScreenViewController.swift
//  Flickgram
//
//  Created by Asım can Yağız on 14.10.2022.
//

import UIKit
import Kingfisher

final class HomeScreenViewController: UIViewController, AlertPresentable {
    private var viewModel: HomeScreenViewModel
    
    @IBOutlet private weak var tableView : UITableView!
    
    // MARK: - Init
    init(viewModel: HomeScreenViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - View Loads
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Photos"
        self.parent?.title = "Photos"
        
        tableView.delegate = self
        tableView.dataSource = self
        
        let nib = UINib(nibName: "PostsTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "cell")
        
        //Fetch photos from api and firebase
        viewModel.fetchPhotos()
        viewModel.fetchFavorites { error in
            if let error = error {
                self.showError(error)
            } else {
                self.reloadInputViews()
            }
        }
        //Catch the result
        viewModel.changeHandler = { change in
            switch change {
            case .didFetchPhotos:
                self.tableView.reloadData()
            case .didErrorOccurred(let error):
                print(error.localizedDescription)
            }
        }
    }
    override func viewWillAppear(_ animated: Bool) {
        //Fetch the photo from firebase
        viewModel.fetchFavorites { error in
            if let error = error {
                self.showError(error)
            } else {
                self.reloadInputViews()
            }
        }
    }
    
}

// MARK: - UITableViewDelegate
extension HomeScreenViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    }
}

// MARK: - UITableViewDataSource
extension HomeScreenViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRows
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! PostsTableViewCell
        guard let photo = viewModel.photoForIndexPath(indexPath) else {
            fatalError("photos not found.")
        }
        
        //Catch photos with Kingfisher
        cell.iconImageView.kf.setImage(with: photo.iconUrl) { _ in
            tableView.reloadRows(at: [indexPath], with: .automatic)
        }
        cell.profilePicImageView.kf.setImage(with: photo.iconUrl) { _ in
            tableView.reloadRows(at: [indexPath], with: .automatic)
        }
        //Make circle the profile image
        cell.profilePicImageView.layer.masksToBounds = true
        cell.profilePicImageView.layer.cornerRadius = cell.profilePicImageView.bounds.width / 2
        
        cell.ownerLabel.text = photo.ownername
        
        //Add target to buttons for connect cells
        cell.likeButton.tag = indexPath.row
        cell.likeButton.addTarget(self, action: #selector(HomeScreenViewController.onClickedLikeButton(_:)), for: .touchUpInside)
        cell.saveButton.addTarget(self, action: #selector(HomeScreenViewController.onClickedSaveButton(_:)), for: .touchUpInside)
        viewModel.addFavorite(cell.indexNumber)
        
        return cell
    }
    //Functions for alert the user
    @objc func onClickedLikeButton(_ sender: Any?) {
        showAlert(title: "Success!", message: "Your choice will be added your favorites after the security progress, don't forget to check", cancelButtonTitle: nil)
        
        tableView.reloadData()
    }
    @objc func onClickedSaveButton(_ sender: Any?) {
        showAlert(title: "Success!", message: "Unfortunately we can't access to your phone albums but they will be added your favorites after the security progress, don't forget to check", cancelButtonTitle: nil)
        
        tableView.reloadData()
    }
    
    
    
}


