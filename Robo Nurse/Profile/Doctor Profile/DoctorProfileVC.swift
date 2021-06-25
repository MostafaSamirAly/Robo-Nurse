//
//  DoctorProfileVC.swift
//  Robo Nurse
//
//  Created by Mac Store Egypt on 19/05/2021.
//  Copyright © 2021 Mostafa Samir. All rights reserved.
//

import UIKit

class DoctorProfileVC: DataLoadingVC {
    @IBOutlet weak var doctorName: UILabel!
    @IBOutlet weak var patientsTableView: UITableView!
    
    let viewmodel = DoctorProfileViewmodel()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        patientsTableView.delegate = self
        patientsTableView.dataSource = self
        patientsTableView.tableFooterView = UIView(frame: .zero)
        doctorName.text = "Dr/\(UserDefaultsHelper.shared.getUsername() ?? "")"
        showLoadingView()
        viewmodel.getPatients { [weak self] error in
            guard let self = self else { return }
            self.dismissLoadingView()
            if let error = error {
                Helper.showAlert(view: self, msg: error.localizedDescription)
            }else {
                DispatchQueue.main.async {
                    self.patientsTableView.reloadData()
                }
            }
        }
    }
    func showSchedule(for indexPath:IndexPath) {
        let vc = AddScheduleVC()
        vc.viewmodel.patientUID = viewmodel.patients[indexPath.row].uid
        push(vc)
    }
    
    @IBAction func scheduleBtnTapped(_ sender: Any) {
    }
    
}

extension DoctorProfileVC:UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return viewmodel.patients.count + 1
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.selectionStyle = .none
        if indexPath.row != viewmodel.patients.count,
           viewmodel.patients.count != 0 {
            cell.textLabel?.text = viewmodel.patients[indexPath.row].name
            cell.textLabel?.textColor = .label
        }else {
            cell.textLabel?.text = "Add Patient"
            cell.textLabel?.textAlignment = .center
            cell.textLabel?.textColor = .red
        }
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row != viewmodel.patients.count {
            let vc = PatientProfileVC()
            vc.viewmodel.uid = viewmodel.patients[indexPath.row].uid
            push(vc)
        }else {
            // add patient
            let vc = AddPatientVC()
            vc.modalPresentationStyle = .overCurrentContext
            vc.viewmodel = self.viewmodel
            present(vc, animated: true, completion: nil)
        }
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        
        
        let editAction = UITableViewRowAction(style: .normal, title: "Schedule") { [weak self] (rowAction, indexPath) in
            //TODO: scedule the row at indexPath here
            guard let self = self else { return }
            self.showSchedule(for: indexPath)
        }
        editAction.backgroundColor = .blue

        let deleteAction = UITableViewRowAction(style: .normal, title: "Delete") {[weak self] (rowAction, indexPath) in
            //TODO: Delete the row at indexPath here
            guard let self = self else { return }
            FireBasePatientsHelper.shared.removeDoctorFromPatient(with: self.viewmodel.patients[indexPath.row].uid)
        }
        deleteAction.backgroundColor = .red
        
        let addMedAction = UITableViewRowAction(style: .normal, title: "Medicines") {[weak self] (rowAction, indexPath) in
            //TODO: Delete the row at indexPath here
            guard let self = self else { return }
            let vc = MedicinesVC()
            vc.viewmodel.patient = self.viewmodel.patients[indexPath.row]
            vc.modalTransitionStyle = .crossDissolve
            vc.modalPresentationStyle = .overCurrentContext
            self.present(vc, animated: true, completion: nil)
        }
        addMedAction.backgroundColor = .orange

        return [editAction,deleteAction,addMedAction]
    }
    
//    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
//        if editingStyle == .delete {
//
//        }else  if editingStyle == .{ }
//    }
    
}
