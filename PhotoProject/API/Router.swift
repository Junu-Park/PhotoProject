//
//  Router.swift
//  PhotoProject
//
//  Created by 박준우 on 1/22/25.
//

import Foundation

import Alamofire

enum UnsplashAPI {
    
    static let headers: HTTPHeaders = [HTTPHeader(name: "Authorization", value: "Client-ID \(APIKey.unsplashAccessKey.rawValue)")]
    
    static let baseURLString = "https://api.unsplash.com/"
    
    case searchPhotos(params: PhotoSearchRequest)
    case getPhotoStatistics(id: String)
    case getTopicPhotos(id: String)
    case getRandomPhotos(params: RandomPhotoRequest)
    
    var endPointURLString: String {
        switch self {
        case .searchPhotos:
            return UnsplashAPI.baseURLString + "search/photos/"
        case .getPhotoStatistics(let id):
            return UnsplashAPI.baseURLString + "photos/\(id)/statistics/"
        case .getTopicPhotos(let id):
            return UnsplashAPI.baseURLString + "topics/\(id)/photos/"
        case .getRandomPhotos:
            return UnsplashAPI.baseURLString + "photos/random/"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .searchPhotos, .getPhotoStatistics, .getTopicPhotos, .getRandomPhotos:
            return .get
        }
    }
    
    var parameters: Parameters? {
        switch self {
        case .searchPhotos(let params):
            return params.toDictionary()
        case .getPhotoStatistics:
            return nil
        case .getTopicPhotos:
            return nil
        case .getRandomPhotos(let params):
            return params.toDictionary()
        }
    }
}
