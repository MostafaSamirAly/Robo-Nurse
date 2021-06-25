//
//  AddScheduleViewmodel.swift
//  Robo Nurse
//
//  Created by Mac Store Egypt on 26/05/2021.
//  Copyright © 2021 Mostafa Samir. All rights reserved.
//

import Foundation

class AddScheduleViewmodel: NSObject {
    var rooms = ["Select Room"]
    var selectedRoom:String?
    var patientUID = "1"
    func getRooms(completion: @escaping (Error?)->Void) {
        FireBaseRoomsHelper.shared.getRooms {[weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let rooms):
                self.rooms.append(contentsOf: rooms.filter{ $0.patient == nil }.map{ $0.roomName })
                completion(nil)
            case .failure(let error):
                completion(error)
            }
        }
    }
}
