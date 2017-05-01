//
//  TodoData.swift
//  TodoProject
//
//  Created by Davide Gatti on 30.04.17.
//  Copyright © 2017 Davide Gatti. All rights reserved.
//

import Foundation
import UIKit

class Todo {
    var strLabelTitle: String
    var strDayAndTimeCompleted: String
    var strTextViewDescription: String
    var imgTodoImageView: UIImage
    var blnTodoSwitch: Bool
    
    init (strLabelTitle: String, strTextViewDescription: String) {
        self.strLabelTitle = strLabelTitle
        self.strTextViewDescription = strTextViewDescription
        self.blnTodoSwitch = false                              // Attivita' da completare
        self.imgTodoImageView = UIImage(named: "ImageShip")!    // Immagine di default
        
        let dateTime = DateTime()
        self.strDayAndTimeCompleted = dateTime.strDateTime      // Data e ora attuale
    }
}
