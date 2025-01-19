//
//  Extension+String.swift
//  PhotoProject
//
//  Created by 박준우 on 1/20/25.
//

import Foundation

extension String {
    func convertDateString() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZZZZZ"
        let date = dateFormatter.date(from: self)
        dateFormatter.dateFormat = "yyyy년 M월 d일 게시됨"
        return dateFormatter.string(from: date!)
    }
}
