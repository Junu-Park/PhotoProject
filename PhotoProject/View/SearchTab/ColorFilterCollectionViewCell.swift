//
//  ColorFilterCollectionViewCell.swift
//  PhotoProject
//
//  Created by 박준우 on 1/19/25.
//

import UIKit

import SnapKit

class ColorFilterCollectionViewCell: UICollectionViewCell {
    
    static let id: String = "ColorFilterCollectionViewCell"
    
    lazy var button: UIButton = {
        let btn = UIButton()
        btn.backgroundColor = UIColor.systemGray6
        btn.layer.cornerRadius = 15
        btn.setTitleColor(UIColor.black, for: .normal)
        btn.setImage(UIImage(systemName: "circle.fill"), for: .normal)
        btn.configuration?.imagePadding = 4
        return btn
    }()
    
    override init(frame: CGRect = .zero) {
        super.init(frame: frame)
        
        contentView.addSubview(button)
        
        button.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(4)
        }
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
