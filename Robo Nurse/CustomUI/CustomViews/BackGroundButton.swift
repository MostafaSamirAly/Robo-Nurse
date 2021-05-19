//
//  BorderButton.swift
//  Etbo5ly
//
//  Created by Mostafa Samir on 12/7/20.
//  Copyright © 2020 Mostafa Samir. All rights reserved.
//

import UIKit
class BackGroundButton: UIButton {
    private let gradientLayer = CAGradientLayer()
    override func awakeFromNib() {
        super.awakeFromNib()
        setupview()
    }
    private func setupview(){
        self.clipsToBounds = true
        self.layer.cornerRadius = self.bounds.height / 2
        self.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        self.backgroundColor = .blue
        setTitleColor(.white, for: .normal)
        //setupGradientColor()
    }
    
}
