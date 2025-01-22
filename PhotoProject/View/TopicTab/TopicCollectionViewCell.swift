//
//  TopicCollectionViewCell.swift
//  PhotoProject
//
//  Created by 박준우 on 1/20/25.
//

import UIKit

import SnapKit

final class TopicCollectionViewCell: UICollectionViewCell {
    static let id = "TopicCollectionViewCell"
    
    let imageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleToFill
        return iv
    }()
    
    let likeButton: UIButton = {
        let btn = UIButton(type: .custom)
        btn.layer.cornerRadius = 10
        btn.backgroundColor = UIColor.darkGray
        btn.setTitleColor(.white, for: .normal)
        btn.setImage(UIImage(systemName: "star.fill"), for: .normal)
        btn.tintColor = .yellow
        return btn
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.addSubview(imageView)
        contentView.addSubview(likeButton)
        
        contentView.layer.cornerRadius = 15
        contentView.clipsToBounds = true
        
        imageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        likeButton.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(8)
            make.bottom.equalToSuperview().offset(-8)
        }
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
