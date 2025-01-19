//
//  SearchTabViewController.swift
//  PhotoProject
//
//  Created by 박준우 on 1/19/25.
//

import UIKit

import SnapKit

class SearchTabViewController: CustomBaseViewController {
    
    lazy var colorFilterCV: ColorFilterCollectionView = ColorFilterCollectionView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: 50))
    
    let sortButton: SortButton = SortButton()
    
    lazy var photoCV: PhotoCollectionView = PhotoCollectionView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height / 1.5))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        connectCollectionView()
    }
    
    override func configureNavigationItem() {
        self.navigationItem.title = "SEARCH PHOTO"
        let sc: UISearchController = UISearchController()
        sc.hidesNavigationBarDuringPresentation = false
        sc.searchBar.placeholder = "키워드 검색"
        sc.automaticallyShowsCancelButton = false
        sc.searchBar.tintColor = UIColor.black
        self.navigationItem.searchController = sc
        
        // TODO: UISearchController 인스턴스를 self.navigationItem.searchController에 할당하고 나서 텍스트 컬러를 할당해줘야 색이 적용됨...? 왜...?
        sc.searchBar.searchTextField.textColor = UIColor.black
    }
    
    override func configureHierarchy() {
        view.addSubview(colorFilterCV)
        view.addSubview(sortButton)
        view.addSubview(photoCV)
    }
    
    override func configureLayout() {
        colorFilterCV.snp.makeConstraints { make in
            make.top.horizontalEdges.equalTo(view.safeAreaLayoutGuide)
            make.height.equalTo(50)
        }
        
        sortButton.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(4)
            make.trailing.equalToSuperview().offset(-4)
            make.width.equalTo(80)
            make.height.equalTo(40)
        }
        
        photoCV.snp.makeConstraints { make in
            make.top.equalTo(colorFilterCV.snp.bottom)
            make.horizontalEdges.equalToSuperview()
            make.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }
}

extension SearchTabViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func connectCollectionView() {
        colorFilterCV.tag = 1
        colorFilterCV.delegate = self
        colorFilterCV.dataSource = self
        photoCV.tag = 2
        photoCV.delegate = self
        photoCV.dataSource = self
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch collectionView.tag {
        case 1:
            return 10
        case 2:
            return 10
        default:
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        switch collectionView.tag {
        case 1:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ColorFilterCollectionViewCell.id, for: indexPath) as! ColorFilterCollectionViewCell
            cell.button.tintColor = .red
            cell.button.setTitle("색깔색깔", for: .normal)
            return cell
        case 2:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PhotoCollectionViewCell.id, for: indexPath) as! PhotoCollectionViewCell
            cell.backgroundColor = .red
            return cell
        default:
            return UICollectionViewCell()
        }
    }
}
