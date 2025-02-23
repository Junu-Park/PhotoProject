//
//  PhotoDetailViewController.swift
//  PhotoProject
//
//  Created by 박준우 on 1/20/25.
//

import UIKit

import Alamofire
import Kingfisher
import SnapKit

final class PhotoDetailViewController: CustomBaseViewController {

    private let profileImageView: UIImageView = {
        let iv = UIImageView()
        iv.frame = CGRect(x: 0, y: 0, width: 10, height: 10)
        iv.layer.cornerRadius = 30
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        return iv
    }()
    
    private let profileNameLabel: UILabel = {
        let lb = UILabel()
        lb.textColor = UIColor.black
        lb.font = UIFont.systemFont(ofSize: 12)
        return lb
    }()
    
    private let imageDateLabel: UILabel = {
        let lb = UILabel()
        lb.textColor = UIColor.black
        lb.font = UIFont.boldSystemFont(ofSize: 12)
        return lb
    }()
    
    private let likeButton: UIButton = {
        let btn = UIButton()
        btn.frame = CGRect(x: 0, y: 0, width: 20, height: 20)
        btn.setImage(UIImage(systemName: "heart.fill"), for: .normal)
        btn.tintColor = UIColor.red
        return btn
    }()
    
    private let photoImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleToFill
        
        return iv
    }()
    
    private let infoLabel: UILabel = {
        let lb = UILabel()
        lb.text = "정보"
        lb.textColor = UIColor.black
        lb.font = UIFont.boldSystemFont(ofSize: 15)
        return lb
    }()
    
    private let infoTitleLabelStackView: UIStackView = {
        let sv = UIStackView()
        sv.axis = .vertical
        let sizeLB = UILabel()
        sizeLB.font = UIFont.boldSystemFont(ofSize: 13)
        sizeLB.text = "크기"
        sv.addArrangedSubview(sizeLB)
        let viewLB = UILabel()
        viewLB.font = UIFont.boldSystemFont(ofSize: 13)
        viewLB.text = "조회수"
        sv.addArrangedSubview(viewLB)
        let downloadLB = UILabel()
        downloadLB.font = UIFont.boldSystemFont(ofSize: 13)
        downloadLB.text = "다운로드"
        sv.addArrangedSubview(downloadLB)
        sv.spacing = 16
        return sv
    }()
    
    private lazy var infoDataLabelStackView: UIStackView = {
        let sv = UIStackView()
        sv.axis = .vertical
        let sizeLB = UILabel()
        sizeLB.textAlignment = .right
        sizeLB.font = UIFont.boldSystemFont(ofSize: 13)
        sizeLB.text = "\(viewModel.output.photoSearchData.value.width) x \(viewModel.output.photoSearchData.value.height)"
        sv.addArrangedSubview(sizeLB)
        let viewLB = UILabel()
        viewLB.textAlignment = .right
        viewLB.font = UIFont.boldSystemFont(ofSize: 13)
        viewLB.text = "\(viewModel.output.photoStatisticsData.value?.views.total.formatted() ?? "0")"
        sv.addArrangedSubview(viewLB)
        let downloadLB = UILabel()
        downloadLB.textAlignment = .right
        downloadLB.font = UIFont.boldSystemFont(ofSize: 13)
        downloadLB.text = "\(viewModel.output.photoStatisticsData.value?.downloads.total.formatted() ?? "0")"
        sv.addArrangedSubview(downloadLB)
        sv.spacing = 16
        return sv
    }()
    
    let viewModel: PhotoDetailViewModel = PhotoDetailViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        profileImageView.kf.setImage(with: URL(string: self.viewModel.output.photoSearchData.value.user.profile_image.medium))
        profileNameLabel.text = self.viewModel.output.photoSearchData.value.user.name
        imageDateLabel.text = self.viewModel.output.photoSearchData.value.created_at.convertDateString()
        photoImageView.kf.setImage(with: URL(string: self.viewModel.output.photoSearchData.value.urls.small))
    }
    
    override func configureNavigationItem() {
        self.navigationController?.navigationBar.prefersLargeTitles = false
        let appearance = UINavigationBarAppearance()
        appearance.backgroundColor = UIColor.white
        self.navigationController?.navigationBar.scrollEdgeAppearance = appearance
    }
    
    override func configureHierarchy() {
        view.addSubview(profileImageView)
        view.addSubview(profileNameLabel)
        view.addSubview(imageDateLabel)
        view.addSubview(likeButton)
        view.addSubview(photoImageView)
        view.addSubview(infoLabel)
        view.addSubview(infoTitleLabelStackView)
        view.addSubview(infoDataLabelStackView)
    }
    
    override func configureLayout() {
        profileImageView.snp.makeConstraints { make in
            make.top.leading.equalTo(view.safeAreaLayoutGuide).offset(16)
        }
        
        profileNameLabel.snp.makeConstraints { make in
            make.leading.equalTo(profileImageView.snp.trailing).offset(8)
            make.bottom.equalTo(profileImageView.snp.centerY).offset(-4)
        }
        
        imageDateLabel.snp.makeConstraints { make in
            make.leading.equalTo(profileImageView.snp.trailing).offset(8)
            make.top.equalTo(profileImageView.snp.centerY).offset(4)
        }
        
        likeButton.snp.makeConstraints { make in
            make.centerY.equalTo(profileImageView.snp.centerY)
            make.trailing.equalToSuperview().offset(-16)
        }
        
        photoImageView.snp.makeConstraints { make in
            make.top.equalTo(profileImageView.snp.bottom).offset(16)
            make.horizontalEdges.equalToSuperview()
            make.height.equalTo(200)
        }
        
        infoLabel.snp.makeConstraints { make in
            make.top.equalTo(photoImageView.snp.bottom).offset(16)
            make.leading.equalToSuperview().offset(16)
        }
        
        infoTitleLabelStackView.snp.makeConstraints { make in
            make.leading.equalTo(infoLabel.snp.trailing).offset(16)
            make.top.equalTo(photoImageView.snp.bottom).offset(16)
        }
        
        infoDataLabelStackView.snp.makeConstraints { make in
            make.trailing.equalToSuperview().offset(-16)
            make.top.equalTo(photoImageView.snp.bottom).offset(16)
        }
    }
}
