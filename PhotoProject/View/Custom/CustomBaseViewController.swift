//
//  CustomBaseViewController.swift
//  PhotoProject
//
//  Created by 박준우 on 1/19/25.
//

import UIKit

protocol ViewControllerProtocol {
    func configureNavigationItem()
    func configureHierarchy()
    func configureLayout()
}

class CustomBaseViewController: UIViewController, ViewControllerProtocol {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureNavigationItem()
        configureHierarchy()
        configureLayout()
    }
    
    func configureNavigationItem() {
        
    }
    
    func configureHierarchy() {
        
    }
    
    func configureLayout() {
        
    }
}
