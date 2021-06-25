//
//  DoctorProfileViewmodel.swift
//  Robo Nurse
//
//  Created by Mac Store Egypt on 25/05/2021.
//  Copyright © 2021 Mostafa Samir. All rights reserved.
//

import Foundation

class DoctorProfileViewmodel: NSObject {
    var patients = [Patient]()
    var notAssignedPatients = [Patient]()
    
    
    func getPatients(completion: @escaping (Error?)->Void) {
        FireBasePatientsHelper.shared.getPatients { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let patients):
                self.patients = patients.filter { $0.doctor == UserDefaultsHelper.shared.getUID() }
                self.notAssignedPatients = patients.filter {$0.doctor == nil }
                completion(nil)
            case .failure(let error):
                completion(error)
            }
        }
    }
}
