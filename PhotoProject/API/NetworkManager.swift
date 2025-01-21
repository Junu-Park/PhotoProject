//
//  NetworkManager.swift
//  PhotoProject
//
//  Created by 박준우 on 1/19/25.
//

import Foundation

import Alamofire

class NetworkManager {
    static let shared = NetworkManager()
    
    private init() {}
    
    // TODO: successHandler의 리턴 값은 Any로 어찌저찌 처리가 되는데, Decode Type은 해결이 힘들다,,,
    func requestUnsplash(api: UnsplashAPI, successHandler: @escaping (Any) -> (), failureHandler: @escaping () -> ()) {
        let dataRequest = AF.request(api.endPointURLString, method: api.method, parameters: api.parameters, encoding: URLEncoding.queryString, headers: UnsplashAPI.headers)
        
        switch api {
        case .searchPhotos:
            dataRequest.responseDecodable(of: PhotoSearchResponse.self) { response in
                switch response.result {
                case .success(let data):
                    successHandler(data.results)
                case .failure(let error):
                    print("searchPhotos fail, \(error)")
                    failureHandler()
                }
            }
        case .getPhotoStatistics:
            dataRequest.responseDecodable(of: PhotoStatisticsResponse.self) { response in
                switch response.result {
                case .success(let data):
                    successHandler(data)
                case .failure(let error):
                    print("getPhotoStatistics fail, \(error)")
                    failureHandler()
                }
            }
        case .getTopicPhotos:
            dataRequest.responseDecodable(of: [PhotoSearchResult].self) { response in
                switch response.result {
                case .success(let data):
                    successHandler(data)
                case .failure(let error):
                    print("getTopicPhotos fail, \(error)")
                    failureHandler()
                }
            }
        }
    }
}
