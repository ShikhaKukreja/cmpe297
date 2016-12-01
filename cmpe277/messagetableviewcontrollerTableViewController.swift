//
//  messagetableviewcontrollerTableViewController.swift
//  cmpe277
//
//  Created by John Hubacz on 11/30/16.
//  Copyright © 2016 John Hubacz. All rights reserved.
//

import UIKit
import Firebase
class messagetableviewcontrollerTableViewController: UITableViewController {
let cellid = "cellid"
    var allusers = [User]()
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.leftBarButtonItem = UIBarButtonItem(title:"Cancel",style:.plain,target:self,action:#selector(handlecancel))
        
        tableView.register(Usercell.self, forCellReuseIdentifier: cellid)
       
        fetchdata()
        
            }
    
       func fetchdata(){
        FIRDatabase.database().reference().child("users").observe(.childAdded, with: {(snapshot) in
               if let dict = snapshot.value as? [String:AnyObject]{
            let user1 = User()
                user1.setValuesForKeys(dict)
                self.allusers.append(user1)
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                    }
                //print(user1.email ?? "email",user1.name ?? "name")
            }
        }
        )
    
    
    }
    func handlecancel(){
    dismiss(animated:true, completion: nil)
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allusers.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //let cell = UITableViewCell(style:.subtitle,reuseIdentifier:cellid)
        let cell = tableView.dequeueReusableCell(withIdentifier: cellid,for: indexPath) as! Usercell
        let user = allusers[indexPath.row]
        cell.textLabel?.text=user.name
        cell.detailTextLabel?.text=user.email
      //  cell.imageView?.image=UIImage(named:"writing3")
       // cell.imageView?.contentMode = .scaleAspectFill
        if let profileurl = user.profileImage{
            let url = NSURL(string:profileurl)
            var request = URLRequest(url:url! as URL)
            URLSession.shared.dataTask(with: request, completionHandler: { (Data, response, Error) in
                if  Error != nil{
                    print(Error)
                    return
                }
                DispatchQueue.main.async(execute: {
                cell.iview.image=UIImage(data:Data!)
                    
          //          cell.imageView?.image=
                    
                })

            }).resume()
            
         
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 72
    }
}

class Usercell : UITableViewCell{
    
    
    let iview : UIImageView = {
    let Iview = UIImageView()
               Iview.translatesAutoresizingMaskIntoConstraints=false
        Iview.layer.cornerRadius=20
        Iview.layer.masksToBounds=true
        return Iview
    }()
    
    override func layoutSubviews() {
        super.layoutSubviews()
       
        textLabel?.frame=CGRect(56,textLabel!.frame.origin.y,textLabel!.frame.width,textLabel!.frame.height )
         detailTextLabel?.frame=CGRect(56,detailTextLabel!.frame.origin.y,detailTextLabel!.frame.width,detailTextLabel!.frame.height )
    }

    override init(style:UITableViewCellStyle,reuseIdentifier:String?)
    {
        super.init(style:.subtitle,reuseIdentifier:reuseIdentifier)
        addSubview(iview)
        iview.leftAnchor.constraint(equalTo:self.leftAnchor).isActive=true
        iview.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive=true
        iview.widthAnchor.constraint(equalToConstant: 48).isActive=true
        iview.heightAnchor.constraint(equalToConstant: 48).isActive=true
        iview.contentMode = .scaleAspectFill
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
extension CGRect{
    init(_ x:CGFloat,_ y:CGFloat,_ width:CGFloat,_ height:CGFloat) {
        self.init(x:x,y:y,width:width,height:height)
    }
    
}
extension CGSize{
    init(_ width:CGFloat,_ height:CGFloat) {
        self.init(width:width,height:height)
    }
}
extension CGPoint{
    init(_ x:CGFloat,_ y:CGFloat) {
        self.init(x:x,y:y)
    }
}
