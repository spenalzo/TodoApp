//
//  ViewController.swift
//  TodoProject
//
//  Created by Davide Gatti on 27.04.17.
//  Copyright © 2017 Davide Gatti. All rights reserved.
//

import UIKit

class TodoViewController: UIViewController,
                          UITextFieldDelegate,
                          UITextViewDelegate,
                          UIImagePickerControllerDelegate,
                          UINavigationControllerDelegate {

    @IBOutlet weak var TodoLabelTitle: UILabel!
    @IBOutlet weak var TodoDayAndTime: UILabel!
    @IBOutlet weak var TodoTextField: UITextField!
    @IBOutlet weak var TodoTextViewDescription: UITextView!
    
    @IBOutlet weak var TodoImageView: UIImageView!
    @IBOutlet weak var TodoSwitch: UISwitch!
    @IBOutlet var TodoGestureRecognizer: UITapGestureRecognizer!
    
    @IBOutlet weak var TodoSave: UIBarButtonItem!
    
    @IBOutlet weak var TodoStackViewDetails: UIStackView!
    
    var todo: Todo?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // Se ho passato dei dati alla View, allora imposto quelli
        if let todo = todo {
            
            TodoTextField.text = todo.strLabelTitle
            TodoLabelTitle.text = todo.strLabelTitle
            TodoTextViewDescription.text = todo.strTextViewDescription
            TodoDayAndTime.text = todo.strDayAndTimeCompleted
            TodoImageView.image = todo.imgTodoImageView
            TodoSwitch.setOn(todo.blnTodoSwitch, animated: true)
            if todo.blnTodoSwitch {
                TodoLabelTitle.textColor = todo.colTodoGreen
            } else {
                TodoLabelTitle.textColor = todo.colTodoRed
            }
            
        // Altrimenti uso dei dati di default
        } else {
            TodoTextViewDescription.text = ""
            TodoImageView.image = UIImage(named: "ImageShip")!
            TodoSwitch.isOn = false
            TodoLabelTitle.textColor = UIColor.red
            
            let dateTime = DateTime()
            TodoDayAndTime.text = dateTime.strDateTime
        }
        
        // In base all'orientamento del dispositivo definisco quello della StackView centrale
        if UIDevice.current.orientation.isPortrait  {
            TodoStackViewDetails.axis = .vertical
            TodoStackViewDetails.distribution = .fill
        } else {
            TodoStackViewDetails.axis = .horizontal
            TodoStackViewDetails.distribution = .fillEqually
        }
        
        // Codice per permettere la gestione dell'evento TAP sulla mia immagine
        TodoImageView.addGestureRecognizer(TodoGestureRecognizer)
        TodoImageView.isUserInteractionEnabled = true;
        
        // Il Controller "TodoViewController" e' il delegato per la compilazione del titolo del "todo" e del testo esteso
        TodoTextField.delegate = self
        TodoTextViewDescription.delegate = self
    }
    
    //-----------------------------------------------------------------
    // Funzioni per la gestione del titolo
    //-----------------------------------------------------------------
    
    // Assegno alla label il testo che sto scrivendo mentre lo sto scrivendo
    //
    @IBAction func editingChangedTodoTextField(_ sender: Any) {
        TodoLabelTitle.text = TodoTextField.text
    }
    
    // Viene chiamata quando l'utente smette di editare all'interno di un TextField (i.e. quando preme Enter oppure Done)
    //
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        // nasconde la tastiera
        textField.resignFirstResponder()
        // sposta il cursore sul TextView per l'inserimento del testo esteso
        TodoTextViewDescription.becomeFirstResponder()
        return true
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        print("Titolo inserito")
    }
    
    //-----------------------------------------------------------------
    // Funzioni per la gestione del testo esteso
    //-----------------------------------------------------------------
    
    // Viene chiamata quando l'utente smette di editare all'interno di una TextView (i.e. quando preme Enter oppure Done)
    //
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if(text == "\n") {
            textView.resignFirstResponder()
            return false
        }
        return true
    }
    
    // Viene chiamata quando l'utente smette di editare all'interno di una TextView (i.e. quando perde il focus)
    //
    func textViewDidEndEditing(_ textView: UITextView) {
        print("Testo inserito")
    }
    
    //-----------------------------------------------------------------
    // Funzioni per la gestione dello switch
    //-----------------------------------------------------------------
    
    // Viene chiamata quando l'utente clicca sullo switch di completamento
    //
    @IBAction func todoSwitchValueChanged(_ sender: Any) {
    
        if TodoSwitch.isOn {
            let dateTime = DateTime()
            TodoDayAndTime.text = dateTime.strDateTime
            TodoLabelTitle.textColor = todo?.colTodoGreen
        } else {
            TodoLabelTitle.textColor = todo?.colTodoRed
        }
    }
    
    //-----------------------------------------------------------------
    // Funzioni per la gestione delle immagini
    //-----------------------------------------------------------------
    
    // Azione attivata con il TAP trascinato sull'immagine presente nella View
    //
    @IBAction func selectImageFromPhotoLibrary(_
        sender: UITapGestureRecognizer) {
        
        // Mi assicuro che se l'utente clicca la foto mentre è in editing, la tastiera viene nascosta
        TodoTextField.resignFirstResponder()
        TodoTextViewDescription.resignFirstResponder()
        
        // UIImagePickerController is a view controller that lets a user pick media from their photo library.
        let imagePickerController = UIImagePickerController()
        
        // Only allow photos to be picked, not taken.
        imagePickerController.sourceType = .photoLibrary
        
        // Modalita' popover per quando iPhone e' orizzontale
        imagePickerController.modalPresentationStyle = .popover
        
        // Make sure ViewController is notified when the user picks an image.
        imagePickerController.delegate = self
        present(imagePickerController, animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        // The info dictionary may contain multiple representations of the image. You want to use the original.
        guard let selectedImage = info[UIImagePickerControllerOriginalImage] as? UIImage else {
            fatalError("Expected a dictionary containing an image, but was provided the following: \(info)")
        }
        
        // mostro l'immagine
        TodoImageView.image = selectedImage
        
        // faccio il dismiss del picker
        dismiss(animated: true, completion: nil)
    }
    
    //-----------------------------------------------------------------
    // Funzioni per la visualizzazione decente di testo esteso e
    // immagine quando ruoto il dispositivo
    //-----------------------------------------------------------------
    
    override func willRotate(to toInterfaceOrientation: UIInterfaceOrientation, duration: TimeInterval) {
        
        if toInterfaceOrientation.isPortrait  {
            TodoStackViewDetails.axis = .vertical
            TodoStackViewDetails.distribution = .fill
        } else {
            TodoStackViewDetails.axis = .horizontal
            TodoStackViewDetails.distribution = .fillEqually
        }
        print("Rotating")
    }
    
    //-----------------------------------------------------------------
    // Funzioni per la navigazione
    //-----------------------------------------------------------------
    
    // Cancel
    //
    @IBAction func TodoCancel(_ sender: Any) {
        
        // verifico come sto richiamando il View Controller "Todo"
        let isInAddMode = presentingViewController is UINavigationController
        
        // sto aggiungendo un nuovo Todo
        if isInAddMode {
            
            dismiss(animated: true, completion: nil)
            
        // oppure arrivo dalla modifica di un Todo esistente
        } else if let owningNavigationController = navigationController {
            
            // Torno indietro nello stack di navigazione
            owningNavigationController.popViewController(animated: true)
        }
    }
    
    // Save
    //
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        super.prepare(for: segue, sender: sender)
        
        // eguiamo il codice seguente solo quando viene premuto il tasto salva, altrimenti usciamo
        guard let button = sender as? UIBarButtonItem, button === TodoSave else {
            return
        }
        
        // preparo i dati da salvare
        let strTitle = TodoLabelTitle.text!
        let strDescription = TodoTextViewDescription.text!
        let imgPhoto = TodoImageView.image
        let blnComplete = TodoSwitch.isOn
        let strDateTime = TodoDayAndTime.text!
        
        // salvo i dati nell'oggetto "todo"
        todo = Todo(strLabelTitle: strTitle, strDayAndTimeCompleted: strDateTime,
                    strTextViewDescription: strDescription,
                    imgTodoSwitch: imgPhoto, blnTodoSwitch: blnComplete)
    }
    
    //-----------------------------------------------------------------
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

