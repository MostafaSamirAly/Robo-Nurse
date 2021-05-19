//
//  Patient.swift
//  Robo Nurse
//
//  Created by Mostafa Samir on 5/16/21.
//  Copyright © 2021 Mostafa Samir. All rights reserved.
//

import Foundation

/*
 age:
 23
 birth_day:
 "11-3-1998"
 blood_type:
 "A+"
 gender:
 "female"
 name:
 "Asmaa Samir"
 picture:
 "gs://graduation1-7004a.appspot.com/Asmaa Samir...."
 uid:
 "U1DpP2DqAbedvN3L6QNNxQetpHi2"

 */

struct Patient:Codable {
    let age:Int
    let bloodType:String
    let birthday:String
    let gender:String
    let name:String
    let picture:String
    let uid:String
    let email:String
    
    private enum CodingKeys: String,CodingKey {
        case age,name,picture,uid,gender,email
        case birthday = "birth_day"
        case bloodType = "blood_type"
    }
}
