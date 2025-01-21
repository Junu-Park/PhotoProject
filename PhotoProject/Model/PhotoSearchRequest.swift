//
//  PhotoSearchRequest.swift
//  PhotoProject
//
//  Created by 박준우 on 1/19/25.
//

import Foundation

struct PhotoSearchRequest {
    var query: String = ""
    var page: Int = 1
    var per_page: Int = 20
    var order_by: String = SortEnum.relevant.rawValue
    var color: String?
    
    // TODO: color 쿼리 파라미터 넣기
    func toDictionary() -> [String: Any] {
        if let color = self.color {
            return [
                "query": self.query,
                "page": self.page,
                "per_page": self.per_page,
                "order_by": self.order_by,
                "color": color
            ]
        } else {
            return [
                "query": self.query,
                "page": self.page,
                "per_page": self.per_page,
                "order_by": self.order_by
            ]
        }
    }
}
