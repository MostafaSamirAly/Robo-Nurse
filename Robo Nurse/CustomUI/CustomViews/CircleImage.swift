//
//  CircleImage.swift
//  Etbo5ly
//
//  Created by Mostafa Samir on 12/7/20.
//  Copyright © 2020 Mostafa Samir. All rights reserved.
//

import UIKit

class CircleImage: UIImageView {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupview()
    }
    func setupview(){
        self.contentMode = .scaleAspectFill
        self.layer.cornerRadius = self.frame.size.height / 2
        self.clipsToBounds = true
    }
}
