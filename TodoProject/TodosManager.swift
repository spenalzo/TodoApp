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
    func saveTodos() {
        
        // salvo l'intero array, non c'e' bisogno di utilizzare cicli
        let isSuccessfulSave = NSKeyedArchiver.archiveRootObject(self.todos, toFile: Todo.ArchiveURL.path)
        
        if isSuccessfulSave {
            print("Todos successfully saved.")
        } else {
            print("Failed to save Todos!")
        }
    }
    
    // Load
    //
    func loadTodos() {
        let todos = NSKeyedUnarchiver.unarchiveObject(withFile: Todo.ArchiveURL.path) as? [Todo]
        
        // In pratica se a todos riesco ad assegnare todos, allora non e' nullo e ho gia' fatto l'unwrapping
        //
        if let todos = todos {
            self.todos = todos
        }
        
        // Codice alternativo che fa la stessa cosa
        /*
        if todos != nil {
            self.todos = todos!
        }*/
    }
    
    //-----------------------------------------------------------------
    // Funzioni per aggiunta,eliminazione, modifica di elementi
    //-----------------------------------------------------------------
    
    // Add
    //
    func addTodo(todo: Todo) {
        self.todos.append(todo)
    }
    
    // Remove
    //
    func removeTodo(intPosition: Int) {
        
        // Verifico la posizione nell'array
        if intPosition >= 0, intPosition < todos.count {
            self.todos.remove(at: intPosition)
        } else {
            print("Errore passaggio parametri in removeTodo")
        }
    }
    
    // Update
    //
    func updateTodo(todo: Todo, intPosition: Int) {
        
        // Verifico la posizione nell'array
        if intPosition >= 0, intPosition < todos.count {
            self.todos[intPosition] = todo
        } else {
            print("Errore passaggio parametri in addTodo")
        }
    }
    
    //-----------------------------------------------------------------
    // Funzione per caricamento dati iniziale
    //-----------------------------------------------------------------
    
    func loadExamples() {
        let todo1 = Todo(strLabelTitle: "Todo 1", strTextViewDescription: "Descrizione 1")
        let todo2 = Todo(strLabelTitle: "Todo 2", strTextViewDescription: "Descrizione 2")
        let todo3 = Todo(strLabelTitle: "Todo 3", strTextViewDescription: "Descrizione 3")
        
        self.todos += [todo1, todo2, todo3]
    }
}
