//
//  ShortFormCollectionView.swift
//  PhotoProject
//
//  Created by 박준우 on 1/22/25.
//

import UIKit

class ShortFormCollectionView: UICollectionView {

    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        layout.itemSize = CGSize(width: frame.width, height: frame.height)
        super.init(frame: frame, collectionViewLayout: layout)
        self.register(ShortFormCollectionViewCell.self, forCellWithReuseIdentifier: ShortFormCollectionViewCell.id)
        self.collectionViewLayout = layout
        self.isPagingEnabled = true
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
