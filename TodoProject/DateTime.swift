//
//  DateTime.swift
//  TodoProject
//
//  Created by Davide Gatti on 30.04.17.
//  Copyright © 2017 Davide Gatti. All rights reserved.
//

import Foundation

class DateTime {
    var strDateTime: String = ""
    
    func aggiornaDataOraAttuale() {
        // leggo l'ora attuale e la salvo in una stringa
        let dateFormatter = DateFormatter()
        
        dateFormatter.dateFormat = "dd-MM-yyyy HH:mm"
        
        strDateTime = dateFormatter.string(from: NSDate() as Date)
    }
    
    init() {
        self.aggiornaDataOraAttuale()
    }
}
