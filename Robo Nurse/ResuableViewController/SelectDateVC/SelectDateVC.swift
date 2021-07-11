//
//  SelectDateVC.swift
//  Etbo5ly
//
//  Created by Mostafa Samir on 12/8/20.
//  Copyright © 2020 Mostafa Samir. All rights reserved.
//

import UIKit

protocol DatePickerDelegate: AnyObject {
    func didSelect(date:String)
}

class SelectDateVC: UIViewController {
    @IBOutlet weak var datePicker: UIDatePicker!
    weak var pickerDelegate:DatePickerDelegate?
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupViews()
    }
    
    func setupViews() {
        let tapGesture = UITapGestureRecognizer(target:self, action: #selector(dismissSelf))
        view.addGestureRecognizer(tapGesture)
        
        datePicker.minimumDate = Date()
    }
    
    
    @IBAction func doneBtnTapped(_ sender: Any) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let dateStr = dateFormatter.string(from: datePicker.date)
        pickerDelegate?.didSelect(date: dateStr)
        dismissSelf()
    }
    
    @objc private func dismissSelf() {
        dismiss(animated: true, completion: nil)
    }
}
