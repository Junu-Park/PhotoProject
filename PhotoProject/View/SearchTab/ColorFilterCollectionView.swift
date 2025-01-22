//
//  ColorFilterCollectionView.swift
//  PhotoProject
//
//  Created by 박준우 on 1/19/25.
//

import UIKit

final class ColorFilterCollectionView: UICollectionView {

    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout = UICollectionViewFlowLayout()) {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.itemSize = CGSize(width: 100, height: 40)
        super.init(frame: frame, collectionViewLayout: layout)
        self.collectionViewLayout = layout
        self.register(ColorFilterCollectionViewCell.self, forCellWithReuseIdentifier: ColorFilterCollectionViewCell.id)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
