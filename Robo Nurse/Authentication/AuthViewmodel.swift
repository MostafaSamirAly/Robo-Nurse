//
//  AuthViewmodel.swift
//  Robo Nurse
//
//  Created by Mostafa Samir on 5/16/21.
//  Copyright © 2021 Mostafa Samir. All rights reserved.
//

import Foundation
import FirebaseAuth

enum UserType:String {
    case doctor = "doctor"
    case patient = "patient"
}
class AuthViewmodel: NSObject {
    var userType:UserType = .patient
    var imageUrl:String = ""
    
    func signIn(email:String,password:String,completion:@escaping(Bool)->Void) {
        Auth.auth().signIn(withEmail: email, password: password) { [weak self] authResult, error in
          guard let self = self else { return }
            if error == nil {
                UserDefaultsHelper.shared.setUID(authResult?.user.uid ?? "")
                switch self.userType {
                case .doctor:
                    FireBaseDoctorsHelper.shared.checkUserExistance { (result) in
                        switch result {
                        case .success:
                            self.updateUserDefaults(with: authResult?.user.uid,name: "")
                            completion(true)
                        case .failure(_):
                            completion(false)
                        }
                    }
                case .patient:
                    FireBasePatientsHelper.shared.checkUserExistance { (result) in
                        switch result {
                        case .success:
                            self.updateUserDefaults(with: authResult?.user.uid,name: "")
                            completion(true)
                        case .failure(_):
                            completion(false)
                        }
                    }
                }
            }else {
                completion(false)
            }
            
        }
    }
    
    func signUpPatient(password:String,patient:Patient,completion:@escaping(Error?)->Void) {
        Auth.auth().createUser(withEmail: patient.email, password: password) { [weak self] authResult, error in
            if let error = error {
                completion(error)
            }else {
                self?.updateUserDefaults(with: authResult?.user.uid,name: patient.name)
                FireBasePatientsHelper.shared.addPatient(patient: patient, uid: authResult?.user.uid ?? "1")
                completion(nil)
            }
        }
    }
    
    func signUpDoctor(with email:String,password:String,name:String,completion:@escaping(Error?)->Void) {
        Auth.auth().createUser(withEmail: email, password: password) { [weak self] authResult, error in
            if error != nil {
                completion(error)
            }else {
                self?.updateUserDefaults(with: authResult?.user.uid, name: name)
                FireBaseDoctorsHelper.shared.add(user: authResult?.user.uid ?? "", name: name, email: email)
                completion(nil)
            }
        }
    }
    
    func updateUserDefaults(with uid:String?,name:String) {
        UserDefaultsHelper.shared.setUID(uid ?? "")
        UserDefaultsHelper.shared.setLoggedIn(true)
        UserDefaultsHelper.shared.setUserType(userType: userType)
        if !name.isEmpty {
            UserDefaultsHelper.shared.setUsername(name)
        }
    }
}
