//
//  SignUpVC.swift
//  Robo Nurse
//
//  Created by Mostafa Samir on 5/16/21.
//  Copyright © 2021 Mostafa Samir. All rights reserved.
//

import UIKit

class SignUpVC: DataLoadingVC {

    @IBOutlet weak var segmentController: UISegmentedControl!
    @IBOutlet weak var signUpTableView: UITableView!
    let viewmodel = AuthViewmodel()
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setupTableView()
    }
    
    func signUpPatient(with patient:Patient,password:String) {
        //showLoadingView()
        viewmodel.signUpPatient(password: password, patient: patient) { [weak self](error) in
            guard let self = self else { return }
            self.dismissLoadingView()
            if let _ = error {
                Helper.showAlert(view: self, msg: "The email address is already in use by another account")
            }else {
                self.gotoWelcome()
            }
        }
    }
    
    func signUpDoctor(with name:String,password:String,email:String) {
        showLoadingView()
        viewmodel.signUpDoctor(with: email, password: password, name: name) { [weak self](error) in
            guard let self = self else { return }
            self.dismissLoadingView()
            if let _ = error {
                Helper.showAlert(view: self, msg: "Error Occured")
            }else {
                self.gotoWelcome()
            }
        }
    }
    
    func gotoWelcome() {
        let nc = UINavigationController(rootViewController: WelcomePageVC())
        nc.navigationBar.isHidden = true
        UIApplication.shared.keyWindow?.rootViewController = nc
    }
    
    func setupTableView() {
        signUpTableView.delegate = self
        signUpTableView.dataSource = self
        signUpTableView.register(UINib(nibName: String(describing: PatientSignupTableViewCell.self), bundle: nil), forCellReuseIdentifier: String(describing: PatientSignupTableViewCell.self))
        signUpTableView.register(UINib(nibName: String(describing: DoctorSignUpTableViewCell.self), bundle: nil), forCellReuseIdentifier: String(describing: DoctorSignUpTableViewCell.self))
        signUpTableView.tableFooterView = UIView(frame: .zero)
    }
    @IBAction func typeChanged(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0 {
            viewmodel.userType = .patient
        }else {
            viewmodel.userType = .doctor
        }
        signUpTableView.reloadData()
    }
    
}

extension SignUpVC: UITableViewDataSource,UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if segmentController.selectedSegmentIndex == 0 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: PatientSignupTableViewCell.self), for: indexPath) as? PatientSignupTableViewCell else { return UITableViewCell()}
            return cell
        }else {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: DoctorSignUpTableViewCell.self), for: indexPath) as? DoctorSignUpTableViewCell else { return UITableViewCell()}
            return cell
        }
    }
    
    
}


