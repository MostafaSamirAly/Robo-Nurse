//
//  LoginVC.swift
//  Robo Nurse
//
//  Created by Mostafa Samir on 5/16/21.
//  Copyright © 2021 Mostafa Samir. All rights reserved.
//

import UIKit

class LoginVC: DataLoadingVC {
    
    @IBOutlet weak var emailTF: RoundedTextField!
    @IBOutlet weak var passTF: RoundedTextField!
    @IBOutlet weak var doctorsRadio: UIButton!
    @IBOutlet weak var patientRadeio: UIButton!
    let viewmodel = AuthViewmodel()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        navigationController?.navigationBar.isHidden = true
    }
    @IBAction func typeChanged(_ sender: UIButton) {
        if sender == patientRadeio {
            patientRadeio.setImage(#imageLiteral(resourceName: "checked-radio"), for: .normal)
            doctorsRadio.setImage(#imageLiteral(resourceName: "unchecked-radio"), for: .normal)
            viewmodel.userType = .patient
        }else {
            doctorsRadio.setImage(#imageLiteral(resourceName: "checked-radio"), for: .normal)
            patientRadeio.setImage(#imageLiteral(resourceName: "unchecked-radio"), for: .normal)
            viewmodel.userType = .doctor
        }
    }
    @IBAction func loginBtnTapped(_ sender: Any) {
        if emailTF.text == "" ||
            passTF.text == "" {
            Helper.showAlert(view: self, msg: "Please Fill All Fields")
        }else {
            showLoadingView()
            viewmodel.signIn(email: emailTF.text ?? "",
                             password: passTF.text ?? "") { [weak self] (login) in
                guard let self = self else { return }
                self.dismissLoadingView()
                if login {
                    let nc = UINavigationController(rootViewController: WelcomePageVC())
                    nc.navigationBar.isHidden = true
                    UIApplication.shared.keyWindow?.rootViewController = nc
                }else {
                    Helper.showAlert(view: self, msg: "Invalid Email or Password")
                }
            }
        }
    }
    @IBAction func signUpTapped(_ sender: Any) {
        push(SignUpVC())
    }
}
