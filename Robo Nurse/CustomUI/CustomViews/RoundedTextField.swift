//
//  RoundedTextField.swift
//  Clozzit
//
//  Created by Momentum Solution Mac Mini on 2/11/21.
//  Copyright © 2021 Mostafa Samir. All rights reserved.
//

import UIKit

class RoundedTextField: UITextField {
    @IBInspectable var rightImage:UIImage? {
        didSet {
            let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 30, height: 20))
            imageView.image = rightImage
            imageView.contentMode = .scaleAspectFit
            imageView.clipsToBounds = true
            //self.rightView?.frame = imageView.frame
            //self.rightView?.safeAreaInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 16)
            self.rightView = imageView
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        setup()
    }
    func setup() {
        self.layer.cornerRadius = self.frame.height / 2
        self.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 16, height: self.frame.height))
        self.leftViewMode = .always
        self.rightViewMode = .always
        self.borderStyle = .none
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor(hexString: "#6D6E71").cgColor
    }
    
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        setup()
        
    }
    
    override func rightViewRect(forBounds bounds: CGRect) -> CGRect {
        var rect = super.rightViewRect(forBounds: bounds)
        rect.origin.x -= 16
        return rect
    }
}
