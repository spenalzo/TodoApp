//
//  TodoTableViewController.swift
//  TodoProject
//
//  Created by Davide Gatti on 01.05.17.
//  Copyright © 2017 Davide Gatti. All rights reserved.
//

import UIKit

class TodoTableViewController: UITableViewController {

    var todos = [Todo]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Provo a caricare eventuali dati salvati
        loadTodos()
        
        // Se non ho dati salvati, allora carico gli esempi di partenza
        if todos.count == 0 {
            caricaEsempi ()
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
    
    //-----------------------------------------------------------------
    // Funzioni provvisorie per debug
    //-----------------------------------------------------------------
    
    private func caricaEsempi () {
        let todo1 = Todo(strLabelTitle: "Todo 1", strTextViewDescription: "Descrizione 1")
        let todo2 = Todo(strLabelTitle: "Todo 2", strTextViewDescription: "Descrizione 2")
        let todo3 = Todo(strLabelTitle: "Todo 3", strTextViewDescription: "Descrizione 3")
        
        todos += [todo1, todo2, todo3]
        print(todos[2])
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    //-------------------------------------------------------------------------------
    // Funzione di default della classe COCOA, modificare "return 0" in "return 1"
    // Si tratta del numero di sezioni della TableView (una sola, per ora)
    //-------------------------------------------------------------------------------
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    //-------------------------------------------------------------------------------
    // Funzione di default della classe COCOA, modificare "return 0", oppure non
    // si vedra' una mazza di niente (0 righe)
    //-------------------------------------------------------------------------------
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return todos.count
    }

    //-------------------------------------------------------------------------------
    // Funzione per aggiornare le celle della TableView in base al
    // contenuto dell'array todos
    // E' una funzione di default della classe COCOA, da scommentare e modificare
    //-------------------------------------------------------------------------------
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // Codice originale: let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Mi serve la cella che voglio visualizzare in posizione indexPath
        let cell = tableView.dequeueReusableCell(withIdentifier: "TodoTableViewCell", for: indexPath) as! TodoTableViewCell
        
        // Mi serve il todo della stessa posizione indicata da indexPath
        let todo = todos[indexPath.row]
        
        // Configure the cell... Assegno i valori che mi interessano
        cell.TodoLabelTitle.text = todo.strLabelTitle
        cell.TodoLabelDescription.text = todo.strTextViewDescription
        cell.TodoImageView.image = todo.imgTodoImageView

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
                
                // Aggiornamento dati di una cella che e' stata cliccata
                todos[selectedIndexPath.row] = todo
                
                // Aggiornamento visualizzazione della cella
                tableView.reloadRows(at: [selectedIndexPath], with: .none)
            
            // Aggiunta
            } else {
                
                print("Nuova cella / riga")
                
                let newIndexPath = IndexPath(row: todos.count, section: 0)
                
                // Aggiunta dei dati in fondo all'array "todos"
                todos.append(todo)
                
                // Aggiunta di una nuova cella
                tableView.insertRows(at: [newIndexPath], with: .automatic)
            }
            
            // Salvataggio dei dati todos (eventualmente spostabile in AppDelegate
            // alla chiusura dell'app)
            saveTodos()
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
            
            // Devo eliminare anche l'oggetto cancellato dal mio array oltre che dalla tabella
            todos.remove(at: indexPath.row)
            
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
            
            let indexPath = tableView.indexPath(for: selectedTodoCell)
            
            // estraggo l'oggetto dall'array dei todos
            let selectedTodo = todos[indexPath!.row]
            
            // identifico il controller di destinazione
            let todoController = segue.destination as? TodoViewController
            
            // passo l'oggetto alla variabile del controller
            todoController!.todo = selectedTodo
            
        default:
            print("Ho dimenticato di gestire un identificativo in 'TodoTableViewController' > 'prepare'")
        }
    }
    
    //-----------------------------------------------------------------
    // Funzioni per il salvataggio e il caricamento dei dati
    //-----------------------------------------------------------------
    
    // Save (richiamata da "AppDelegate")
    //
    private func saveTodos() {
        
        // salvo l'intero array, non c'e' bisogno di utilizzare cicli
        let isSuccessfulSave = NSKeyedArchiver.archiveRootObject(todos, toFile: Todo.ArchiveURL.path)
        
        if isSuccessfulSave {
            print("Todos successfully saved.")
        } else {
            print("Failed to save Todos!")
        }
    }
    
    // Load
    //
    private func loadTodos() {
        let todos = NSKeyedUnarchiver.unarchiveObject(withFile: Todo.ArchiveURL.path) as? [Todo]
        
        if let todos = todos {
            self.todos = todos
        }
    }
    
    // Passaggio dati all'esterno (AppDelegate) per il salvataggio
    //
    public func getTodos() -> [Todo]? {
        return todos
    }
}
