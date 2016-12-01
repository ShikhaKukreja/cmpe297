//
//  LoginController.swift
//  cmpe277
//
//  Created by John Hubacz on 11/29/16.
//  Copyright © 2016 John Hubacz. All rights reserved.
//

import UIKit
import Firebase
class LoginController: UIViewController {
    let inputContainerView:UIView={
    let view = UIView()
    view.backgroundColor=UIColor.white
    view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius=5
        view.layer.masksToBounds=true
        return view
        }()
    
    
  lazy  var registerToggle: UISegmentedControl={
        let sc = UISegmentedControl(items:["Login","Register"])
        sc.tintColor=UIColor.white
        sc.translatesAutoresizingMaskIntoConstraints=false
        sc.selectedSegmentIndex=1
        sc.addTarget(self, action: #selector(handleToggle), for:.valueChanged)
        return sc
    
    }()
    
    
    
    func handleToggle(){
   let title=registerToggle.titleForSegment(at: (registerToggle.selectedSegmentIndex))
    loginbutton.setTitle(title, for: .normal)
        inputsviewheight?.constant = registerToggle.selectedSegmentIndex==0 ? 100 : 150
        nametextheight?.isActive=false
        nametextheight?=nameTextfield.heightAnchor.constraint(equalTo: inputContainerView.heightAnchor,multiplier:(registerToggle.selectedSegmentIndex==0 ? 0 : 1/3))
        nametextheight?.isActive=true
        emailtextheight?.isActive=false
        emailtextheight?=emailTextfield.heightAnchor.constraint(equalTo: inputContainerView.heightAnchor,multiplier:(registerToggle.selectedSegmentIndex==0 ? 1/2 : 1/3))
        emailtextheight?.isActive=true
        addresstextheight?.isActive=false
        addresstextheight?=addressTextfield.heightAnchor.constraint(equalTo: inputContainerView.heightAnchor,multiplier:(registerToggle.selectedSegmentIndex==0 ? 1/2 : 1/3))
        addresstextheight?.isActive=true
    }
  lazy var loginbutton: UIButton={
        let button = UIButton(type:.system)
        button.backgroundColor=UIColor(r:80,g:101,b:161)
        button.setTitle("Register", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints=false
        button.setTitleColor(UIColor.white, for:.normal)
        button.titleLabel?.font=UIFont.boldSystemFont(ofSize: 16)
        button.addTarget(self, action: #selector(handleloginregister), for: .touchUpInside)
        
        return button
    }()
    
    func handleloginregister(){
        if registerToggle.selectedSegmentIndex==0{
            handlelogin()}else{
        handleRegister()}
    
    
    }
    
    func handlelogin(){
    
        FIRAuth.auth()?.signIn(withEmail: emailTextfield.text!,password: addressTextfield.text!,completion: {(user,Error) in
        
            if Error != nil{
            print(Error ?? "error")
                return
            }
self.dismiss(animated: true, completion: nil)
        
        } )
    
    }
 

    let seperatorline : UIView={
    let view = UIView()
    view.backgroundColor=UIColor(r:220,g:220,b:220)
        view.translatesAutoresizingMaskIntoConstraints=false
    return view
    }()
    
    let nameTextfield : UITextField={
        let tf = UITextField()
        tf.placeholder="Name"
        tf.translatesAutoresizingMaskIntoConstraints=false
        return tf
    }()
    let emailseperatorline : UIView={
        let view = UIView()
        view.backgroundColor=UIColor(r:220,g:220,b:220)
        view.translatesAutoresizingMaskIntoConstraints=false
        return view
    }()
    
    let emailTextfield : UITextField={
        let tf = UITextField()
        tf.placeholder="Email"
        tf.translatesAutoresizingMaskIntoConstraints=false
        return tf
    }()
    let addressseperatorline : UIView={
        let view = UIView()
        view.backgroundColor=UIColor(r:220,g:220,b:220)
        view.translatesAutoresizingMaskIntoConstraints=false
        return view
    }()
    
    let addressTextfield : UITextField={
        let tf = UITextField()
        tf.placeholder="Password"
        tf.translatesAutoresizingMaskIntoConstraints=false
        tf.isSecureTextEntry=true
        return tf
    }()
    lazy var profileimage: UIImageView={
    let imageview = UIImageView()
        imageview.image=UIImage(named:"sjsu2")
        imageview.translatesAutoresizingMaskIntoConstraints=false
        imageview.contentMode = .scaleAspectFill
        imageview.addGestureRecognizer(UITapGestureRecognizer(target:self,action:#selector(handleprofileselector)))
        imageview.isUserInteractionEnabled=true
    return imageview
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(r:61,g:91,b:151)
        view.addSubview(loginbutton)
        view.addSubview(inputContainerView)
        view.addSubview(profileimage)
        view.addSubview(registerToggle)
        setupInputsContainerView()
        setUploginRegisterbutton()
        setUptoggle()
        setupprofileimage()
        // Do any additional setup after loading the view.
    }
    func setupprofileimage(){
        profileimage.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive=true
        profileimage.bottomAnchor.constraint(equalTo: registerToggle.topAnchor,constant:-17).isActive=true
        profileimage.widthAnchor.constraint(equalToConstant: 150).isActive=true
        profileimage.heightAnchor.constraint(equalToConstant: 150).isActive=true
    }
    
    var inputsviewheight: NSLayoutConstraint?
    var nametextheight : NSLayoutConstraint?
    var emailtextheight : NSLayoutConstraint?
    var addresstextheight : NSLayoutConstraint?
    func setupInputsContainerView(){
        inputContainerView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive=true
        inputContainerView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive=true
        inputContainerView.widthAnchor.constraint(equalTo: view.widthAnchor,constant:-24).isActive=true
        inputsviewheight = inputContainerView.heightAnchor.constraint(equalToConstant: 150)
        inputsviewheight?.isActive=true
        inputContainerView.addSubview(nameTextfield)
        inputContainerView.addSubview(seperatorline)
        inputContainerView.addSubview(emailTextfield)
        inputContainerView.addSubview(emailseperatorline)
        inputContainerView.addSubview(addressTextfield)
        inputContainerView.addSubview(addressseperatorline)
        nameTextfield.leftAnchor.constraint(equalTo: inputContainerView.leftAnchor,constant:12).isActive=true
        nameTextfield.topAnchor.constraint(equalTo: inputContainerView.topAnchor).isActive=true
        nameTextfield.widthAnchor.constraint(equalTo:inputContainerView.widthAnchor).isActive=true
        nametextheight=nameTextfield.heightAnchor.constraint(equalTo: inputContainerView.heightAnchor, multiplier:1/3)
        nametextheight?.isActive=true
        seperatorline.leftAnchor.constraint(equalTo: inputContainerView.leftAnchor,constant:12).isActive=true
        seperatorline.topAnchor.constraint(equalTo: nameTextfield.bottomAnchor).isActive=true
        seperatorline.widthAnchor.constraint(equalTo: inputContainerView.widthAnchor).isActive=true
        seperatorline.heightAnchor.constraint(equalToConstant: 1).isActive=true
        emailTextfield.leftAnchor.constraint(equalTo: inputContainerView.leftAnchor,constant:12).isActive=true
        emailTextfield.topAnchor.constraint(equalTo: nameTextfield.bottomAnchor).isActive=true
        emailtextheight=emailTextfield.heightAnchor.constraint(equalTo: inputContainerView.heightAnchor, multiplier:1/3)
        emailTextfield.widthAnchor.constraint(equalTo:inputContainerView.widthAnchor).isActive=true
        emailtextheight?.isActive=true
        emailseperatorline.leftAnchor.constraint(equalTo: inputContainerView.leftAnchor,constant:12).isActive=true
        emailseperatorline.topAnchor.constraint(equalTo: emailTextfield.bottomAnchor).isActive=true
        emailseperatorline.widthAnchor.constraint(equalTo: inputContainerView.widthAnchor).isActive=true
        emailseperatorline.heightAnchor.constraint(equalToConstant: 1).isActive=true
        addressTextfield.leftAnchor.constraint(equalTo: inputContainerView.leftAnchor,constant:12).isActive=true
        addressTextfield.topAnchor.constraint(equalTo: emailTextfield.bottomAnchor).isActive=true
        addressTextfield.widthAnchor.constraint(equalTo:inputContainerView.widthAnchor).isActive=true
        addresstextheight=addressTextfield.heightAnchor.constraint(equalTo: inputContainerView.heightAnchor, multiplier:1/3)
        addresstextheight?.isActive=true
    
    }
    func setUploginRegisterbutton(){
        loginbutton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive=true
        loginbutton.topAnchor.constraint(equalTo: inputContainerView.bottomAnchor,constant:12).isActive=true
        loginbutton.widthAnchor.constraint(equalTo: inputContainerView.widthAnchor).isActive=true
        loginbutton.heightAnchor.constraint(equalToConstant: 50).isActive=true
    }
    func setUptoggle(){
        registerToggle.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive=true
        registerToggle.bottomAnchor.constraint(equalTo: inputContainerView.topAnchor,constant:-17).isActive=true
        registerToggle.widthAnchor.constraint(equalTo: inputContainerView.widthAnchor).isActive=true
        registerToggle.heightAnchor.constraint(equalToConstant: 75)
        
        
    }
    
   /* override func preferredStatusBarStyle() -> UIStatusBarStyle  {
    return .lightContent}*/

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    

}
extension UIColor {

    convenience init(r: CGFloat,g:CGFloat,b:CGFloat){
        self.init(red:r/255,green:g/255,blue:b/255, alpha:1)
    
    }
}
