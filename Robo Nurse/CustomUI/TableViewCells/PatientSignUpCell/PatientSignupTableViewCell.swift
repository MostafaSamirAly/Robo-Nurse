//
//  PatientSignupTableViewCell.swift
//  Robo Nurse
//
//  Created by Mostafa Samir on 5/16/21.
//  Copyright © 2021 Mostafa Samir. All rights reserved.
//

import UIKit

enum TextFieldType {
    case gender
    case blood
}
class PatientSignupTableViewCell: UITableViewCell {
    @IBOutlet weak var nameTF: RoundedTextField!
    @IBOutlet weak var ageTF: RoundedTextField!
    @IBOutlet weak var bloodTypeTF: RoundedTextField!
    @IBOutlet weak var confirmPassTF: RoundedTextField!
    @IBOutlet weak var genderTF: RoundedTextField!
    @IBOutlet weak var passwordTF: RoundedTextField!
    @IBOutlet weak var birthdayTF: RoundedTextField!
    @IBOutlet weak var emailTF: RoundedTextField!
    @IBOutlet weak var profileImageView: UIImageView!
    let imagePicker = UIImagePickerController()
    var textType:TextFieldType = .gender
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        profileImageView.isUserInteractionEnabled = true
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(imageTapped))
        profileImageView.addGestureRecognizer(tapGesture)
        
        birthdayTF.delegate = self
        genderTF.delegate = self
        bloodTypeTF.delegate = self
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @objc func imageTapped() {
        imagePicker.modalPresentationStyle = .currentContext
        imagePicker.delegate = self
        if let vc = findViewController() as? SignUpVC {
            vc.present(imagePicker, animated: true)
        }
        
    }
    @IBAction func signupBtnTapped(_ sender: Any) {
        if nameTF.text != "" ||
        ageTF.text != "" ||
        bloodTypeTF.text != "" ||
        genderTF.text != "" ||
        emailTF.text != "" ||
        passwordTF.text != "" ||
        confirmPassTF.text != "" ||
         birthdayTF.text != "" {
            
            if passwordTF.text != confirmPassTF.text {
                if let vc = findViewController() as? SignUpVC {
                    Helper.showAlert(view: vc, msg: "Passwords Don't Match")
                }
            }else {
                signUpUser()
            }
            
        }else {
            if let vc = findViewController() as? SignUpVC {
                Helper.showAlert(view: vc, msg: "Please Fill All Fields")
            }
        }
    }
    
    func signUpUser() {
        guard let vc = findViewController() as? SignUpVC else { return }
        vc.showLoadingView()
        FireBasePatientsHelper.shared.saveImageInStorage(imageData: profileImageView.image?.jpegData(compressionQuality: 0.8) ?? Data(),name:emailTF.text ?? "") { [weak self] (str) in
            guard let self = self else { return }
            if let url = str {
                let patient = Patient(age: Int(self.ageTF.text ?? "0") ?? 0,
                                      bloodType: self.bloodTypeTF.text ?? "",
                                      birthday: self.birthdayTF.text ?? "",
                                      gender: self.genderTF.text ?? "",
                                      name: self.nameTF.text ?? "",
                                      picture: url,
                                      uid: "",
                                      email: self.emailTF.text ?? "",
                                      doctor: nil,
                                      medicine: nil,
                                      vitalSign: nil )
                vc.signUpPatient(with: patient, password: self.passwordTF.text ?? "")
            }else {
                vc.dismissLoadingView()
                Helper.showAlert(view: vc, msg: "Error Uploading Image")
            }
        }
        
    }
    
//    func uploadImage(with data:Data,completion:@escaping()->Void) {
//        FireBasePatientsHelper.shared.saveImageInStorage(imageData: data) {[weak self] (url) in
//            guard let self = self else { return }
//            if let url = url {
//                self.imageUrl = url
//                completion()
//            }
//        }
//    }
}

extension PatientSignupTableViewCell: UITextFieldDelegate {
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        
        switch textField {
        case birthdayTF:
            let pickerVC = SelectDateVC()
            pickerVC.pickerDelegate = self
            pickerVC.modalPresentationStyle = .overCurrentContext
            if let vc = findViewController() as? SignUpVC {
                vc.present(pickerVC, animated: true, completion: nil)
            }
        case genderTF:
            textType = .gender
            let pickerVC = PickerVC()
            pickerVC.pickerDelegate = self
            pickerVC.dataSource = ["Select Gender","Male","Female"]
            pickerVC.modalPresentationStyle = .overCurrentContext
            if let vc = findViewController() as? SignUpVC {
                vc.present(pickerVC, animated: true, completion: nil)
            }
        case bloodTypeTF:
            textType = .blood
            let pickerVC = PickerVC()
            pickerVC.pickerDelegate = self
            pickerVC.dataSource = ["Select Blood Type","A+","A-","AB+","AB-","B+","B-","O+","O-"]
            pickerVC.modalPresentationStyle = .overCurrentContext
            if let vc = findViewController() as? SignUpVC {
                vc.present(pickerVC, animated: true, completion: nil)
            }
        default:
            return true
        }
        return false
    }
    
}

extension PatientSignupTableViewCell: UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        let tempImage:UIImage = info[UIImagePickerController.InfoKey.originalImage] as! UIImage
        profileImageView.image = tempImage
        imagePicker.dismiss(animated:true)
    }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        imagePicker.dismiss(animated: true)
    }
}


extension PatientSignupTableViewCell: PickerDelegate {
    func didSelect(string: String) {
        switch textType {
        case .gender:
            genderTF.text = string
            genderTF.resignFirstResponder()
        case .blood:
            bloodTypeTF.text = string
            bloodTypeTF.resignFirstResponder()
        }
    }
    
    
}

extension PatientSignupTableViewCell: DatePickerDelegate {
    func didSelect(date: String) {
        birthdayTF.text = date
        birthdayTF.resignFirstResponder()
    }
}
