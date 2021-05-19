//
//  UIView+Ext.swift
//  Clozzit
//
//  Created by Momentum Solution Mac Mini on 2/11/21.
//  Copyright © 2021 Mostafa Samir. All rights reserved.
//

import UIKit

extension UIView {
    func findViewController() -> UIViewController? {
        if let nextResponder = self.next as? UIViewController {
            return nextResponder
        } else if let nextResponder = self.next as? UIView {
            return nextResponder.findViewController()
        } else {
            return nil
        }
    }
    
    
}
