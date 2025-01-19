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
    
    func requestPhotoSearch(params: PhotoSearchRequest, completionHander: @escaping ([PhotoSearchResult]) -> ()) {
        
        let header = HTTPHeader.init(name: "Authorization", value: "Client-ID \(APIKey.unsplashAccessKy.rawValue)")
        
        AF.request("\(APIURL.photoSearch.rawValue)query=\(params.query)&per_page=\(params.per_page)&order_by=\(params.order_by)&page=\(params.page)", headers: [header]).responseDecodable(of: PhotoSearchResponse.self) { response in
            switch response.result {
            case .success(let data):
                completionHander(data.results)
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func requestPhotoStatistics(params: PhotoStatisticsRequest, completionHander: @escaping (PhotoStatisticsResponse) -> ()) {
        
        let header = HTTPHeader.init(name: "Authorization", value: "Client-ID \(APIKey.unsplashAccessKy.rawValue)")
        
        AF.request("\(APIURL.photoStatistics.rawValue)\(params.id)/statistics?", headers: [header]).responseDecodable(of: PhotoStatisticsResponse.self) { response in
            switch response.result {
            case .success(let data):
                completionHander(data)
            case .failure(let error):
                print(error)
            }
        }
    }
}
