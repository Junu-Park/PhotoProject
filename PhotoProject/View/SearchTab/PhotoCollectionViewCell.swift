//
//  PhotoCollectionViewCell.swift
//  PhotoProject
//
//  Created by 박준우 on 1/19/25.
//

import UIKit

import SnapKit

class PhotoCollectionViewCell: UICollectionViewCell {
    
    static let id: String = "PhotoCollectionViewCell"
    
    let imageView: UIImageView = UIImageView()
    
    let likeCountButton: UIButton = {
        let btn: UIButton = UIButton()
        btn.setTitleColor(UIColor.white, for: .normal)
        btn.tintColor = UIColor.yellow
        btn.setImage(UIImage(systemName: "star.fill"), for: .normal)
        btn.backgroundColor = UIColor.darkGray.withAlphaComponent(0.7)
        btn.layer.cornerRadius = 15
        return btn
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        imageView.contentMode = .scaleToFill
        
        contentView.addSubview(imageView)
        contentView.addSubview(likeCountButton)
        
        imageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        likeCountButton.snp.makeConstraints { make in
            make.height.equalTo(30)
            make.leading.equalToSuperview().offset(16)
            make.bottom.equalToSuperview().offset(-16)
        }
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
