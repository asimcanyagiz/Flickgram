//
//  SearchViewController.swift
//  Flickgram
//
//  Created by Asım can Yağız on 16.10.2022.
//

import UIKit

class SearchViewController: UIViewController {
    private var searchViewModel: HomeScreenViewModel
    
    @IBOutlet weak var searchTableView: UITableView!
    
    init(searchViewModel: HomeScreenViewModel){
        self.searchViewModel = searchViewModel
        super.init(nibName: nil, bundle: nil)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Photos"
        
        searchTableView.delegate = self
        searchTableView.dataSource = self
        
        let nib = UINib(nibName: "SearchScreenTableViewCell", bundle: nil)
        searchTableView.register(nib, forCellReuseIdentifier: "cell")
        
        searchViewModel.fetchPhotos()
        
        searchViewModel.changeHandler = { change in
            switch change {
            case .didFetchPhotos:
                self.searchTableView.reloadData()
                
            case .didErrorOccurred(let error):
                print(error.localizedDescription)
            }
        }
    }
}

// MARK: - UITableViewDelegate
extension SearchViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let photo = searchViewModel.photoForIndexPath(indexPath) else {
            return
        }
        //let viewModel = HomeScreenViewModel(photo: photo)
        //navigationController?.pushViewController(viewController, animated: true)
    }
}

// MARK: - UITableViewDataSource
extension SearchViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchViewModel.numberOfRows
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! SearchScreenTableViewCell
        guard let photo = searchViewModel.photoForIndexPath(indexPath) else {
            fatalError("photos not found.")
        }
        
        //        cell.title = photo.title
        //        cell.price = photo.owner
        //        cell.imageView?.kf.setImage(with: photo.iconUrl) { _ in
        //            tableView.reloadRows(at: [indexPath], with: .automatic)
        //        }
        
        cell.firstImageView.kf.setImage(with: photo.iconUrl) { _ in
            tableView.reloadRows(at: [indexPath], with: .automatic)
        }
        
        return cell
    }
}
