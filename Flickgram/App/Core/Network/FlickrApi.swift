//
//  FlickrApi.swift
//  Flickgram
//
//  Created by Asım can Yağız on 14.10.2022.
//

import Foundation
import Moya

let plugin: PluginType = NetworkLoggerPlugin(configuration: .init(logOptions: .verbose))
let provider = MoyaProvider<FlickrApi>(plugins: [plugin])

enum FlickrApi {
    case recentPhotos
    case searchPhotos(text: String)
}

// MARK: - TargetType
extension FlickrApi: TargetType {
    var baseURL: URL {
        guard let url = URL(string: "https://flickr.com/services/rest")
        else {
            fatalError("Base URL not found or not in correct format")
        }
        return url
    }
    
    private var apiKey: String { return "854e5cbc4cb5f855f73b5d394b3230de" }
    
    var path: String {
        "/"
    }
    
    var method: Moya.Method {
        .get
    }
    
    var task: Moya.Task {
        switch self {
        case .recentPhotos:
            let parameters: [String: Any] = ["method" : "flickr.photos.getRecent",
                                             "api_key" : "854e5cbc4cb5f855f73b5d394b3230de",
                                             "extras" : "owner_name,url_z,url_m,icon_server,date_taken",
                                             "format" : "json",
                                             "page" : 10,
                                             "nojsoncallback" : 1,
            ]
            return .requestParameters(parameters: parameters, encoding: URLEncoding.queryString)
        case .searchPhotos(let text):
            let parameters: [String: Any] = ["method" : "flickr.photos.search",
                                             "text" : text,
                                             "api_key" : "854e5cbc4cb5f855f73b5d394b3230de",
                                             "extras" : "owner_name,url_z,url_m,icon_server,date_taken",
                                             "format" : "json",
                                             "page" : 10,
                                             "nojsoncallback" : 1,
            ]
            return .requestParameters(parameters: parameters, encoding: URLEncoding.queryString)
        }
    }
    
    var headers: [String : String]? {
        nil
    }
}
