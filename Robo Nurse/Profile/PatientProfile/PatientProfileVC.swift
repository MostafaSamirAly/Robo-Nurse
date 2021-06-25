//
//  PatientProfileVC.swift
//  Robo Nurse
//
//  Created by Mac Store Egypt on 19/05/2021.
//  Copyright © 2021 Mostafa Samir. All rights reserved.
//

import UIKit

class PatientProfileVC: DataLoadingVC {
    
    @IBOutlet weak var userImageView: CircleImage!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var bloodTypeLabel: UILabel!
    @IBOutlet weak var ageLabel: UILabel!
    @IBOutlet weak var genderLabel: UILabel!
    @IBOutlet weak var readsTableView: UITableView!
    
    
    
    
    let viewmodel = PatientProfileViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        setupTableView()
        showLoadingView()
        viewmodel.getPatientData { [weak self] error in
            guard let self = self else { return }
            self.dismissLoadingView()
            if let error = error {
                Helper.showAlert(view: self, msg: error.localizedDescription)
            }else {
                DispatchQueue.main.async {
                    self.setupData()
                    self.readsTableView.reloadData()
                }
            }
        }
    }
    
    func setupTableView() {
        readsTableView.delegate = self
        readsTableView.dataSource = self
        readsTableView.register(UINib(nibName: String(describing: VitalSignsTableViewCell.self), bundle: nil), forCellReuseIdentifier: String(describing: VitalSignsTableViewCell.self))
        readsTableView.tableFooterView = UIView(frame: .zero)
    }
    
    func setupData() {
        guard let patient = viewmodel.patient else { return }
        usernameLabel.text = patient.name
        userImageView.setImage(with: patient.picture)
        bloodTypeLabel.text = patient.bloodType
        ageLabel.text = patient.age.description
        genderLabel.text = patient.gender
    }
}

extension PatientProfileVC: UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let count = viewmodel.readings.count
        if count == 0 {
            tableView.setEmptyView(title: "", message: "You have no readings")
        }else {
            tableView.restore()
        }
        return count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: VitalSignsTableViewCell.self), for: indexPath) as? VitalSignsTableViewCell
        else { return UITableViewCell() }
        cell.setup(with: viewmodel.readings[indexPath.row])
        return cell
        
    }
    
    
}
