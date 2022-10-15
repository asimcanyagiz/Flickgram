//
//  HomeScreenViewController.swift
//  Flickgram
//
//  Created by Asım can Yağız on 14.10.2022.
//

import UIKit
import Kingfisher

final class HomeScreenViewController: UIViewController {
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
        
        viewModel.changeHandler = { change in
            switch change {
            case .didFetchPhotos:
                self.tableView.reloadData()
            case .didErrorOccurred(let error):
                print(error.localizedDescription)
            }
        }
    }
}

 // MARK: - UITableViewDelegate
extension HomeScreenViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let photo = viewModel.photoForIndexPath(indexPath) else {
            return
        }
        //let viewModel = HomeScreenViewModel(photo: photo)
        //navigationController?.pushViewController(viewController, animated: true)
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
        
        cell.title = photo.title
        cell.price = photo.owner
        cell.imageView?.kf.setImage(with: photo.iconUrl) { _ in
            tableView.reloadRows(at: [indexPath], with: .automatic)
        }
        
        return cell
    }
}
