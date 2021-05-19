//
//  Helper.swift
//  RWrite
//
//  Created by Mostafa Samir on 11/9/20.
//  Copyright © 2020 Mostafa Samir. All rights reserved.
//

import UIKit

enum Helper{
    
    
    static func showAlert(view: UIViewController, msg: String){

        let alert = UIAlertController(title: "", message: msg, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .cancel)
        alert.addAction(action)
        view.present(alert, animated: true, completion: nil)
    }
    
   
    
    
    static func getDate(from timeStamp:Int)->String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "hh:mm a"
        let date = Date(timeIntervalSince1970: TimeInterval(integerLiteral: Int64(timeStamp)))
        let str = dateFormatter.string(from: date)
        return str
    }
    
    static func logout(view:UIViewController) {
        
    }
    
    
}
