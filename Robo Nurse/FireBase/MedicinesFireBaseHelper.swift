//
//  MedicinesFireBaseHelper.swift
//  Robo Nurse
//
//  Created by Momentum Solutions Co. on 25/06/2021.
//  Copyright © 2021 Mostafa Samir. All rights reserved.
//

import Foundation
import FirebaseDatabase
import FirebaseStorage


class FireBasePharmacyHelper {
    static let shared = FireBasePharmacyHelper()
    private let pharmacyRef = Database.database().reference().child("Pharmacy")
    private init() {}
    

    func getMeds(completion: @escaping (Result<[Medicine],Error>) -> Void) {
        pharmacyRef.observeSingleEvent(of: .value) { snapshot in
            if let json = snapshot.value as? [[String:String]] {
                print(json)
                do {
                    let data = try JSONSerialization.data(withJSONObject: json, options: .prettyPrinted)
                    let decoder = JSONDecoder()
                    let meds = try decoder.decode([Medicine].self, from: data)
                    completion(.success(meds))
                }catch {
                    completion(.failure(error))
                    print(error)
                    return
                }
            }else {
                completion(.success([]))
            }
        }
    }
}
