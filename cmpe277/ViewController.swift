//
//  ViewController.swift
//  cmpe277
//
//  Created by John Hubacz on 11/28/16.
//  Copyright © 2016 John Hubacz. All rights reserved.
//

import UIKit
import Firebase
class ViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        navigationItem.leftBarButtonItem = UIBarButtonItem(title:"logout",style:.plain,target:self,action:#selector(handlelogout))
        checklogin()
    
    
    }
    
    func checklogin(){
        //let image = UIImage(named:"writing3")
        if FIRAuth.auth()?.currentUser?.uid==nil{
            perform(#selector(handlelogout), with: nil)
            handlelogout()
        }else{
      fixnavTitle()
        
        
        }
    }
    func fixnavTitle(){
         let uid = FIRAuth.auth()?.currentUser?.uid
        FIRDatabase.database().reference().child("users").child(uid!).observeSingleEvent(of: .value, with: { (snapshot) in
            if let dict = snapshot.value as? [String : AnyObject]{
                self.navigationItem.title=dict["name"] as? String
                 self.navigationItem.titleView?.addGestureRecognizer(UITapGestureRecognizer(target:self,action:#selector(self.showchatcontrol)))
                print("Inside check login")
                self.navigationItem.rightBarButtonItem = UIBarButtonItem(title:"Message",style:.plain,target:self,action:#selector(self.handlenewmessage) )
                
                
            }
        })
    
    
    }
    func showchatcontrol(){
        print(123)
        
    }

    func handlenewmessage(){
    let messagecontroller = messagetableviewcontrollerTableViewController()
        let navcontroller = UINavigationController(rootViewController: messagecontroller)
        present(navcontroller,animated:true,completion:nil)
    
    
    }
    func handlelogout(){
        do{
            try FIRAuth.auth()?.signOut()
        }catch let logoutError{
        print(logoutError)
        }
    
    let loginController = LoginController()
        
        present(loginController, animated: true, completion: nil)
    
    
    
    }


}

