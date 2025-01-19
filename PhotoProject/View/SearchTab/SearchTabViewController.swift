//
//  SearchTabViewController.swift
//  PhotoProject
//
//  Created by 박준우 on 1/19/25.
//

import UIKit

class SearchTabViewController: CustomBaseViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
}
