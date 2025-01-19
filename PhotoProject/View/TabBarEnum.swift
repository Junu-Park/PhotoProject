//
//  TabBarItemEnum.swift
//  PhotoProject
//
//  Created by 박준우 on 1/19/25.
//

import UIKit

enum TabBarEnum {
    case TopicTab
    case ShortFormTab
    case SearchTab
    case LikeTab
    
    var tabBarItem: UITabBarItem {
        switch self {
        case .TopicTab:
            return UITabBarItem(title: "", image: UIImage(systemName: "chart.line.uptrend.xyaxis"), selectedImage: UIImage(systemName: "chart.line.uptrend.xyaxis"))
        case .ShortFormTab:
            return UITabBarItem(title: "", image: UIImage(systemName: "movieclapper"), selectedImage: UIImage(systemName: "movieclapper.fill"))
        case .SearchTab:
            return UITabBarItem(title: "", image: UIImage(systemName: "magnifyingglass"), selectedImage: UIImage(systemName: "magnifyingglass"))
        case .LikeTab:
            return UITabBarItem(title: "", image: UIImage(systemName: "heart"), selectedImage: UIImage(systemName: "heart.fill"))
        }
    }
}
