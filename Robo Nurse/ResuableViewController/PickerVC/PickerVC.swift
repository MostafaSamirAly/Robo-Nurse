//
//  PickerVC.swift
//  Clozzit
//
//  Created by Momentum Solution Mac Mini on 2/11/21.
//  Copyright © 2021 Mostafa Samir. All rights reserved.
//

import UIKit

protocol PickerDelegate:class {
    func didSelect(string:String)
}

class PickerVC: UIViewController {
    @IBOutlet weak var pickerView: UIPickerView!
    @IBOutlet weak var subview: UIView!
    
    weak var pickerDelegate:PickerDelegate?
    var dataSource = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        subview.layer.borderWidth = 1
        subview.layer.borderColor = UIColor.black.cgColor
        pickerView.dataSource = self
        pickerView.delegate = self
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.doneBtnTapped(_:)))
        view.addGestureRecognizer(tapGesture)
    }
    
    @IBAction func doneBtnTapped(_ sender: Any) {
        dismiss(animated: true)
    }
}

extension PickerVC: UIPickerViewDataSource,UIPickerViewDelegate {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return dataSource.count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return dataSource[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if row != 0 {
            pickerDelegate?.didSelect(string: dataSource[row])
        }
        
    }
}
