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
        caricaEsempi ()
        
        // Non metto il bottone nell'editor grafico ma lo creo qui,
        // di default e poi faccio l'override del suo comportamento
        //navigationItem.leftBarButtonItem = editButtonItem
        
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
    //-------------------------------------------------------------------------------
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    //-------------------------------------------------------------------------------
    // Funzione di default della classe COCOA, modificare "return 0", oppure non
    // si vedra' una mazza di niente (0 righe) ?????
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

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
