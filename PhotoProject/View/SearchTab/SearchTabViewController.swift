//
//  SearchTabViewController.swift
//  PhotoProject
//
//  Created by 박준우 on 1/19/25.
//

import UIKit

import Kingfisher
import SnapKit

class SearchTabViewController: CustomBaseViewController {
    
    lazy var colorFilterCV: ColorFilterCollectionView = ColorFilterCollectionView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: 50))
    
    let sortButton: SortButton = SortButton()
    
    lazy var photoCV: PhotoCollectionView = PhotoCollectionView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height / 1.5))
    
    let networkManager: NetworkManager = NetworkManager.shared

    var photoSearchRequest: PhotoSearchRequest = PhotoSearchRequest(query: "", page: 1, color: "")
    
    var photoSearchResult: [PhotoSearchResult] = [] {
        willSet(oldVal) {
            if oldVal.count == 0 {
                photoCV.label.text = "검색 결과가 없습니다."
            } else {
                photoCV.label.text = ""
            }
            photoCV.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        sortButton.addTarget(self, action: #selector(sortButtonTapped), for: .touchUpInside)
        connectSearchTextField()
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
    
    @objc func sortButtonTapped() {
        switch sortButton.sortType {
        case .relevant:
            sortButton.sortType = .latest
        case .latest:
            sortButton.sortType = .relevant
        }
        photoSearchRequest.page = 1
        photoSearchRequest.order_by = sortButton.sortType.rawValue
        if let text = self.navigationItem.searchController!.searchBar.searchTextField.text, !text.isEmpty {
            self.photoCV.scrollToItem(at: IndexPath(item: 0, section: 0), at: .top, animated: true)
            networkManager.requestPhotoSearch(params: photoSearchRequest) { result in
                self.photoSearchResult = result
            }
        }
    }
}

extension SearchTabViewController: UISearchTextFieldDelegate {
    
    func connectSearchTextField() {
        self.navigationItem.searchController!.searchBar.searchTextField.delegate = self
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if let text = textField.text, !text.isEmpty {
            photoSearchRequest.page = 1
            photoSearchRequest.query =  text
            if photoSearchResult.count > 0 {
                self.photoCV.scrollToItem(at: IndexPath(item: 0, section: 0), at: .top, animated: true)
            }
            networkManager.requestPhotoSearch(params: photoSearchRequest) { result in
                self.photoSearchResult = result
            }
            return true
        } else {
            return false
        }
    }
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        photoSearchRequest.query = textField.text ?? ""
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
            return photoSearchResult.count
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
            cell.imageView.kf.setImage(with: URL(string: photoSearchResult[indexPath.item].urls.small))
            cell.likeCountButton.setTitle("\(photoSearchResult[indexPath.item].likes.formatted())", for: .normal)
            if (indexPath.item + 2) == photoSearchResult.count {
                photoSearchRequest.page += 1
                networkManager.requestPhotoSearch(params: photoSearchRequest) { result in
                    self.photoSearchResult += result
                }
            }
            return cell
        default:
            return UICollectionViewCell()
        }
    }
}
