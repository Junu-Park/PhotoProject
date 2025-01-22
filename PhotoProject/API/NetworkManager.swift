//
//  NetworkManager.swift
//  PhotoProject
//
//  Created by 박준우 on 1/19/25.
//

import Foundation

import Alamofire

final class NetworkManager {
    static let shared = NetworkManager()
    
    private init() {}
    
    func requestUnsplash<T: Decodable>(api: UnsplashAPI, successHandler: @escaping (T) -> (), failureHandler: @escaping () -> ()) {
        AF.request(api.endPointURLString, method: api.method, parameters: api.parameters, encoding: URLEncoding.queryString, headers: UnsplashAPI.headers).responseDecodable(of: T.self) { response in
            switch response.result {
            case .success(let data):
                successHandler(data)
            case .failure(let error):
                print("requestUnsplash fail, \(error)")
                failureHandler()
            }
        }
    }
}
