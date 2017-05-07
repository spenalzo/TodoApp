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
    
    var todos = [Todo]()            // Todo da evadere
    var completedTodos = [Todo]()   // Todo completati
    
    //-----------------------------------------------------------------
    // Funzioni per il salvataggio e il caricamento dei dati
    //-----------------------------------------------------------------
    
    // Save (richiamata da "AppDelegate")
    //
    func saveTodos() {
        
        // salvo l'intero array, non c'e' bisogno di utilizzare cicli
        let isSuccessfulSave = NSKeyedArchiver.archiveRootObject(self.todos, toFile: Todo.ArchiveURLtodos.path)
        let isSuccessfulSaveCompleted = NSKeyedArchiver.archiveRootObject(self.completedTodos, toFile: Todo.ArchiveURLcompletedTodos.path)
        
        if isSuccessfulSave && isSuccessfulSaveCompleted {
            print("Todos successfully saved.")
        } else {
            print("Failed to save Todos!")
        }
    }
    
    // Load
    //
    func loadTodos() {
        let todos = NSKeyedUnarchiver.unarchiveObject(withFile: Todo.ArchiveURLtodos.path) as? [Todo]
        
        // In pratica se a todos riesco ad assegnare todos, allora non e' nullo e ho gia' fatto l'unwrapping
        //
        if let todos = todos {
            self.todos = todos
        }
        
        let completedTodos = NSKeyedUnarchiver.unarchiveObject(withFile: Todo.ArchiveURLcompletedTodos.path) as? [Todo]
        
        // In pratica se a todos riesco ad assegnare todos, allora non e' nullo e ho gia' fatto l'unwrapping
        //
        if let completedTodos = completedTodos {
            self.completedTodos = completedTodos
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
        if !todo.blnTodoSwitch {
            self.todos.append(todo)
        } else {
            self.completedTodos.append(todo)
        }
    }
    
    // Remove
    //
    func removeTodo(blnCompleted: Bool, intPosition: Int) {
        
        // Numero di elementi dell'array utilizzato
        let intCount = !blnCompleted ? todos.count : completedTodos.count

        // Verifico la posizione nell'array
        if intPosition >= 0, intPosition < intCount {
            if !blnCompleted {
                self.todos.remove(at: intPosition)
            } else {
                self.completedTodos.remove(at: intPosition)
            }
        } else {
            print("Errore passaggio parametri in removeTodo")
        }
    }
    
    // Update
    //
    func updateTodo(todo: Todo, indexPath: IndexPath) -> Bool {
    
        // Sezione di orgine del todo che ho iniziato a modificare
        let intSectionOrigin = indexPath.section
        let intPositionOrigin = indexPath.row
        
        var intPositionDestination = 0
        let boolInt = BoolInt()
        
        // Se il Todo e' rimasto nella sezione dov'era lo aggiorno
        if intSectionOrigin == boolInt.intValue(blnValue: todo.blnTodoSwitch) {
            intPositionDestination = indexPath.row
            
            if !todo.blnTodoSwitch {
                self.todos[intPositionDestination] = todo
            } else {
                self.completedTodos[intPositionDestination] = todo
            }
            return true
            
        // Altrimenti lo sposto nell'altro array
        } else {
            
            self.removeTodo(blnCompleted: boolInt.blnValue(intValue: intSectionOrigin), intPosition: intPositionOrigin)
            self.addTodo(todo: todo)
            
            return false
        }
    }
    
    //-----------------------------------------------------------------
    // Funzioni in base allo stato di completamento dei Todo
    //-----------------------------------------------------------------
    
    func getCount(todo: Todo) -> Int {
        
        if !todo.blnTodoSwitch {
            return TodosManager.sharedInstance.todos.count
        } else {
            return TodosManager.sharedInstance.completedTodos.count
        }
    }
    
    func getTodo(indexPath: IndexPath) -> Todo? {
        
        // Mi serve il todo della stessa posizione indicata da indexPath
        switch indexPath.section {
        case 0:
            return TodosManager.sharedInstance.todos[indexPath.row]
        case 1:
            return TodosManager.sharedInstance.completedTodos[indexPath.row]
        default: break
        }
        return nil
    }
    //-----------------------------------------------------------------
    // Funzione per caricamento dati iniziale
    //-----------------------------------------------------------------
    
    func loadExamples() {
        let todo1 = Todo(strLabelTitle: "Todo 1", strTextViewDescription: "Descrizione 1")
        let todo2 = Todo(strLabelTitle: "Todo 2", strTextViewDescription: "Descrizione 2")
        let todo3 = Todo(strLabelTitle: "Todo 3", strTextViewDescription: "Descrizione 3")
        
        self.todos += [todo1, todo2, todo3]
        
        let todo4 = Todo(strLabelTitle: "Todo 4", strTextViewDescription: "Descrizione 4")
        todo4.blnTodoSwitch = true
        
        self.completedTodos += [todo4]
    }
}
