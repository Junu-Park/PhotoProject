//
//  ShortFormCollectionViewCell.swift
//  PhotoProject
//
//  Created by 박준우 on 1/22/25.
//

import UIKit

import SnapKit

class ShortFormCollectionViewCell: UICollectionViewCell {
    
    static let id: String = "ShortFormCollectionViewCell"
    
    let imageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleToFill
        return iv
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.contentView.addSubview(imageView)
        
        imageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
