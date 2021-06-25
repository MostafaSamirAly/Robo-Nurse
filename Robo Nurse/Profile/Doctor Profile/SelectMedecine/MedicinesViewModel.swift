//
//  MedicinesViewModel.swift
//  Robo Nurse
//
//  Created by Momentum Solutions Co. on 25/06/2021.
//  Copyright © 2021 Mostafa Samir. All rights reserved.
//

import Foundation

class MedicinesViewModel: NSObject {
    var medecines = [String]()
    var selectedMedecine:Medicine?
    var patient:Patient!
    
    func getMeds(completion: @escaping (Error?)->Void) {
        FireBasePharmacyHelper.shared.getMeds { [weak self] result in
            switch result {
            case .success(let meds):
                self?.medecines = meds.map { $0.name }
                self?.selectedMedecine = meds.first { $0.name == self?.patient.medicine }
                completion(nil)
            case .failure(let error):
                completion(error)
            }
        }
    }
    
    func addMedecineToPatient(at index:Int) {
        let medecineName = medecines[index]
        let uidPatient = patient.uid
        FireBasePatientsHelper.shared.addMedecineToPatient(name: medecineName, uid: uidPatient)
    }
}
