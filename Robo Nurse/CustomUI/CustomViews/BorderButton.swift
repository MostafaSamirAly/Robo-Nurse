//
//  RoundedButton.swift
//  Clozzit
//
//  Created by Momentum Solution Mac Mini on 2/15/21.
//  Copyright © 2021 Mostafa Samir. All rights reserved.
//

import UIKit

@IBDesignable class BorderButton: UIButton {
    override func awakeFromNib() {
        super.awakeFromNib()
        setupview()
    }
    private func setupview(){
        self.layer.cornerRadius = 10
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor.blue.cgColor
        self.setTitleColor(.blue, for: .normal)
    }
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        setupview()
    }
}

