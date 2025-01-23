//
//  ShortFormViewController.swift
//  PhotoProject
//
//  Created by 박준우 on 1/19/25.
//

import UIKit

import Kingfisher
import SnapKit

final class ShortFormViewController: CustomBaseViewController {
    
    let networkManager: NetworkManager = NetworkManager.shared
    
    private lazy var shortFormCollectionView: ShortFormCollectionView = {
        let cv = ShortFormCollectionView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: UIScreen.main.bounds.height), collectionViewLayout: UICollectionViewLayout())
        return cv
    }()
    
    private var data: [PhotoSearchResult] = []
    
    private var randomPhotoRequest: RandomPhotoRequest = RandomPhotoRequest(count: 10)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        connectCollectionView()
        shortFormCollectionView.contentInsetAdjustmentBehavior = .never
        
        networkManager.requestUnsplash(api: .getRandomPhotos(params: randomPhotoRequest), view: self) { (response: [PhotoSearchResult]) in
            self.data = response
            self.shortFormCollectionView.reloadData()
        } failureHandler: {
        }
    }
    
    override func configureHierarchy() {
        self.view.addSubview(shortFormCollectionView)
    }
    
    override func configureLayout() {
        shortFormCollectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}

extension ShortFormViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func connectCollectionView() {
        shortFormCollectionView.delegate = self
        shortFormCollectionView.dataSource = self
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ShortFormCollectionViewCell.id, for: indexPath) as! ShortFormCollectionViewCell
        cell.imageView.kf.setImage(with: URL(string: data[indexPath.item].urls.small))
        return cell
    }
}
