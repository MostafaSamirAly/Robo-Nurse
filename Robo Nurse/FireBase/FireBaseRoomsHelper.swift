//
//  FireBaseCustomersHelper.swift
//  GYM360
//
//  Created by Mostafa Samir on 1/4/21.
//  Copyright © 2021 Mostafa Samir. All rights reserved.
//

import Foundation
import FirebaseDatabase

class FireBaseRoomsHelper {
    static let shared = FireBaseRoomsHelper()
    private let customersRef = Database.database().reference().child("rooms")
    private init() {}
    
    
    
//    func getUser(completion:@escaping (Result<Customer,Error>)->Void) {
//        guard let uid = UserDefaults.standard.string(forKey: UserDefaultsKeys.uid) else {
//            completion(.failure(FBError.uidError))
//            return
//        }
//        customersRef.child(uid).observeSingleEvent(of: .value){ (snapshot) in
//            if snapshot.exists() {
//                let userDict = snapshot.value as! [String:Any]
//                do {
//                    let data = try JSONSerialization.data(withJSONObject: userDict, options: .prettyPrinted)
//                    let decoder = JSONDecoder()
//                    let customer = try decoder.decode(Customer.self, from: data)
//                    completion(.success(customer))
//                }catch {
//                    completion(.failure(error))
//                    print(error)
//                    return
//                }
//            }else {
//
//                completion(.failure(FBError.childNotFound))
//            }
//        }
//    }
//
//
//
//    func setUserData(name:String,phone:String,captain:Captain) {
//        guard let uid = UserDefaults.standard.string(forKey: UserDefaultsKeys.uid)
//            else { return }
//        customersRef.child("\(uid)/name").setValue(name)
//        customersRef.child("\(uid)/phone").setValue(phone)
//        customersRef.child("\(uid)/captain").setValue(captain.uid)
//        FireBaseDoctorsHelper.shared.add(user: uid, captainUid: captain.uid)
//    }
    
    func updateUser(field:String,data:Double) {
        guard let uid = UserDefaults.standard.string(forKey: UserDefaultsKeys.uid)
            else { return }
        customersRef.child("\(uid)/\(field)").setValue(data)
    }
    
}
