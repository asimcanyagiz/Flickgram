//
//  SearchScreenViewModel.swift
//  Flickgram
//
//  Created by Asım can Yağız on 16.10.2022.
//

//import Foundation
//import Moya
//
//enum SearchPhotosChanges {
//    case didErrorOccurred(_ error: Error)
//    case didFetchSearchPhotos
//}
//
//final class SearchScreenViewModel {
//    private var searchPhotosResponse: SearchPhotosResponse? {
//        didSet {
//            self.changeHandler?(.didFetchSearchPhotos)
//        }
//    }
//
//    var changeHandler: ((SearchPhotosChanges) -> Void)?
//
//    var numberOfRows: Int {
//        searchPhotosResponse?.searchPhotos?.searchPhoto?.count ?? .zero
//    }
//
//    func fetchPhotos() {
//        provider.request(.recentPhotos) { result in
//            switch result {
//            case .failure(let error):
//                self.changeHandler?(.didErrorOccurred(error))
//            case .success(let response):
//                do {
//                    let searchPhotosResponse = try JSONDecoder().decode(SearchPhotosResponse.self, from: response.data)
//                    self.searchPhotosResponse = searchPhotosResponse
//                } catch {
//                    self.changeHandler?(.didErrorOccurred(error))
//                }
//            }
//        }
//    }
//
//    func searchPhotos(searchText: String) {
//        provider.request(.searchPhotos(text: searchText)) { result in
//            switch result {
//            case .failure(let error):
//                self.changeHandler?(.didErrorOccurred(error))
//            case .success(let response):
//                do {
//                    let searchPhotosResponse = try JSONDecoder().decode(SearchPhotosResponse.self, from: response.data)
//                    self.searchPhotosResponse = searchPhotosResponse
//                } catch {
//                    self.changeHandler?(.didErrorOccurred(error))
//                }
//            }
//        }
//    }
//
//    func photoForIndexPath(_ indexPath: IndexPath) -> SearchPhoto? {
//        searchPhotosResponse?.searchPhotos?.searchPhoto?[indexPath.row]
//    }
//}
