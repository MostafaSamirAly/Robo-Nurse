//
//  AddPatientVC.swift
//  Robo Nurse
//
//  Created by Mac Store Egypt on 26/05/2021.
//  Copyright © 2021 Mostafa Samir. All rights reserved.
//

import UIKit

class AddPatientVC: UIViewController {
    @IBOutlet weak var patientsTableView: UITableView!
    var viewmodel = DoctorProfileViewmodel()
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        patientsTableView.delegate = self
        patientsTableView.dataSource = self
        patientsTableView.tableFooterView = UIView(frame: .zero)
        patientsTableView.layer.cornerRadius = 5
        patientsTableView.clipsToBounds = true
    }

    @IBAction func cancelBtnTapped(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    

}

extension AddPatientVC:UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let count = viewmodel.notAssignedPatients.count
        if count == 0 {
            tableView.setEmptyView(title: "", message: "No Patients")
        }else {
            tableView.restore()
        }
        return count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.selectionStyle = .none
        cell.textLabel?.text = viewmodel.notAssignedPatients[indexPath.row].name
            cell.textLabel?.textColor = .label
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        FireBasePatientsHelper.shared.addDoctorToPatient(with: viewmodel.notAssignedPatients[indexPath.row].uid)
        dismiss(animated: true, completion: nil)
    }
}
