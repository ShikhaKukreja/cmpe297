//
//  File.swift
//  cmpe277
//
//  Created by John Hubacz on 11/30/16.
//  Copyright © 2016 John Hubacz. All rights reserved.
//

import Foundation
import UIKit
import Firebase
extension LoginController : UIImagePickerControllerDelegate,UINavigationControllerDelegate{

    func handleprofileselector(){
        
        let picker = UIImagePickerController()
        picker.delegate=self
        picker.sourceType = .photoLibrary
        picker.allowsEditing=true
        present(picker,animated:true,completion: nil)
        
    }
func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {

    
 var sImage : UIImage?
                if let edit = info["UIImagePickerControllerEditedImage"] as? UIImage{
       
           print(info)
           sImage=edit

        }
        else if let originalImage = info["UIImagePickerControllerOriginalImage"] as? UIImage{
        
            sImage=originalImage
        }
        
        if let selectedImage=sImage{
            print(selectedImage.size)
            
        profileimage.image = selectedImage
          
            dismiss(animated:true,completion:nil)
    }
    }

    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        print("cancel picker")
        dismiss(animated: true, completion: nil)
    }
    
    
    
    func handleRegister(){
        
        
        FIRAuth.auth()?.createUser(withEmail: emailTextfield.text!, password: addressTextfield.text!, completion: {(user:FIRUser?,Error) in
            if (Error != nil){
                print(Error ?? "error")
                return }
            let Iname = NSUUID().uuidString
            let storageref = FIRStorage.storage().reference().child("\(Iname).png")
            if let uData = UIImagePNGRepresentation(self.profileimage.image!){
                storageref.put(uData, metadata: nil,completion:{(metadata,Error) in
                    if Error != nil{
                    print(Error)
                        return
                    }
                    
                    if let purl = metadata?.downloadURL()?.absoluteString{
                        let value = ["name":self.nameTextfield.text ?? "name","email":self.emailTextfield.text ?? "email","profileImage":purl]
                        self.RegisterUserwithurl(uid: (user?.uid)!, value: value as [String : AnyObject])
                        
                       

                    }
                    
                
                })
            }
           
      
            
        })
        
    }
    
    private func RegisterUserwithurl(uid:String,value:[String:AnyObject]){
    
        let ref = FIRDatabase.database().reference(fromURL:"https://cmpe277-6e006.firebaseio.com/")
        let userspreference = ref.child("users").child(uid)
       //
        userspreference.updateChildValues(value, withCompletionBlock: {(Error,ref) in
            if Error != nil{
                print(Error ?? "erroe")
                return}
            print("Saved user successfully")
            self.dismiss(animated:true, completion: nil)
            
        })
    
    }

}
