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
    private var rooms = [Room]()
    private init() {}
    
    func getRooms(completion: @escaping (Result<[Room],Error>) -> Void){
        roomsRef.observe(.value) { [weak self] (snapshot) in
            if snapshot.exists() {
                if let json = snapshot.value as? [[String:Any]] {
                    print(json)
                    do {
                        let data = try JSONSerialization.data(withJSONObject: json, options: .prettyPrinted)
                        let decoder = JSONDecoder()
                        let rtnRooms = try decoder.decode([Room].self, from: data)
                        self?.rooms = rtnRooms
                        completion(.success(rtnRooms))
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
    
    func add(patient:String,to room:String) {
        if let roomIndex = rooms.first(where: { $0.roomName == room })?.index {
            roomsRef.child(roomIndex.description).child("patient").setValue(patient)
        }
    }
    
}
