//
//  NewViewController.swift
//  scoops
//
//  Created by fran on 26/10/16.
//  Copyright © 2016 Francisco Navarro Aguilar. All rights reserved.
//

import UIKit

class NewViewController: UIViewController {

    let azureStack = AzureStack()
    
    @IBOutlet weak var photoView: UIImageView!
    @IBOutlet weak var titleLbl: UITextField!
    @IBOutlet weak var textView: UITextView!
    
    @IBAction func saveNew(_ sender: AnyObject) {
        
        let new = [
            "title":titleLbl.text,
            "text": textView.text,
            "author": "default",
            "visible": false,
            "image":photoView.image] as [AnyHashable : Any]
        
        azureStack.insertInto(table: "News", theObject: new) {  (results, error) in
            if let _ = error{
                print(error)
                self.presentInfoAlert(title: "Ups!", message: "There was a problem! Try it later",completion:nil)
            }else{
                self.presentInfoAlert(title: "Success!", message: "The item has been saved!"){ (action) in self.dismiss(animated: true, completion: nil)}
                
            }
        }
        
    }
    
    @IBAction func takePhoto(_ sender: AnyObject) {
        
        // Crear una instancia de UIImagePicker
        let picker = UIImagePickerController()
        
        // Configurarlo
        if UIImagePickerController.isCameraDeviceAvailable(.rear){
            picker.sourceType = .camera
        }else{
            // me conformo con el carrete
            picker.sourceType = .photoLibrary
        }
        
        
        picker.delegate = self
        
        // Mostrarlo de forma modal
        self.present(picker, animated: true) {
            // Por si quieres hacer algo nada más
            // mostrarse el picker
        }
        

        
        
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}


extension NewViewController:UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        let size = CGSize(width: 600, height: 600);
        
        let photo = info[UIImagePickerControllerOriginalImage] as! UIImage?
        
        photoView.image = photo?.resizeImage(targetSize: size)
        
        self.dismiss(animated: true) {
            //
        }
        
    }
    
    
    
}




