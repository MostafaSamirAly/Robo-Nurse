//
//  TopBackView.swift
//  Clozzit
//
//  Created by Momentum Solution Mac Mini on 2/11/21.
//  Copyright © 2021 Mostafa Samir. All rights reserved.
//

import UIKit

class TopBackView: UIView {
    let titleLabel = UILabel()
    let backBtn = UIButton()
    
    @IBInspectable var labelText:String? {
        didSet {
            titleLabel.text = labelText
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupViews()
    }
    
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        setupViews()
    }
    
    func setupViews() {
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        //titleLabel.textColor = UIColor(hexString: "#6D6E71")
        titleLabel.numberOfLines = 0
        
        backBtn.translatesAutoresizingMaskIntoConstraints = false
        backBtn.setImage(#imageLiteral(resourceName: "arrow-left"), for: .normal)
        backBtn.addTarget(self, action: #selector(backBtnTapped), for: .touchUpInside)
        layoutUI()
    }
    
    func layoutUI() {
        addSubview(titleLabel)
        addSubview(backBtn)
        NSLayoutConstraint.activate([
            backBtn.heightAnchor.constraint(equalToConstant: 25),
            backBtn.widthAnchor.constraint(equalToConstant: 25),
            backBtn.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            backBtn.topAnchor.constraint(equalTo: topAnchor, constant: 16),
            backBtn.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16),
            
            titleLabel.centerYAnchor.constraint(equalTo: backBtn.centerYAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: backBtn.trailingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16)
            
        ])
    }
    
    @objc private func backBtnTapped() {
        if let viewController = findViewController() {
            viewController.pop()
        }
    }
}



