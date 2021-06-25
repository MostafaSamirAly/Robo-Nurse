//
//  MedicinesVC.swift
//  Robo Nurse
//
//  Created by Momentum Solutions Co. on 25/06/2021.
//  Copyright © 2021 Mostafa Samir. All rights reserved.
//

import UIKit

class MedicinesVC: DataLoadingVC {

    @IBOutlet weak var medecinesTableView: UITableView!
    
    let viewmodel = MedicinesViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupTableView()
        fetchMeds()
    }
    
    func setupTableView() {
        medecinesTableView.delegate = self
        medecinesTableView.dataSource = self
        
    }
    
    func fetchMeds() {
        showLoadingView()
        viewmodel.getMeds { [weak self] error in
            guard let self = self else { return }
            self.dismissLoadingView()
            if let error = error {
                Helper.showAlert(view: self, msg: error.localizedDescription)
            }else {
                self.medecinesTableView.reloadDataOnMainThread()
            }
        }
    }
    @IBAction func gestureRecognized(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}


extension MedicinesVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewmodel.addMedecineToPatient(at: indexPath.row)
        self.dismiss(animated: true, completion: nil)
    }
}

extension MedicinesVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewmodel.medecines.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        let medicine = viewmodel.medecines[indexPath.row]
        cell.textLabel?.text = medicine
        cell.imageView?.image = medicine == viewmodel.selectedMedecine?.name ? #imageLiteral(resourceName: "checked-radio") : #imageLiteral(resourceName: "unchecked-radio")
        return cell
    }
}
