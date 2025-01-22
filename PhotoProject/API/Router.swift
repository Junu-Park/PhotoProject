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

enum UnsplashError: Int {
    case badRequest = 400
    case unAuthorized = 401
    case forbidden = 403
    case notFound = 404
    case internalServerError1 = 500
    case internalServerError2 = 503
    
    var description: String {
        switch self {
        case .badRequest:
            return "The request was unacceptable,\noften due to missing a required parameter"
        case .unAuthorized:
            return "Invalid Access Token"
        case .forbidden:
            return "Missing permissions to perform request"
        case .notFound:
            return "The requested resource doesn’t exist"
        case .internalServerError1, .internalServerError2:
            return "Something went wrong on Unsplash end"
        }
    }
}
