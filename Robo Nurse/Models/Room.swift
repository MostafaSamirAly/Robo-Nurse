//
//  Room.swift
//  Robo Nurse
//
//  Created by Mostafa Samir on 5/16/21.
//  Copyright © 2021 Mostafa Samir. All rights reserved.
//

import Foundation

struct Room: Codable {
    let roomName:String
    let patient:String?
    let index:Int?
}
