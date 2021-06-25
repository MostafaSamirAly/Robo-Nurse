//
//  UserDefaultsHelper.swift
//  RWrite
//
//  Created by Mostafa Samir on 11/19/20.
//  Copyright © 2020 Mostafa Samir. All rights reserved.
//

import Foundation

class UserDefaultsHelper {
    static let shared = UserDefaultsHelper()
    private let ref = UserDefaults.standard
    private init() {}

    func setLoggedIn(_ bool:Bool) {
        ref.set(bool, forKey: UserDefaultsKeys.isLoggedIn)
    }

    func getLoggedIn()->Bool {
        return ref.bool(forKey: UserDefaultsKeys.isLoggedIn)
    }

    func setUID(_ token:String) {
        ref.set(token, forKey: UserDefaultsKeys.uid)
    }

    func getUID()->String? {
        return ref.string(forKey: UserDefaultsKeys.uid)
    }
    
    func setDeviceToken(_ token:String) {
        ref.set(token, forKey: UserDefaultsKeys.deviceToken)
    }

    func getDeviceToken()->String? {
        return ref.string(forKey: UserDefaultsKeys.deviceToken)
    }

    func setUsername(_ name:String) {
        ref.set(name, forKey: UserDefaultsKeys.username)
    }

    func getUsername()->String? {
        return ref.string(forKey: UserDefaultsKeys.username)
    }
    
//    func setCustomer(response:AuthResponse,type:String) {
//        if response.customer.isVerified == 1 {
//            setLoggedIn(true)
//            setTokenKey(response.token)
//            setUserId(response.customer.id)
//            setLoginMethod(type)
//        }
//
//    }
    func setLoginMethod(_ type:String) {
        ref.set(type, forKey: UserDefaultsKeys.signInMethod)
    }
    func getLoginMethod()->String? {
        return ref.string(forKey: UserDefaultsKeys.signInMethod)
    }
    
    func setLikes(_ count:Int) {
        ref.set(count, forKey: UserDefaultsKeys.likesArray)
    }
    
    func getLikes()-> Int {
        return ref.integer(forKey: UserDefaultsKeys.likesArray)
    }
    
    func setUserType(userType:UserType) {
        ref.setValue(userType.rawValue, forKey: UserDefaultsKeys.userType)
    }
    
    func getUserType()-> UserType {
        switch ref.string(forKey: UserDefaultsKeys.userType) {
        case UserType.patient.rawValue:
            return .patient
        case UserType.doctor.rawValue:
            return .doctor
        default:
            return .patient
        }
    }
    
    func removeAllData() {
        ref.removeObject(forKey: UserDefaultsKeys.isLoggedIn)
        ref.removeObject(forKey: UserDefaultsKeys.tokenKey)
        ref.removeObject(forKey: UserDefaultsKeys.username)
        ref.removeObject(forKey: UserDefaultsKeys.signInMethod)
        ref.removeObject(forKey: UserDefaultsKeys.likesArray)
        ref.removeObject(forKey: UserDefaultsKeys.userType)
    }
}

