//
//  HomeScreenViewModel.swift
//  Flickgram
//
//  Created by Asım can Yağız on 15.10.2022.
//

import Foundation
import Moya

enum PhotosChanges {
    case didErrorOccurred(_ error: Error)
    case didFetchPhotos
}

final class HomeScreenViewModel {
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
    
    func photoForIndexPath(_ indexPath: IndexPath) -> Photo? {
        photosResponse?.photos?.photo?[indexPath.row]
    }
}
