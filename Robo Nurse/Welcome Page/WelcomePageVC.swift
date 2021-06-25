//
//  WelcomePageVC.swift
//  Robo Nurse
//
//  Created by Mac Store Egypt on 19/05/2021.
//  Copyright © 2021 Mostafa Samir. All rights reserved.
//

import UIKit
import FirebaseAuth

class WelcomePageVC: UIViewController {

    @IBOutlet weak var nameLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        nameLabel.text = UserDefaultsHelper.shared.getUsername()
    }

    
    @IBAction func logout(_ sender: Any) {
        do {
            try Auth.auth().signOut()
            UserDefaultsHelper.shared.removeAllData()
            let nc = UINavigationController(rootViewController: LoginVC())
            nc.navigationBar.isHidden = true
            UIApplication.shared.keyWindow?.rootViewController = nc
        }catch {
            Helper.showAlert(view: self, msg: "cannot logout")
        }
    }
    @IBAction func profileBtnTapped(_ sender: Any) {
        switch UserDefaultsHelper.shared.getUserType() {
        case .doctor:
            push(DoctorProfileVC())
        case .patient:
            push(PatientProfileVC())
        }
    }
    @IBAction func idBtnTapped(_ sender: Any) {
        Helper.showAlert(view: self, msg: UserDefaultsHelper.shared.getUID() ?? "")
    }
    
}
