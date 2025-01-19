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
    var urls: URLs
    var likes: Int
}

struct URLs: Decodable {
    var raw: String
    var small: String
}
