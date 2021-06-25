//
//  PatientProfileViewmodel.swift
//  Robo Nurse
//
//  Created by Mac Store Egypt on 19/05/2021.
//  Copyright © 2021 Mostafa Samir. All rights reserved.
//

import Foundation

class PatientProfileViewModel: NSObject {
    var patient:Patient?
    var uid = UserDefaultsHelper.shared.getUID() ?? ""
    var firebase = FireBasePatientsHelper.shared
    private(set) var readings = [Readings]()
    
    func getPatientData(completion:@escaping (Error?)->Void) {
        firebase.getPatient(with: uid) { [weak self] result in
            switch result {
            case .success(let patient):
                self?.patient = patient
                self?.setupReadings()
                completion(nil)
            case .failure(let errro):
                completion(errro)
            }
        }
    }
    
    func setupReadings() {
        if let vitals = patient?.vitalSign {
            for (_,value) in vitals {
                for (_,reading) in value {
                    readings.append(reading)
                }
            }
            readings.sort { $0.date > $1.date && $0.time > $1.time }
        }
    }
}
