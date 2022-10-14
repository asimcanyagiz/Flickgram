//
//  FlickrApi.swift
//  Flickgram
//
//  Created by Asım can Yağız on 14.10.2022.
//

import Foundation
import Moya

enum FlickrApi {
    case recentPhotos
}

// MARK: - TargetType
extension FlickrApi: TargetType {
    public var baseURL: URL { return URL(string: "https://api.flickr.com")! }

             private var apiKey: String { return "854e5cbc4cb5f855f73b5d394b3230de" }
    
    var path: String {
        switch self {
        case .recentPhotos:
            return "/services/rest/?method=flickr.photos.getRecent&api_key=854e5cbc4cb5f855f73b5d394b3230de&format=json&nojsoncallback=1"
        }
    }
    
    var method: Moya.Method {
        .get
    }
    
    var task: Moya.Task {
        switch self {
        case .recentPhotos:
            return .requestPlain
        }
    }
    
    var headers: [String : String]? {
        nil
    }
}
