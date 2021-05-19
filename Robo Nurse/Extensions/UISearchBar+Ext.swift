//
//  UISearchBar+Ext.swift
//  Etbo5ly
//
//  Created by Mostafa Samir on 12/9/20.
//  Copyright © 2020 Mostafa Samir. All rights reserved.
//

import UIKit

extension UISearchBar {

var cancelButton : UIButton? {
    if let cancelBtn = self.value(forKey: "cancelButton") as? UIButton {
        return cancelBtn
    }
    return nil
}
}
