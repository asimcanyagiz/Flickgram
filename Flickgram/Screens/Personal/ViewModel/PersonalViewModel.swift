//////
//////  PersonalViewModel.swift
//////  Flickgram
//////
//////  Created by Asım can Yağız on 18.10.2022.
//////
////
//import Foundation
//import Moya
//
//final class PersonalViewModel : CAViewModel {
//    
//    private var number = [String]()
//    
//    var numberOfRows: Int {
//        number.count
//    }
//    
////    func photoForIndexPath(_ indexPath: IndexPath) -> Photo? {
//////        photos[indexPath.row]
////    }
//    
//    
//    func fetchFavorites(_ completion: @escaping (Error?) -> Void) {
//        
//        number = []
//        
//        guard let uid = uid else {
//            return
//        }
//        
//        db.collection("users").document(uid).getDocument() { (querySnapshot, err) in
//            guard let data = querySnapshot?.data() else {
//                return
//            }
//            let user = User(from: data)
//            print(user.favorites?.count)
//            
//            user.favorites?.forEach({
//                word in
//                self.number.append(word)
//                
//            })
//            print(self.number)
//            print(self.number.count)
//        }
//    }
//    
//}
