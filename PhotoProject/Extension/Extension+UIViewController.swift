//
//  Extension+UIViewController.swift
//  PhotoProject
//
//  Created by 박준우 on 1/22/25.
//

import UIKit

extension UIViewController {
    func presentAlert(errorCode: Int?) {
        let ac: UIAlertController = UIAlertController(title: "Network Error", message: UnsplashError.init(rawValue: errorCode ?? 0)?.description ?? "Unknown Error", preferredStyle: .alert)
        
        let action: UIAlertAction = UIAlertAction(title: "확인", style: .cancel)
        
        ac.addAction(action)
        
        self.present(ac, animated: true)
    }
}
