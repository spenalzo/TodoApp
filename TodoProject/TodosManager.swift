//
//  TodosManager.swift
//  TodoProject
//
//  Created by Davide Gatti on 02.05.17.
//  Copyright © 2017 Davide Gatti. All rights reserved.
//

import Foundation

class TodosManager {
    static let sharedInstance = TodosManager()
    
    var todos = [Todo]()
    
    //-----------------------------------------------------------------
    // Funzioni per il salvataggio e il caricamento dei dati
    //-----------------------------------------------------------------
    
    // Save (richiamata da "AppDelegate")
    //
    public func saveTodos() {
        
        // salvo l'intero array, non c'e' bisogno di utilizzare cicli
        let isSuccessfulSave = NSKeyedArchiver.archiveRootObject(TodosManager.sharedInstance.todos, toFile: Todo.ArchiveURL.path)
        
        if isSuccessfulSave {
            print("Todos successfully saved.")
        } else {
            print("Failed to save Todos!")
        }
    }
    
    // Load
    //
    public func loadTodos() {
        let todos = NSKeyedUnarchiver.unarchiveObject(withFile: Todo.ArchiveURL.path) as? [Todo]
        
        if let todos = todos {
            self.todos = todos
        }
    }
}
