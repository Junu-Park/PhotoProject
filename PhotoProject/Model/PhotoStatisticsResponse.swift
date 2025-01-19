//
//  PhotoStatisticsResponse.swift
//  PhotoProject
//
//  Created by 박준우 on 1/20/25.
//

import Foundation

struct PhotoStatisticsResponse: Decodable {
    var id: String
    var downloads: Downloads
    var views: Views
}

struct Downloads: Decodable {
    var total: Int
    var historical: Historical
}

struct Views: Decodable {
    var total: Int
    var historical: Historical
}

struct Historical: Decodable {
    var values: [Value]
}

struct Value: Decodable {
    var date: String
    var value: Int
}


