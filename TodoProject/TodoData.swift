//
//  TodoData.swift
//  TodoProject
//
//  Created by Davide Gatti on 30.04.17.
//  Copyright © 2017 Davide Gatti. All rights reserved.
//

import Foundation
import UIKit

class Todo: NSObject, NSCoding {
    var strLabelTitle: String
    var strDayAndTimeCompleted: String
    var strTextViewDescription: String
    var imgTodoImageView: UIImage?
    var blnTodoSwitch: Bool
    
    let colTodoGreen: UIColor = UIColor.init(red: 0.04, green: 0.68, blue: 0.02, alpha: 1)
    let colTodoRed: UIColor = UIColor.init(red: 1, green: 0.02, blue: 0.02, alpha: 1)
    
    // Posizione per il salvataggio dei dati
    //
    static let DocumentsDirectory = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
    static let ArchiveURL = DocumentsDirectory.appendingPathComponent("todos")
    
    // Nuovo Todo di "default"
    //
    init (strLabelTitle: String, strTextViewDescription: String) {
        self.strLabelTitle = strLabelTitle
        
        let dateTime = DateTime()
        self.strDayAndTimeCompleted = dateTime.strDateTime      // Data e ora attuale
        
        self.strTextViewDescription = strTextViewDescription
        self.imgTodoImageView = UIImage(named: "ImageShip")!    // Immagine di default
        self.blnTodoSwitch = false                              // Attivita' da completare
    }
    
    // Todo con dati inseriti dall'utente
    //
    convenience init(strLabelTitle: String,
                     strDayAndTimeCompleted: String,
                     strTextViewDescription: String,
                     imgTodoSwitch: UIImage?,
                     blnTodoSwitch: Bool) {
        
        self.init(strLabelTitle: strLabelTitle, strTextViewDescription: strTextViewDescription)
        
        self.strDayAndTimeCompleted = strDayAndTimeCompleted
        self.imgTodoImageView = imgTodoSwitch
        self.blnTodoSwitch = blnTodoSwitch
    }

    // Todo salvato precedentemente
    //
    required convenience init?(coder aDecoder: NSCoder) {
        
        // preparo i dati da salvare
        let strTitle = aDecoder.decodeObject(forKey: PropertyKey.strLabelTitle) as! String
        let strDayTime = aDecoder.decodeObject(forKey: PropertyKey.strDayAndTimeCompleted) as! String
        let strDescription = aDecoder.decodeObject(forKey: PropertyKey.strTextViewDescription) as! String
        let imgImageView = aDecoder.decodeObject(forKey: PropertyKey.imgTodoImageView) as? UIImage
        let blnSwitch = aDecoder.decodeBool(forKey: PropertyKey.blnTodoSwitch)
        
        // salvo i dati nell'oggetto "todo"
        self.init(strLabelTitle: strTitle, strDayAndTimeCompleted: strDayTime,
                  strTextViewDescription: strDescription,
                  imgTodoSwitch: imgImageView, blnTodoSwitch: blnSwitch)
    }
    
    // Struttura per il salvataggio dei dati
    //
    struct PropertyKey {
        static let strLabelTitle = "strLabelTitle"
        static let strDayAndTimeCompleted = "strDayAndTimeCompleted"
        static let strTextViewDescription = "strTextViewDescription"
        static let imgTodoImageView = "imgTodoImageView"
        static let blnTodoSwitch = "blnTodoSwitch"
    }
    
    // Funzione che prepara i dati della classe da archiviare
    //
    func encode(with aCoder: NSCoder) {
        aCoder.encode(strLabelTitle, forKey: PropertyKey.strLabelTitle)
        aCoder.encode(strDayAndTimeCompleted, forKey: PropertyKey.strDayAndTimeCompleted)
        aCoder.encode(strTextViewDescription, forKey: PropertyKey.strTextViewDescription)
        aCoder.encode(imgTodoImageView, forKey: PropertyKey.imgTodoImageView)
        aCoder.encode(blnTodoSwitch, forKey: PropertyKey.blnTodoSwitch)
    }
}
