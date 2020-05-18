//
//  ViewController.swift
//  ImagePicker
//
//  Created by Caroline Zaini on 13/05/2020.
//  Copyright © 2020 Caroline Zaini. All rights reserved.
//

import UIKit

/// Ajouter des permissions dans info.plist :
/// Privacy - Camera Usage Description -> use camera to take photo
/// Privacy - Photo Library Usage Description -> use photosfrom the gallery

class ViewController: UIViewController {

    @IBOutlet weak var imageHolder: UIImageView!
    @IBOutlet weak var switchLabel: UILabel!
    @IBOutlet weak var mySwitch: UISwitch!
    
    var imagePicker = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imagePicker.delegate = self
    }
    
    func takePicture(source: UIImagePickerController.SourceType) {
        imagePicker.sourceType = source
        imagePicker.allowsEditing = mySwitch.isOn
        present(imagePicker, animated: true, completion: nil)
    }

    @IBAction func switchChanged(_ sender: Any) {
        switchLabel.text = mySwitch.isOn ? "Editable" : "Orginale"
    }
    
    @IBAction func buttonPressed(_ sender: Any) {
       
        /// La camera n'est pas présente sur tous les appareils
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
             takePicture(source: .camera)
        } else {
            print("Caméra non disponible")
        }
    }
    
    @IBAction func libraryPressed(_ sender: Any) {
      
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
            takePicture(source: .photoLibrary)
               } else {
                   print("Aucune galerie de photo")
               }
    }
    
}

extension ViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    /// UINavigationControllerDelegate : pour naviguer dans notre smartPhone
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        /// récupérer des infos sur ce que l'on a pris
        
        if let pictureEdited = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
            /// Attribuer l'image à notre imageView
            imageHolder.image = pictureEdited
        } else if let original = info[.originalImage] as? UIImage {
            imageHolder.image = original
        }
        /// Je ferme le picker
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        /// si on annule je veux juste fermer ce picker
        picker.dismiss(animated: true, completion: nil)
    }
}

