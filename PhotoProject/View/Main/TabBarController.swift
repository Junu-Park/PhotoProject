//
//  TabBarController.swift
//  PhotoProject
//
//  Created by 박준우 on 1/19/25.
//

import UIKit

final class TabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tab1Navi: UINavigationController = UINavigationController(rootViewController: TopicTabViewController())
        tab1Navi.navigationBar.tintColor = UIColor.black
        tab1Navi.navigationBar.prefersLargeTitles = true
        tab1Navi.tabBarItem = TabBarEnum.TopicTab.tabBarItem
        
        let tab2: UIViewController = ShortFormViewController()
        tab2.tabBarItem = TabBarEnum.ShortFormTab.tabBarItem
        
        let tab3Navi: UINavigationController = UINavigationController(rootViewController: SearchTabViewController())
        tab3Navi.navigationBar.tintColor = UIColor.black
        let naviBarAppearance3: UINavigationBarAppearance = UINavigationBarAppearance()
        naviBarAppearance3.backgroundColor = UIColor.white
        tab3Navi.navigationBar.scrollEdgeAppearance = naviBarAppearance3
        tab3Navi.tabBarItem = TabBarEnum.SearchTab.tabBarItem
        
        let tab4: UIViewController = LikeTapViewController()
        tab4.tabBarItem = TabBarEnum.LikeTab.tabBarItem
        
        self.setViewControllers([tab1Navi, tab2, tab3Navi, tab4], animated: true)
        
        self.tabBar.tintColor = UIColor.black
        
        let tabBarAppearance: UITabBarAppearance = UITabBarAppearance()
        tabBarAppearance.backgroundColor = UIColor.white
        
        self.tabBar.standardAppearance = tabBarAppearance
        self.tabBar.scrollEdgeAppearance = tabBarAppearance
    }
}
