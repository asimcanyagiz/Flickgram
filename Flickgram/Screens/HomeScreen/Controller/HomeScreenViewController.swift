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
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Photos"
        
        tableView.delegate = self
        tableView.dataSource = self
        
        let nib = UINib(nibName: "PostsTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "cell")
        
        viewModel.fetchPhotos()
        viewModel.fetchFavorites { error in
            if let error = error {
                self.showError(error)
            } else {
                self.reloadInputViews()
            }
        }
        
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
        
        //        cell.title = photo.title
        //        cell.price = photo.owner
        //        cell.imageView?.kf.setImage(with: photo.iconUrl) { _ in
        //            tableView.reloadRows(at: [indexPath], with: .automatic)
        //        }
        
        cell.iconImageView.kf.setImage(with: photo.iconUrl) { _ in
            tableView.reloadRows(at: [indexPath], with: .automatic)
        }
        cell.profilePicImageView.kf.setImage(with: photo.iconUrl) { _ in
            tableView.reloadRows(at: [indexPath], with: .automatic)
        }
        cell.likeButton.tag = indexPath.row
        cell.likeButton.addTarget(self, action: #selector(HomeScreenViewController.onClickedMapButton(_:)), for: .touchUpInside)
        DispatchQueue.main.async {
            self.viewModel.addFavorite(cell.indexNumber)
        }
        
        
        return cell
    }
    
    @objc func onClickedMapButton(_ sender: Any?) {

        print("tapped")
    }
    
    
    
}


