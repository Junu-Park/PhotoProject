//
//  RandomPhotoRequest.swift
//  PhotoProject
//
//  Created by 박준우 on 1/22/25.
//

import Foundation

struct RandomPhotoRequest {
    var count = 1
    
    func toDictionary() -> [String: Any] {
        return ["count": count]
    }
}
