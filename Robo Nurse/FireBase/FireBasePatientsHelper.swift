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
                completion(.success(true))
            }else {
                completion(.success(false))
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
    
    func saveImageInStorage(imageData: Data,name:String,completion: @escaping (_ imageURL: String?) -> Void)  {
        let  storageRef = Storage.storage().reference().child("patients")
        let metadata = StorageMetadata()
        metadata.contentType = "image/*"
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

