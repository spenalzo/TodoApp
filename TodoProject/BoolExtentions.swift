//
//  BoolExtentions.swift
//  TodoProject
//
//  Created by Davide Gatti on 07.05.17.
//  Copyright © 2017 Davide Gatti. All rights reserved.
//

import Foundation

class BoolInt {
    
    // Da boolean a intero
    func intValue(blnValue: Bool) -> Int {
        if blnValue {
            return 1
        }
        return 0
    }
    
    // Da intero a boolean
    func blnValue(intValue: Int) -> Bool {
        if intValue == 1 {
            return true
        }
        return false
    }
}
