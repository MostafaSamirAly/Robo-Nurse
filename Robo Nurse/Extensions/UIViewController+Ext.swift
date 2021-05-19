//
//  UIViewController+Ext.swift
//  Clozzit
//
//  Created by Momentum Solution Mac Mini on 2/11/21.
//  Copyright © 2021 Mostafa Samir. All rights reserved.
//

import UIKit


extension UIViewController {
    
//    weak var delegate:Navigator? {
//        return self
//    }
    
    func push(_ viewController:UIViewController) {
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    func pop() {
        navigationController?.popViewController(animated: true)
    }
    
    func presentPicker(on pickerDelegate:PickerDelegate,with dataSource:[String]) {
        let pickerVC = PickerVC()
        pickerVC.pickerDelegate = pickerDelegate
        pickerVC.dataSource = dataSource
        pickerVC.modalPresentationStyle = .overCurrentContext
        self.present(pickerVC, animated: true, completion: nil)
    }
    
    func presentPicker(on pickerDelegate:DatePickerDelegate) {
        let pickerVC = SelectDateVC()
        pickerVC.pickerDelegate = pickerDelegate
        pickerVC.modalPresentationStyle = .overCurrentContext
        self.present(pickerVC, animated: true, completion: nil)
    }
    
    
}

