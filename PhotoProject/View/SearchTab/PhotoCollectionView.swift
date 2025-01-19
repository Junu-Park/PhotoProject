//
//  PhotoCollectionView.swift
//  PhotoProject
//
//  Created by 박준우 on 1/19/25.
//

import UIKit

class PhotoCollectionView: UICollectionView {
    
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 2
        layout.itemSize = CGSize(width: (frame.width - 2) / 2, height: frame.height / 2.5)
        super.init(frame: frame, collectionViewLayout: layout)
        self.collectionViewLayout = layout
        self.register(PhotoCollectionViewCell.self, forCellWithReuseIdentifier: PhotoCollectionViewCell.id)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
