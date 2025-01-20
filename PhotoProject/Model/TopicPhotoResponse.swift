//
//  TopicPhotoResponse.swift
//  PhotoProject
//
//  Created by 박준우 on 1/20/25.
//

import Foundation

struct TopicPhotoResponse: Decodable {
    var id: String
    var created_at: String
    var width: Int
    var height: Int
    var urls: URLs
    var likes: Int
    var user: User
}
