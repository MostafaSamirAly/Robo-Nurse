//
//  DoctorSignUpTableViewCell.swift
//  Robo Nurse
//
//  Created by Mostafa Samir on 5/16/21.
//  Copyright © 2021 Mostafa Samir. All rights reserved.
//

import UIKit

class DoctorSignUpTableViewCell: UITableViewCell {
    @IBOutlet weak var nameTF: RoundedTextField!
    @IBOutlet weak var emailTF: RoundedTextField!
    @IBOutlet weak var passTF: RoundedTextField!
    @IBOutlet weak var confirmPassTF: RoundedTextField!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func signupBtnTapped(_ sender: Any) {
        if nameTF.text != "" ||
            emailTF.text != "" ||
            passTF.text != "" ||
            confirmPassTF.text != "" {
            
            if passTF.text != confirmPassTF.text {
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
        vc.signUpDoctor(with: nameTF.text ?? "",
                        password: passTF.text ?? "",
                        email: emailTF.text ?? "")
    }
}
