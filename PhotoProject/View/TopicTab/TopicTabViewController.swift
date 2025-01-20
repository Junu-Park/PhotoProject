//
//  TopicTabViewController.swift
//  PhotoProject
//
//  Created by 박준우 on 1/19/25.
//

import UIKit

import Kingfisher
import SnapKit

class TopicTabViewController: CustomBaseViewController {

    let mainScrollView: UIScrollView = UIScrollView()
    
    let goldenHourLabel: UILabel = {
        let lb: UILabel = UILabel()
        lb.textColor = UIColor.black
        lb.font = .boldSystemFont(ofSize: 17)
        lb.text = "골든 아워"
        return lb
    }()
    
    lazy var goldenHourCollectionView: TopicCollectionView = {
        let cv = TopicCollectionView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: 200))
        return cv
    }()
    
    let businessLabel: UILabel = {
        let lb: UILabel = UILabel()
        lb.textColor = UIColor.black
        lb.font = .boldSystemFont(ofSize: 17)
        lb.text = "비즈니스 및 업무"
        return lb
    }()
    
    lazy var businessCollectionView: TopicCollectionView = {
        let cv = TopicCollectionView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: 200))
        return cv
    }()
    
    let architectureLabel: UILabel = {
        let lb: UILabel = UILabel()
        lb.textColor = UIColor.black
        lb.font = .boldSystemFont(ofSize: 17)
        lb.text = "건축 및 인테리어"
        return lb
    }()
    
    lazy var architectureCollectionView: TopicCollectionView = {
        let cv = TopicCollectionView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: 200))
        return cv
    }()
    
    let networkManager: NetworkManager = NetworkManager.shared
    
    var goldenHourTopicPhotoResponse: [TopicPhotoResponse]?
    var businessTopicPhotoResponse: [TopicPhotoResponse]?
    var architectureTopicPhotoResponse: [TopicPhotoResponse]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        connectCollectionView()
        
        let dispatchGroup = DispatchGroup()
        
        dispatchGroup.enter()
        DispatchQueue.global().async {
            self.networkManager.requestTopicPhoto(params: TopicPhotoRequest(id: "golden-hour")) { response in
                self.goldenHourTopicPhotoResponse = response
                dispatchGroup.leave()
            }
        }
        
        dispatchGroup.enter()
        DispatchQueue.global().async {
            self.networkManager.requestTopicPhoto(params: TopicPhotoRequest(id: "business-work")) { response in
                self.businessTopicPhotoResponse = response
                dispatchGroup.leave()
            }
        }
        
        dispatchGroup.enter()
        DispatchQueue.global().async {
            self.networkManager.requestTopicPhoto(params: TopicPhotoRequest(id: "architecture-interior")) { response in
                self.architectureTopicPhotoResponse = response
                dispatchGroup.leave()
            }
        }
        
        dispatchGroup.notify(queue: .main) {
            self.goldenHourCollectionView.reloadData()
            self.businessCollectionView.reloadData()
            self.architectureCollectionView.reloadData()
        }
    }
    
    override func configureNavigationItem() {
        self.navigationItem.title = "OUR TOPIC"
    }
    
    override func configureHierarchy() {
        view.addSubview(mainScrollView)
        mainScrollView.addSubview(goldenHourLabel)
        mainScrollView.addSubview(goldenHourCollectionView)
        mainScrollView.addSubview(businessLabel)
        mainScrollView.addSubview(businessCollectionView)
        mainScrollView.addSubview(architectureLabel)
        mainScrollView.addSubview(architectureCollectionView)
    }
    
    override func configureLayout() {
        
        mainScrollView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
        
        goldenHourLabel.snp.makeConstraints { make in
            make.top.leading.equalToSuperview().offset(16)
        }
        
        goldenHourCollectionView.snp.makeConstraints { make in
            make.top.equalTo(goldenHourLabel.snp.bottom).offset(16)
            /*
             TODO: make.horizontalEdges.equalToSuperview()를 사용하면 뷰가 나타나지 않고 make.width.equalToSuperview()를 사용해야 뷰가 나타난다.
             */
//            make.horizontalEdges.equalToSuperview()
            make.width.equalToSuperview()
            make.height.equalTo(200)
        }
        
        businessLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16)
            make.top.equalTo(goldenHourCollectionView.snp.bottom).offset(16)
        }
        
        businessCollectionView.snp.makeConstraints { make in
            make.top.equalTo(businessLabel.snp.bottom).offset(16)
            make.width.equalToSuperview()
            make.height.equalTo(200)
        }
        
        architectureLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16)
            make.top.equalTo(businessCollectionView.snp.bottom).offset(16)
        }
        
        architectureCollectionView.snp.makeConstraints { make in
            make.top.equalTo(architectureLabel.snp.bottom).offset(16)
            make.width.equalToSuperview()
            make.height.equalTo(200)
            make.bottom.equalToSuperview()
        }
    }
}

extension TopicTabViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func connectCollectionView() {
        goldenHourCollectionView.tag = 1
        goldenHourCollectionView.delegate = self
        goldenHourCollectionView.dataSource = self
        
        businessCollectionView.tag = 2
        businessCollectionView.delegate = self
        businessCollectionView.dataSource = self
        
        architectureCollectionView.tag = 3
        architectureCollectionView.delegate = self
        architectureCollectionView.dataSource = self
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TopicCollectionViewCell.id, for: indexPath) as? TopicCollectionViewCell {
            let data: TopicPhotoResponse?
            
            switch collectionView.tag {
            case 1:
                data = goldenHourTopicPhotoResponse?[indexPath.item]
            case 2:
                data = businessTopicPhotoResponse?[indexPath.item]
            case 3:
                data = architectureTopicPhotoResponse?[indexPath.item]
            default:
                data = nil
            }
            
            if let data {
                cell.imageView.kf.setImage(with: URL(string: data.urls.small))
                cell.likeButton.setTitle("\(data.likes)", for: .normal)
            }
            
            return cell
        } else {
            return UICollectionViewCell()
        }
    }
}
