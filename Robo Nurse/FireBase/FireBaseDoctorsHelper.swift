//
//  FireBaseUsersHelper.swift
//  GYM360
//
//  Created by Mostafa Samir on 12/30/20.
//  Copyright © 2020 Mostafa Samir. All rights reserved.
//

import Foundation
import FirebaseDatabase
class FireBaseDoctorsHelper {
    static let shared = FireBaseDoctorsHelper()
    private let usersRef = Database.database().reference().child("Doctors")
    private init() {}
    
    func checkUserExistance(completion:@escaping (Result<Bool,Error>)->Void) {
        guard let uid = UserDefaultsHelper.shared.getUID(),
        uid != "" else {
            completion(.failure(FBError.uidError))
            return
        }
        usersRef.child(uid).observe(.value){ (snapshot) in
            if snapshot.exists() {
                completion(.success(true))
            }else {
                completion(.success(false))
            }
        }
    }
    
//    func setUserData(name:String,phone:String,captain:Captain) {
//        guard let uid = UserDefaults.standard.string(forKey: UserDefaultsKeys.uid)
//            else { return }
//        /*
//         age:
//         23
//         birth_day:
//         "11-3-1998"
//         blood_type:
//         "A+"
//         gender:
//         "female"
//         name:
//         "Asmaa Samir"
//         picture:
//         "gs://graduation1-7004a.appspot.com/Asmaa Samir...."
//         uid:
//         "U1DpP2DqAbedvN3L6QNNxQetpHi2\""
//
//         */
//        usersRef.child("\(uid)/name").setValue(name)
//        usersRef.child("\(uid)/phone").setValue(phone)
//        usersRef.child("\(uid)/captain").setValue(captain.uid)
//        FireBaseDoctorsHelper.shared.add(user: uid, captainUid: captain.uid)
//    }
    func getCaptains(completion: @escaping (Result<[Doctor],Error>) -> Void) {
        usersRef.observeSingleEvent(of: .value) { (snapshot) in
            var doctors = [Doctor]()
            for child in snapshot.children {
                let child = child as! DataSnapshot
                let childDict = child.value as! [String:Any]
                do {
                    let data = try JSONSerialization.data(withJSONObject: childDict, options: .prettyPrinted)
                    let decoder = JSONDecoder()
                    let doctor = try decoder.decode(Doctor.self, from: data)
                    doctors.append(doctor)
                }catch {
                    completion(.failure(error))
                    print(error)
                    return
                }
            }
            completion(.success(doctors))
        }
    }
    
    func add(user uid:String,name:String,email:String) {
        usersRef.child(uid).setValue([
            "name":name,
            "email":email,
            "uid": uid
        ])
    }
    
    func updateCaptainViews(key:String,value:Int,uid:String) {
        usersRef.child(uid).child("views").child(key).setValue(value)
    }
}
