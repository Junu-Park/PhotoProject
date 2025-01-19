//
//  PhotoCollectionView.swift
//  PhotoProject
//
//  Created by 박준우 on 1/19/25.
//

import UIKit

import SnapKit

class PhotoCollectionView: UICollectionView {
    
    let label: UILabel = {
        let lb: UILabel = UILabel()
        lb.text = "사진을 검색해보세요."
        lb.textColor = UIColor.black
        lb.textAlignment = .center
        lb.font = UIFont.boldSystemFont(ofSize: 17)
        return lb
    }()
    
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 2
        layout.itemSize = CGSize(width: (frame.width - 2) / 2, height: frame.height / 2.5)
        super.init(frame: frame, collectionViewLayout: layout)
        self.collectionViewLayout = layout
        self.register(PhotoCollectionViewCell.self, forCellWithReuseIdentifier: PhotoCollectionViewCell.id)
        
        self.addSubview(label)
        
        label.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
