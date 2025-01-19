//
//  SortButton.swift
//  PhotoProject
//
//  Created by 박준우 on 1/19/25.
//

import UIKit

enum SortEnum: String {
    case relevant = "relevant"
    case latest = "latest"
}

class SortButton: UIButton {
    
    var sortType: SortEnum = .relevant {
        willSet(newVal) {
            setTitleWithSortType(newVal)
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.white
        self.setImage(UIImage(systemName: "line.3.horizontal.decrease"), for: .normal)
        self.setTitleColor(UIColor.black, for: .normal)
        self.tintColor = UIColor.black
        self.layer.cornerRadius = 20
        self.layer.borderColor = UIColor.systemGray6.cgColor
        self.layer.borderWidth = 2
        
        self.setTitle("관련순", for: .normal)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setTitleWithSortType(_ SortType: SortEnum){
        switch SortType {
        case .relevant:
            self.setTitle("관련순", for: .normal)
        case .latest:
            self.setTitle("최신순", for: .normal)
        }
    }
}
