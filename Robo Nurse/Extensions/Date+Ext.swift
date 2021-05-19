//
//  Date+Ext.swift
//  Etbo5ly
//
//  Created by Mostafa Samir on 12/21/20.
//  Copyright © 2020 Mostafa Samir. All rights reserved.
//

import Foundation

extension Date {
    func toMillis() -> Int64! {
        return Int64(self.timeIntervalSince1970 * 1000)
    }
}
