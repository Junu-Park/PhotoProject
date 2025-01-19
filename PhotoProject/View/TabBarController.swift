//
//  TabBarController.swift
//  PhotoProject
//
//  Created by 박준우 on 1/19/25.
//

import UIKit

class TabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let tab1: UIViewController = TopicTabViewController()
        tab1.tabBarItem = TabBarEnum.TopicTab.tabBarItem
        let tab2: UIViewController = ShortFormViewController()
        tab2.tabBarItem = TabBarEnum.ShortFormTab.tabBarItem
        let tab3: UIViewController = SearchTabViewController()
        tab3.tabBarItem = TabBarEnum.SearchTab.tabBarItem
        let tab4: UIViewController = LikeTapViewController()
        tab4.tabBarItem = TabBarEnum.LikeTab.tabBarItem
        self.setViewControllers([tab1, tab2, tab3, tab4], animated: true)
        
        self.tabBar.tintColor = UIColor.black
        
        let appearance: UITabBarAppearance = UITabBarAppearance()
        appearance.backgroundColor = UIColor.white
        
        self.tabBar.standardAppearance = appearance
        self.tabBar.scrollEdgeAppearance = appearance
    }
}
