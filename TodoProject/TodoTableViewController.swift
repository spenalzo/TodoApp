//
//  TodoTableViewController.swift
//  TodoProject
//
//  Created by Davide Gatti on 01.05.17.
//  Copyright © 2017 Davide Gatti. All rights reserved.
//

import UIKit

// Estensioni

class TodoTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Provo a caricare eventuali dati salvati
        TodosManager.sharedInstance.loadTodos()
        
        // Se non ho dati salvati, allora carico gli esempi di partenza
        if TodosManager.sharedInstance.todos.count == 0 {
            TodosManager.sharedInstance.loadExamples ()
        }
        
        // Non metto il bottone nell'editor grafico ma lo creo qui,
        // di default e poi faccio l'override del suo comportamento in:
        // "Funzione per la cancellazione di una riga" (vedi sotto)
        navigationItem.leftBarButtonItem = editButtonItem
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    //-------------------------------------------------------------------------------
    // Funzione di default della classe COCOA, modificare "return 0" in "return n"
    // Si tratta del numero di sezioni della TableView (una sola, per ora)
    //-------------------------------------------------------------------------------
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 2
    }

    //-------------------------------------------------------------------------------
    // Funzione di default della classe COCOA, modificare "return 0", oppure non
    // si vedra' una mazza di niente (0 righe)
    //-------------------------------------------------------------------------------
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        
        var rowCount = 0
        if section == 0 {
            // Todo ancora da completare
            rowCount = TodosManager.sharedInstance.todos.count
        }
        if section == 1 {
            // Todo completati
            rowCount = TodosManager.sharedInstance.completedTodos.count
        }
        return rowCount
    }

    //-------------------------------------------------------------------------------
    // Funzione per impostare i nomi delle 2 section
    //-------------------------------------------------------------------------------
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return "To do"
        } else {
            return "Completed"
        }
    }
    
    //-------------------------------------------------------------------------------
    // Funzione per aggiornare le celle della TableView in base al
    // contenuto dell'array todos o completedTodos
    // E' una funzione di default della classe COCOA, da scommentare e modificare
    //-------------------------------------------------------------------------------
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // Codice originale: let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Mi serve la cella che voglio visualizzare in posizione indexPath
        let cell = tableView.dequeueReusableCell(withIdentifier: "TodoTableViewCell", for: indexPath) as! TodoTableViewCell
        
        // Mi serve il todo della stessa posizione indicata da indexPath
        let todo = TodosManager.sharedInstance.getTodo(indexPath: indexPath)!
        
        // Configure the cell... Assegno i valori che mi interessano
        cell.TodoLabelTitle.text = todo.strLabelTitle
        cell.TodoLabelDescription.text = todo.strTextViewDescription
        cell.TodoImageView.image = todo.imgTodoImageView
        
        if todo.blnTodoSwitch {
            cell.TodoLabelTitle.textColor = todo.colTodoGreen
        } else {
            cell.TodoLabelTitle.textColor = todo.colTodoRed
        }
    
        return cell
    }
    
    //-------------------------------------------------------------------------------
    // Funzione recuperare i dati dalla view Todo quando viene cliccato "Save"
    // sia in caso si arrivi da una View "modale" (nuovo), sia dalla modifica
    // di un elemento esistente.
    // Dopo aver creato questa funzione, occorre linkare il tasto "Save" a "Exit"
    // nella scena "Single Todo".
    //-------------------------------------------------------------------------------
    
    @IBAction func unwindToTodoList(sender: UIStoryboardSegue) {
        
        if let sourceViewController = sender.source as? TodoViewController,let todo = sourceViewController.todo {
            
            // Aggiornamento
            if let selectedIndexPath = tableView.indexPathForSelectedRow {
                
                print("Aggiornamento cella / riga")
                
                // Aggiorno i miei array di Todo
                if TodosManager.sharedInstance.updateTodo(todo: todo, indexPath: selectedIndexPath) {
                    
                    // Aggiornamento dati di una cella che e' stata cliccata e non ha cambiato stato
                    tableView.reloadRows(at: [selectedIndexPath], with: .none)
                } else {
                    
                    // Aggiornamento visualizzazione complessiva delle celle
                    tableView.reloadData()
                }

            // Aggiunta
            } else {
                
                print("Nuova cella / riga")
                
                // Vedo se il Todo lo sto aggiungendo già completato o meno
                let intSection = todo.blnTodoSwitch ? 1 : 0
                
                let newIndexPath = IndexPath(row: TodosManager.sharedInstance.getCount(todo: todo), section: intSection)
                
                // Aggiunta dei dati in fondo all'array "todos"
                TodosManager.sharedInstance.addTodo(todo: todo)
                
                // Aggiunta di una nuova cella
                tableView.insertRows(at: [newIndexPath], with: .automatic)
            }
        }
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    //-----------------------------------------------------------------
    // Funzione per la cancellazione di una riga
    // E' una funzione di default della classe COCOA, da scommentare e modificare
    //-----------------------------------------------------------------
    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete {
            
            let boolInt = BoolInt()
            
            // Devo eliminare anche l'oggetto cancellato dal mio array oltre che dalla tabella
            TodosManager.sharedInstance.removeTodo(blnCompleted: boolInt.blnValue(intValue: indexPath.section), intPosition: indexPath.row)
            
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
            
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    //-----------------------------------------------------------------
    // Funzioni per la navigazione
    // E' una funzione di default della classe COCOA, da scommentare e modificare
    //-----------------------------------------------------------------
    
    // Passaggio dei dati alla View del "todo" singolo
    //
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        super.prepare(for: segue,sender: sender)
        
        switch (segue.identifier ?? "") {
            
        case "AddItem":
            print("Aggiunta di un nuovo Todo")  // Non occorre passare dei dati
        
        case "ShowDetail":
            print("Aggiornamento di un Todo gia' esistente")    // Devo passare i dati del Todo cliccato
            
            let selectedTodoCell = sender as! TodoTableViewCell
            
            let indexPath = tableView.indexPath(for: selectedTodoCell)!
            
            // Mi serve il todo della stessa posizione indicata da indexPath
            let selectedTodo = TodosManager.sharedInstance.getTodo(indexPath: indexPath)!
            
            // identifico il controller di destinazione
            let todoController = segue.destination as? TodoViewController
            
            // passo l'oggetto alla variabile del controller
            todoController!.todo = selectedTodo
            
        default:
            print("Ho dimenticato di gestire un identificativo in 'TodoTableViewController' > 'prepare'")
        }
    }
}
