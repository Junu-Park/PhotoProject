//
//  PhotoSearchRequest.swift
//  PhotoProject
//
//  Created by 박준우 on 1/19/25.
//

import Foundation

struct PhotoSearchRequest {
    var query: String
    var page: Int = 1
    var per_page: Int = 20
    var order_by: String = SortEnum.relevant.rawValue
    var color: String
}
