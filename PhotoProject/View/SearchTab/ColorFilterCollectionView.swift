//
//  ColorFilterCollectionView.swift
//  PhotoProject
//
//  Created by 박준우 on 1/19/25.
//

import UIKit

enum ColorFilter: String {
    case black_and_white = "black_and_white"
    case black = "black"
    case white = "white"
    case yellow = "yellow"
    case orange = "orange"
    case red = "red"
    case purple = "purple"
    case magenta = "magenta"
    case green = "green"
    case blue = "blue"
    
    // TODO: UIColor는 systemColor를 String으로 접근하는 방법 없을까...?
    var uiColor: UIColor {
        switch self {
        case .black_and_white:
            return .black.withAlphaComponent(0.5)
        case .black:
            return .black
        case .white:
            return .white
        case .yellow:
            return .yellow
        case .orange:
            return .orange
        case .red:
            return .red
        case .purple:
            return .purple
        case .magenta:
            return .magenta
        case .green:
            return .green
        case .blue:
            return .blue
        }
    }
}

final class ColorFilterCollectionView: UICollectionView {

    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout = UICollectionViewFlowLayout()) {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 0
        layout.sectionInset = .init(top: 0, left: 0, bottom: 0, right: 88)
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
