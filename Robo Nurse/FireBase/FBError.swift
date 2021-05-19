//
//  FBError.swift
//  GYM360
//
//  Created by Mostafa Samir on 1/3/21.
//  Copyright © 2021 Mostafa Samir. All rights reserved.
//

import Foundation

enum FBError: String , Error {
    case connectionError = "Unable to complete your request. Check your internet connection."
    case childNotFound = "the data you are requesting is not found."
    case decodeError = "Unable to decode the data received from the server. Please try again."
    case uidError = "cannot retrieve saved data."
}
