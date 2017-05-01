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
    
    // Nuovo Todo di "default"
    init (strLabelTitle: String, strTextViewDescription: String) {
        self.strLabelTitle = strLabelTitle
        
        let dateTime = DateTime()
        self.strDayAndTimeCompleted = dateTime.strDateTime      // Data e ora attuale
        
        self.strTextViewDescription = strTextViewDescription
        self.imgTodoImageView = UIImage(named: "ImageShip")!    // Immagine di default
        self.blnTodoSwitch = false                              // Attivita' da completare
    }
    
    // Todo con dati inseriti dall'utente
    convenience init(strLabelTitle: String,
                     strDayAndTimeCompleted: String,
                     strTextViewDescription: String,
                     imgTodoSwitch: UIImage,
                     blnTodoSwitch: Bool) {
        
        self.init(strLabelTitle: strLabelTitle, strTextViewDescription: strTextViewDescription)
        
        self.strDayAndTimeCompleted = strDayAndTimeCompleted
        self.imgTodoImageView = imgTodoSwitch
        self.blnTodoSwitch = blnTodoSwitch
    }
}
