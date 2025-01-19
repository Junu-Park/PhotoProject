//
//  PhotoSearchResponse.swift
//  PhotoProject
//
//  Created by 박준우 on 1/19/25.
//

import Foundation

struct PhotoSearchResponse: Decodable {
    var total: Int
    var total_pages: Int
    var results: [PhotoSearchResult]
}

struct PhotoSearchResult: Decodable {
    var id: String
    var created_at: String
    var width: Int
    var height: Int
    var urls: URLs
    var likes: Int
    var user: User
}

struct URLs: Decodable {
    var raw: String
    var small: String
}

struct User: Decodable {
    var name: String
    var profile_image: ProfileImage
}

struct ProfileImage: Decodable {
    var medium: String
}
