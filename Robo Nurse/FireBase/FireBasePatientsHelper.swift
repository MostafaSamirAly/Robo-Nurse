//
//  FireBaseVideosHelper.swift
//  GYM360
//
//  Created by Mostafa Samir on 12/30/20.
//  Copyright © 2020 Mostafa Samir. All rights reserved.
//

import Foundation
import FirebaseDatabase
import FirebaseStorage


class FireBasePatientsHelper {
    static let shared = FireBasePatientsHelper()
    private let patientsRef = Database.database().reference().child("patients")
    private init() {}
    
    func checkUserExistance(completion:@escaping (Result<Bool,Error>)->Void) {
        guard let uid = UserDefaultsHelper.shared.getUID(),
        uid != "" else {
            completion(.failure(FBError.uidError))
            return
        }
        patientsRef.child(uid).observe(.value){ (snapshot) in
            if snapshot.exists() {
                let dict = snapshot.value as? [String:Any]
                if let userName = dict?["name"] as? String {
                    UserDefaultsHelper.shared.setUsername(userName)
                }
                completion(.success(true))
            }else {
                completion(.failure(FBError.childNotFound))
            }
        }
    }
    func getPatients(completion: @escaping (Result<[Patient],Error>) -> Void) {
        patientsRef.observe(.value) { (snapshot) in
            var patients = [Patient]()
            for child in snapshot.children {
                let child = child as! DataSnapshot
                let childDict = child.value as! [String:Any]
                do {
                    let data = try JSONSerialization.data(withJSONObject: childDict, options: .prettyPrinted)
                    let decoder = JSONDecoder()
                    let patient = try decoder.decode(Patient.self, from: data)
                    patients.append(patient)
                }catch {
                    completion(.failure(error))
                    print(error)
                    return
                }
            }
            completion(.success(patients))
        }
    }
    
    func getPatient(with uid:String,completion: @escaping (Result<Patient,Error>) -> Void) {
//        guard let uid = UserDefaultsHelper.shared.getUID(),
        if uid == "" {
            completion(.failure(FBError.uidError))
            return
        }
        patientsRef.child(uid).observe(.value) { (snapshot) in
            if snapshot.exists() {
                let childDict = snapshot.value as! [String:Any]
                do {
                    let data = try JSONSerialization.data(withJSONObject: childDict, options: .prettyPrinted)
                    let decoder = JSONDecoder()
                    let patient = try decoder.decode(Patient.self, from: data)
                    completion(.success(patient))
                }catch {
                    completion(.failure(error))
                    print(error)
                    return
                }
            }else {
                completion(.failure(FBError.childNotFound))
            }
            
        }
    }
    
    func addPatient(patient:Patient,uid:String) {
        patientsRef.child(uid).setValue([
            "age": patient.age,
            "birth_day":patient.birthday,
            "blood_type":patient.bloodType,
            "gender":patient.gender,
            "name":patient.name,
            "email":patient.email,
            "picture":patient.picture,
            "uid": uid
        ])
    }
    func addScheduleToPatient(with uid:String,room:String,date:String,time:String,action:String) {
        patientsRef.child(uid).child("schedule").setValue(
        [
            "date":date,
            "time":time,
            "room": room,
            "action":action
        ]
        )
        FireBaseRoomsHelper.shared.add(patient: uid, to: room)
    }
    func addDoctorToPatient(with uid:String) {
        patientsRef.child(uid).updateChildValues(["doctor":UserDefaultsHelper.shared.getUID() ?? "1"])
    }
    
    func removeDoctorFromPatient(with uid:String) {
        patientsRef.child(uid).child("doctor").removeValue()
    }
    
    func addMedecineToPatient(name:String,uid:String) {
        patientsRef.child(uid).child("medicine").setValue(name)
    }
    
    func saveImageInStorage(imageData: Data,name:String,completion: @escaping (_ imageURL: String?) -> Void)  {
        let  storageRef = Storage.storage().reference().child("patients").child(name)
        let metadata = StorageMetadata()
        metadata.contentType = "image/jpeg"
        storageRef.putData(imageData, metadata: metadata) { (metaData, error) in
            if error == nil{
                storageRef.downloadURL {(url, innerError) in
                    completion(url?.absoluteString)
                }
            }else {
                completion(nil)
            }
        }
    }
}

