//
//  SearchViewController.swift
//  Flickgram
//
//  Created by Asım can Yağız on 16.10.2022.
//

import UIKit

class SearchViewController: UIViewController {
    private var searchViewModel: HomeScreenViewModel
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    
    //MARK: - Init View Model
    init(searchViewModel: HomeScreenViewModel){
        self.searchViewModel = searchViewModel
        super.init(nibName: nil, bundle: nil)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    //MARK: - ViewDidLoad
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        title = "Search"
        self.parent?.title = "Search"
        
        //collection delegates
        collectionView.dataSource = self
        collectionView.delegate = self
        
        let nib = UINib(nibName: "SearchScreenCollectionViewCell", bundle: nil)
        
        collectionView.register(nib, forCellWithReuseIdentifier: "cell")
        
        
        //For catch Photos and update cells
        searchViewModel.fetchPhotos()
        
        searchViewModel.changeHandler = { change in
            switch change {
            case .didFetchPhotos:
                self.collectionView.reloadData()
                
            case .didErrorOccurred(let error):
                print(error.localizedDescription)
            }
        }
        
        //SearchBar adaption
        let searchBar:UISearchBar = UISearchBar()
        searchBar.searchBarStyle = UISearchBar.Style.prominent
        searchBar.placeholder = " Search..."
        searchBar.sizeToFit()
        searchBar.isTranslucent = false
        searchBar.backgroundImage = UIImage()
        searchBar.delegate = self
        collectionView.addSubview(searchBar)
        
    }
    
}

//MARK: - Delegates
extension SearchViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        //Cell sizes
        let screenWidth = UIScreen.main.bounds.width
        let scaleFactor = (screenWidth / 2) - 6

        return CGSize(width: scaleFactor, height: scaleFactor)
    }
}

extension SearchViewController: UICollectionViewDelegate {
    func tableView(_ collectionView: UICollectionView, didSelectRowAt indexPath: IndexPath) {
    }
}

extension SearchViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return searchViewModel.numberOfRows
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! SearchScreenCollectionViewCell
        
        guard let photo = searchViewModel.photoForIndexPath(indexPath) else {
            fatalError("Photo not found")
        }
        
        //Catch photos with kingfisher
        cell.imageViewCell.kf.setImage(with: photo.iconUrl)
        return cell
    }
}

// MARK: - UISearchResultsUpdating
extension SearchViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange textSearched: String) {
        if let text = searchBar.text, textSearched.count > 1 {
            searchViewModel.searchPhotos(searchText: text)
        }
    }
}
