//
//  MenuViewController.swift
//  One for Patient
//
//  Created by Idontknow on 10/11/19.
//  Copyright © 2019 AnnantaSourceLLc. All rights reserved.
//

import UIKit

@available(iOS 13.0, *)
class MenuViewController: UIViewController,UITableViewDelegate, UITableViewDataSource {
   
    @IBOutlet weak var profileView: UIView!
    @IBOutlet weak var profileImgView: UIImageView!
    @IBOutlet weak var dataView: UITableView!
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var emailLbl: UILabel!
    @IBOutlet weak var statusLbl: UILabel!

    
    var imgArr  = ["probl","Mem2","health","lock2","setb","logbl"]
    var listArr = ["Profile","Add Member","Health Summary","Change Password","Settings", "Logout"]
    var isAvailable : Bool = true
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewChanges()
    }
    func viewChanges() {
        profileView.elevate(elevation: 3.0)
        profileView.layer.cornerRadius = 10
        statusLbl.makeRound()
        dataView.rowHeight = 50
        nameLbl.text = GlobalVariables.userName
        emailLbl.text = GlobalVariables.userEmail
    }
    
    @IBAction func statusAxn(_ sender: UIButton) {
        if isAvailable == true  {
            isAvailable = false
            sender.setTitle("Offline", for: .normal)
            statusLbl.backgroundColor = .red
        } else {
            isAvailable = true
            sender.setTitle("Online", for: .normal)
            statusLbl.backgroundColor = .green
        }
        
        
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listArr.count
       }
       
       func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! SideMenuCell
        cell.nameLbl.text = listArr[indexPath.row]
        cell.sideImgView.image = UIImage(named: "\(imgArr[indexPath.row])")
        cell.dataView.layer.cornerRadius = 10
        cell.dataView.backgroundColor = .white
        return cell
       }
       
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {
        
        let VC = self.storyboard?.instantiateViewController(withIdentifier: "PagingVC") as! PagingVC
        self.navigationController?.pushViewController(VC, animated: true)
        } else if indexPath.row == 1 {
        let VC = self.storyboard?.instantiateViewController(withIdentifier: "AddMemeberVC") as! AddMemeberVC
        self.navigationController?.pushViewController(VC, animated: true)
        } else if indexPath.row == 3{
           let VC = self.storyboard?.instantiateViewController(withIdentifier: "PassViewController") as! PassViewController
           self.navigationController?.pushViewController(VC, animated: true)
            
        } else if indexPath.row == 2 {
            let story = UIStoryboard(name: "Health", bundle: nil)
            let VC = story.instantiateViewController(withIdentifier: "HealthVC") as! HealthVC
            self.navigationController?.pushViewController(VC, animated: true)
        }
    }
    

}
