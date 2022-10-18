//
//  FireBaseFireStoreAccessible.swift
//  Flickgram
//
//  Created by Asım can Yağız on 18.10.2022.
//

import Foundation
import FirebaseFirestore

protocol FireBaseFireStoreAccessible {}

extension FireBaseFireStoreAccessible {
    var db: Firestore {
        Firestore.firestore()
    }
}
