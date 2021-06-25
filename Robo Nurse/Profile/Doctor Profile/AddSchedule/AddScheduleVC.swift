//
//  AddScheduleVC.swift
//  Robo Nurse
//
//  Created by Mac Store Egypt on 26/05/2021.
//  Copyright © 2021 Mostafa Samir. All rights reserved.
//

import UIKit

class AddScheduleVC: DataLoadingVC {

    @IBOutlet weak var dateTF: RoundedTextField!
    @IBOutlet weak var timeTF: RoundedTextField!
    @IBOutlet weak var actionTF: RoundedTextField!
    @IBOutlet weak var roomTF: RoundedTextField!
    
    let viewmodel = AddScheduleViewmodel()
    var textType:TextFieldType = .blood
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        dateTF.delegate = self
        timeTF.delegate = self
        roomTF.delegate = self
        
        showLoadingView()
        viewmodel.getRooms { [weak self] error in
            guard let self = self else { return }
            self.dismissLoadingView()
            if let error = error {
                Helper.showAlert(view: self, msg: error.localizedDescription)
            }
        }
    }
    
    @IBAction func doneBtnTapped(_ sender: Any) {
        if (viewmodel.rooms.count > 1 && roomTF.text == "") ||
            timeTF.text == "" ||
            actionTF.text == "" ||
            dateTF.text == "" {
            Helper.showAlert(view: self, msg: "Please Fill All Fields")
        }else {
            FireBasePatientsHelper.shared
                .addScheduleToPatient(with: viewmodel.patientUID ,
                                      room: roomTF.text ?? "",
                                      date: dateTF.text ?? "",
                                      time: timeTF.text ?? "",
                                      action: actionTF.text ?? "")
            pop()
        }
    }
}

extension AddScheduleVC: UITextFieldDelegate {
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        
        switch textField {
        case dateTF:
            let pickerVC = SelectDateVC()
            pickerVC.pickerDelegate = self
            pickerVC.modalPresentationStyle = .overCurrentContext
            present(pickerVC, animated: true, completion: nil)
        case timeTF:
            textType = .gender
            let pickerVC = PickerVC()
            pickerVC.pickerDelegate = self
            pickerVC.dataSource = ["Select Time","00:00","00:30","01:00","01:30","02:00","02:30","02:00","02:30","03:00","03:30","04:00","04:30","05:00","05:30","06:00","06:30","07:00","07:30","08:00","08:30","09:00","09:30","10:00","10:30","11:00","11:30","12:00","12:30","13:00","13:30","14:00","14:30","15:00","15:30","16:00","16:30","17:00","17:30","18:00","18:30","19:00","19:30","20:00","20:30",
                "21:00","21:30","22:00","22:30","23:00","23:30"]
            pickerVC.modalPresentationStyle = .overCurrentContext
            present(pickerVC, animated: true, completion: nil)
        case roomTF:
            textType = .blood
            let pickerVC = PickerVC()
            pickerVC.pickerDelegate = self
            pickerVC.dataSource = viewmodel.rooms
            pickerVC.modalPresentationStyle = .overCurrentContext
            present(pickerVC, animated: true, completion: nil)
        default:
            return true
        }
        return false
    }
    
}

extension AddScheduleVC: PickerDelegate {
    func didSelect(string: String) {
        if string != "" {
            switch textType {
            case .gender://time
                timeTF.text = string
            case .blood://rooms
                roomTF.text = string
                viewmodel.selectedRoom = string
            }
        }
    }
}

extension AddScheduleVC: DatePickerDelegate {
    func didSelect(date: String) {
        dateTF.text = date
    }
}
