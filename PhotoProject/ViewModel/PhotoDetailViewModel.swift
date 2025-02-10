//
//  PhotoDetailViewModel.swift
//  PhotoProject
//
//  Created by 박준우 on 2/10/25.
//

import UIKit

protocol ViewModelProtocol {
    associatedtype Input
    associatedtype Output
    
    func configureInput()
}

final class PhotoDetailViewModel: ViewModelProtocol {
    struct Input {
        let photoSearchData: Observer<PhotoSearchResult?> = Observer(value: nil)
        let photoStatisticsData: Observer<PhotoStatisticsResponse?> = Observer(value: nil)
    }
    struct Output {
        let photoSearchData: Observer<PhotoSearchResult> = Observer(value: PhotoSearchResult(id: "", created_at: "", width: 0, height: 0, urls: URLs(raw: "", small: ""), likes: 0, user: User(name: "", profile_image: ProfileImage(medium: ""))))
        let photoStatisticsData: Observer<PhotoStatisticsResponse?> = Observer(value: nil)
    }
    
    let input: Input = Input()
    let output: Output = Output()
    
    init() {
        self.configureInput()
    }
    
    func configureInput() {
        self.input.photoSearchData.lazyBind { result in
            if let result {
                self.output.photoSearchData.value = result
                
                NetworkManager.shared.requestUnsplash(api: .getPhotoStatistics(id: result.id)) { (response: PhotoStatisticsResponse) in
                    self.output.photoStatisticsData.value = response
                } failureHandler: {
                    self.output.photoStatisticsData.value = nil
                }
            }

        }
    }
}
