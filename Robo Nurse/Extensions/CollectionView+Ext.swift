//
//  File.swift
//  RWrite
//
//  Created by Mostafa Samir on 11/19/20.
//  Copyright © 2020 Mostafa Samir. All rights reserved.
//

import UIKit

extension UICollectionView {
    func setEmptyView(title: String, message: String) {
        let emptyView = UIView(frame: CGRect(x: self.center.x, y: self.center.y, width: self.bounds.size.width, height: self.bounds.size.height))
        let titleLabel = UILabel()
        let messageLabel = UILabel()
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        messageLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.textColor = UIColor(hexString: "#6D6E71")
        titleLabel.font = UIFont.systemFont(ofSize: 18,weight: .semibold)
        messageLabel.textColor = UIColor(hexString: "#6D6E71")
        messageLabel.font = UIFont.systemFont(ofSize: 14,weight: .regular)
        emptyView.addSubview(titleLabel)
        emptyView.addSubview(messageLabel)
        titleLabel.centerYAnchor.constraint(equalTo: emptyView.centerYAnchor).isActive = true
        titleLabel.centerXAnchor.constraint(equalTo: emptyView.centerXAnchor).isActive = true
        messageLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20).isActive = true
        messageLabel.leftAnchor.constraint(equalTo: emptyView.leftAnchor, constant: 20).isActive = true
        messageLabel.rightAnchor.constraint(equalTo: emptyView.rightAnchor, constant: -20).isActive = true
        titleLabel.text = title
        messageLabel.text = message
        messageLabel.numberOfLines = 0
        messageLabel.textAlignment = .center
        self.backgroundView = emptyView
    }
    func restore() {
        self.backgroundView = nil
    }
    
    func reloadDataOnMainThread(){
        DispatchQueue.main.async {
            self.reloadData()
        }
    }
}
