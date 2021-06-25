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
    private let roomsRef = Database.database().reference().child("rooms")
    private init() {}
    
    func getRooms(completion: @escaping (Result<[Room],Error>) -> Void){
        roomsRef.observe(.value) { (snapshot) in
            if snapshot.exists() {
                if let json = snapshot.value as? [[String:String]] {
                    print(json)
                    do {
                        let data = try JSONSerialization.data(withJSONObject: json, options: .prettyPrinted)
                        let decoder = JSONDecoder()
                        let rooms = try decoder.decode([Room].self, from: data)
                        completion(.success(rooms))
                    }catch {
                        completion(.failure(error))
                        print(error)
                        return
                    }
                }else {
                    completion(.success([]))
                }
            }else {
                completion(.success([]))
            }
        }
    }
    
}
