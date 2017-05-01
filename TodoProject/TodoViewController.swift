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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        TodoTextViewDescription.text = ""
        TodoImageView.image = UIImage(named: "ImageShip")!
        TodoSwitch.isOn = false
        
        let dateTime = DateTime()
        TodoDayAndTime.text = dateTime.strDateTime
        
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
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

