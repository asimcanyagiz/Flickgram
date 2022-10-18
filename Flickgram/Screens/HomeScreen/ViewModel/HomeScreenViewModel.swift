//
//  HomeScreenViewModel.swift
//  Flickgram
//
//  Created by Asım can Yağız on 15.10.2022.
//

import Foundation
import Moya
import FirebaseFirestore

@objc
protocol FavoritePhotoDelegate: AnyObject {
    @objc optional func didErrorOccurred(_ error: Error)
    @objc optional func didPhotoAddedToFavorites()
}

enum PhotosChanges {
    case didErrorOccurred(_ error: Error)
    case didFetchPhotos
}

final class HomeScreenViewModel {
    
    weak var delegate: FavoritePhotoDelegate?
    
    private let db = Firestore.firestore()
    
    private let defaults = UserDefaults.standard
    
    private var photosResponse: PhotosResponse? {
        didSet {
            self.changeHandler?(.didFetchPhotos)
        }
    }
    
    var changeHandler: ((PhotosChanges) -> Void)?
    
    var numberOfRows: Int {
        photosResponse?.photos?.photo?.count ?? .zero
    }
    
    func fetchPhotos() {
        provider.request(.recentPhotos) { result in
            switch result {
            case .failure(let error):
                self.changeHandler?(.didErrorOccurred(error))
            case .success(let response):
                do {
                    let photosResponse = try JSONDecoder().decode(PhotosResponse.self, from: response.data)
                    self.photosResponse = photosResponse
                } catch {
                    self.changeHandler?(.didErrorOccurred(error))
                }
            }
        }
    }
    
    func searchPhotos(searchText: String) {
        provider.request(.searchPhotos(text: searchText)) { result in
            switch result {
            case .failure(let error):
                self.changeHandler?(.didErrorOccurred(error))
            case .success(let response):
                do {
                    let photosResponse = try JSONDecoder().decode(PhotosResponse.self, from: response.data)
                    self.photosResponse = photosResponse
                } catch {
                    self.changeHandler?(.didErrorOccurred(error))
                }
            }
        }
    }
    
    func photoForIndexPath(_ indexPath: IndexPath) -> Photo? {
        photosResponse?.photos?.photo?[indexPath.row]
    }
    
    func addFavorite(_ number: Int) {
        guard let id = photosResponse?.photos?.photo?[number].iconUrl.absoluteString,
              let uid = defaults.string(forKey: UserDefaultConstants.uid.rawValue) else {
            return
        }
        
        db.collection("users").document(uid).updateData([
            "favorites": FieldValue.arrayUnion([id])
        ])
        
        delegate?.didPhotoAddedToFavorites?()
    }
}
