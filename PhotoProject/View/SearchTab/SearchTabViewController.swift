//
//  SearchTabViewController.swift
//  PhotoProject
//
//  Created by 박준우 on 1/19/25.
//

import UIKit

import Kingfisher
import SnapKit

final class SearchTabViewController: CustomBaseViewController {
    
    private lazy var colorFilterCV: ColorFilterCollectionView = ColorFilterCollectionView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: 50))
    
    private let sortButton: SortButton = SortButton()
    
    private lazy var photoCV: PhotoCollectionView = PhotoCollectionView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height / 1.5))
    
    let networkManager: NetworkManager = NetworkManager.shared

    private var photoSearchRequest: PhotoSearchRequest = PhotoSearchRequest()
    
    private var photoSearchResult: [PhotoSearchResult] = [] {
        willSet(newVal) {
            if newVal.count == 0 {
                photoCV.label.text = "검색 결과가 없습니다."
            } else {
                photoCV.label.text = ""
            }
            photoCV.reloadData()
        }
        didSet(oldVal) {
            if oldVal.count == 0 || oldVal.count == photoSearchRequest.per_page {
                self.photoCV.scrollToItem(at: IndexPath(item: 0, section: 0), at: .top, animated: true)
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        sortButton.addTarget(self, action: #selector(sortButtonTapped), for: .touchUpInside)
        connectSearchTextField()
    }
    
    override func configureNavigationItem() {
        self.navigationItem.backButtonDisplayMode = .minimal
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
    
    override func connectCollectionView() {
        colorFilterCV.tag = 1
        colorFilterCV.delegate = self
        colorFilterCV.dataSource = self
        photoCV.tag = 2
        photoCV.delegate = self
        photoCV.dataSource = self
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
            networkManager.requestUnsplashWithAlert(api: .searchPhotos(params: photoSearchRequest), view: self) { (response: PhotoSearchResponse) in
                self.photoSearchResult = response.results
            } failureHandler: {
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
            networkManager.requestUnsplashWithAlert(api: .searchPhotos(params: photoSearchRequest), view: self) { (response: PhotoSearchResponse) in
                self.photoSearchResult = response.results
            } failureHandler: {
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
            let filterList = ColorFilter.allCases
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ColorFilterCollectionViewCell.id, for: indexPath) as! ColorFilterCollectionViewCell
            cell.button.tintColor = filterList[indexPath.item].uiColor
            cell.button.setTitle(filterList[indexPath.item].rawValue, for: .normal)
            return cell
        case 2:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PhotoCollectionViewCell.id, for: indexPath) as! PhotoCollectionViewCell
            cell.imageView.kf.setImage(with: URL(string: photoSearchResult[indexPath.item].urls.small))
            cell.likeCountButton.setTitle("\(photoSearchResult[indexPath.item].likes.formatted())", for: .normal)
            if (indexPath.item + 2) == photoSearchResult.count {
                photoSearchRequest.page += 1
                networkManager.requestUnsplashWithAlert(api: .searchPhotos(params: photoSearchRequest), view: self) { (response: PhotoSearchResponse) in
                    self.photoSearchResult += response.results
                } failureHandler: {
                }
            }
            return cell
        default:
            return UICollectionViewCell()
        }
    }
    
    // TODO: Cell Button 말고 Label로 바꾸기,,,
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch collectionView.tag {
        case 1:
            let cell = collectionView.cellForItem(at: indexPath) as! ColorFilterCollectionViewCell
            self.photoSearchRequest.color = cell.button.title(for: .normal)
            if self.photoSearchRequest.query != "" {
                networkManager.requestUnsplashWithAlert(api: .searchPhotos(params: photoSearchRequest), view: self) { (response: PhotoSearchResponse) in
                    self.photoSearchResult = response.results
                } failureHandler: {
                }
            }
        case 2:
            let vc = PhotoDetailViewController()
            vc.viewModel.input.photoSearchData.value = photoSearchResult[indexPath.row]
            vc.viewModel.output.photoStatisticsData.lazyBind { [weak self] response in
                guard let response else {
                    // TODO: 에러처리
                    return
                }
                self?.navigationController?.pushViewController(vc, animated: true)
            }
        default:
            break
        }
    }
}
