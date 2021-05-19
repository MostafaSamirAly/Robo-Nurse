//
//  DataLoadingVC.swift
//  Etbo5ly
//
//  Created by Mostafa Samir on 12/10/20.
//  Copyright © 2020 Mostafa Samir. All rights reserved.
//

import UIKit
class DataLoadingVC: UIViewController {
    
    var containerView:UIView!
    
    func showLoadingView(){
        if containerView == nil {
            containerView = UIView(frame: view.bounds)
            view.addSubview(containerView)
            NSLayoutConstraint.activate([
                containerView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
                containerView.centerXAnchor.constraint(equalTo: view.centerXAnchor)
            ])
            containerView.backgroundColor = .white
            containerView.alpha = 0.5
            
            let activivtyIndicator = UIActivityIndicatorView(style: .medium)
            //activivtyIndicator.color = UIColor(hexString: "#FE8563")
            containerView.addSubview(activivtyIndicator)
            
            activivtyIndicator.translatesAutoresizingMaskIntoConstraints = false
            
            NSLayoutConstraint.activate([
                activivtyIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor),
                activivtyIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor)
            ])
            activivtyIndicator.startAnimating()
        }
    }
    
    func dismissLoadingView(){
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            if let _ = self.containerView {
                self.containerView.removeFromSuperview()
                self.containerView = nil
            }
        }
    }

}
