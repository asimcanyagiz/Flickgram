//
//  Photo.swift
//  Flickgram
//
//  Created by Asım can Yağız on 14.10.2022.
//

import Foundation

struct Photo: Codable {
    let id, owner, secret, server: String
    let farm: Int
    let title: String
    let ispublic, isfriend, isfamily: Int
    let datetaken: String
    let datetakengranularity: Int
    let datetakenunknown, ownername: String
    let urlZ: String
    let heightZ, widthZ: Int

    enum CodingKeys: String, CodingKey {
        case id, owner, secret, server, farm, title, ispublic, isfriend, isfamily, datetaken, datetakengranularity, datetakenunknown, ownername
        case urlZ = "url_z"
        case heightZ = "height_z"
        case widthZ = "width_z"
    }
}
