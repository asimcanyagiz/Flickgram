////
////  PersonalViewModel.swift
////  Flickgram
////
////  Created by Asım can Yağız on 18.10.2022.
////
//
import Foundation
import Moya

final class PersonalViewModel : CAViewModel {
    
    private var photos = [Photo]()
    
    var numberOfRows: Int {
        photos.count
    }
    
    func photoForIndexPath(_ indexPath: IndexPath) -> Photo? {
        photos[indexPath.row]
    }
    
    
    func fetchFavorites(_ completion: @escaping (Error?) -> Void) {
        
        photos = []
        
        guard let uid = uid else {
            return
        }
        
        db.collection("users").document(uid).getDocument() { (querySnapshot, err) in
            guard let data = querySnapshot?.data() else {
                return
            }
            let user = User(from: data)
            
            user.favorites?.forEach({ photoURL in
                self.db.collection("photos").document(photoURL).getDocument { (querySnapshot, err) in
                    if let err = err {
                        completion(err)
                    } else {
                        guard let data = querySnapshot?.data() else {
                            return
                        }
                        let photo = Photo(from: data)
                        self.photos.append(photo)
                        completion(nil)
                    }
                }
            })
        }
    }
    
}
