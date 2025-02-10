//
//  NetworkManager.swift
//  PhotoProject
//
//  Created by 박준우 on 1/19/25.
//

import UIKit

import Alamofire

final class NetworkManager {
    static let shared = NetworkManager()
    
    private init() {}
    
    func requestUnsplash<T: Decodable>(api: UnsplashAPI,successHandler: @escaping (T) -> (), failureHandler: @escaping () -> ()) {
        AF.request(api.endPointURLString, method: api.method, parameters: api.parameters, encoding: URLEncoding.queryString, headers: UnsplashAPI.headers).validate(statusCode: 200...503).responseDecodable(of: T.self) { response in
            switch response.result {
            case .success(let data):
                successHandler(data)
            case .failure:
                failureHandler()
            }
        }
    }
    func requestUnsplashWithAlert<T: Decodable, U: UIViewController>(api: UnsplashAPI, view: U, successHandler: @escaping (T) -> (), failureHandler: @escaping () -> ()) {
        AF.request(api.endPointURLString, method: api.method, parameters: api.parameters, encoding: URLEncoding.queryString, headers: UnsplashAPI.headers).validate(statusCode: 200...503).responseDecodable(of: T.self) { response in
            switch response.result {
            case .success(let data):
                successHandler(data)
            case .failure:
                failureHandler()
                view.presentAlert(errorCode: response.response?.statusCode)
            }
        }
    }
}
