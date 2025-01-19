//
//  TopicTabViewController.swift
//  PhotoProject
//
//  Created by 박준우 on 1/19/25.
//

import UIKit

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
    
    let goldenHourScrollView: UIScrollView = UIScrollView()
    
    let businessLabel: UILabel = {
        let lb: UILabel = UILabel()
        lb.textColor = UIColor.black
        lb.font = .boldSystemFont(ofSize: 17)
        lb.text = "비즈니스 및 업무"
        return lb
    }()
    
    let businessScrollView: UIScrollView = UIScrollView()
    
    let architectureLabel: UILabel = {
        let lb: UILabel = UILabel()
        lb.textColor = UIColor.black
        lb.font = .boldSystemFont(ofSize: 17)
        lb.text = "건축 및 인테리어"
        return lb
    }()
    
    let architectureScrollView: UIScrollView = UIScrollView()
    
    let imageView: UIImageView = {
        let iv: UIImageView = UIImageView()
        iv.contentMode = .scaleToFill
        return iv
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func configureNavigationItem() {
        self.navigationItem.title = "OUR TOPIC"
    }
    
    override func configureHierarchy() {
        view.addSubview(mainScrollView)
        
        mainScrollView.addSubview(goldenHourLabel)
        mainScrollView.addSubview(goldenHourScrollView)
        goldenHourScrollView.addSubview(imageView)
        
        mainScrollView.addSubview(businessLabel)
        mainScrollView.addSubview(businessScrollView)
        
        mainScrollView.addSubview(architectureLabel)
        mainScrollView.addSubview(architectureScrollView)

    }
    
    override func configureLayout() {
        mainScrollView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
        
        goldenHourLabel.snp.makeConstraints { make in
            make.top.equalTo(mainScrollView.snp.top).offset(16)
            make.leading.equalTo(mainScrollView.snp.leading).offset(16)
        }
        
        goldenHourScrollView.snp.makeConstraints { make in
            make.top.equalTo(goldenHourLabel.snp.bottom).offset(16)
            make.height.equalTo(200)
            make.horizontalEdges.equalToSuperview()
        }
        
        imageView.snp.makeConstraints { make in
            make.verticalEdges.equalToSuperview()
            make.width.equalTo(150)
        }
        
        businessLabel.snp.makeConstraints { make in
            make.top.equalTo(goldenHourScrollView.snp.bottom).offset(16)
            make.leading.equalTo(mainScrollView.snp.leading).offset(16)
        }
        
        businessScrollView.snp.makeConstraints { make in
            make.top.equalTo(businessLabel.snp.bottom).offset(16)
            make.height.equalTo(200)
            make.horizontalEdges.equalToSuperview()
        }
        
        architectureLabel.snp.makeConstraints { make in
            make.top.equalTo(businessScrollView.snp.bottom).offset(16)
            make.leading.equalTo(mainScrollView.snp.leading).offset(16)
        }
        
        architectureScrollView.snp.makeConstraints { make in
            make.top.equalTo(architectureLabel.snp.bottom).offset(16)
            make.height.equalTo(200)
            make.horizontalEdges.equalToSuperview()
        }
    }
}
