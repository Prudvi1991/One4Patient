//
//  SPSideMenuVC.swift
//  One for Patient
//
//  Created by Idontknow on 17/01/20.
//  Copyright © 2020 AnnantaSourceLLc. All rights reserved.
//

import UIKit

class SPSideMenuVC: UIViewController {
    
    @IBOutlet weak var dataTV: UITableView!
    
    @IBOutlet weak var IDLbl: UILabel!
    @IBOutlet weak var nameLbl: UILabel!
    
    
    @IBOutlet weak var statusLbl: UILabel!
    @IBOutlet weak var userImgView: UIImageView!
    @IBOutlet weak var profileView: UIView!
    var isAvailable:Bool = true
    var nameList = ["Full Profile","Change Password","Settings","Logout"]
    var imgList = ["probl","lock2","setBlue","logbl"]
    override func viewDidLoad() {
        super.viewDidLoad()

        viewChanges()
    }
    func viewChanges() {
        profileView.layer.cornerRadius = 10
        userImgView.makeRound()
        dataTV.rowHeight = 50
        nameLbl.text = GlobalVariables.userName
        IDLbl.text = GlobalVariables.userEmail
        tapFunction()
        statusLbl.makeRound()
    }
    func tapFunction() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(onTapImg(_:)))
        tapGesture.numberOfTouchesRequired =  1
        tapGesture.numberOfTapsRequired = 1
        userImgView.addGestureRecognizer(tapGesture)
        
    }
    @objc func onTapImg( _ sender:UITapGestureRecognizer) {
        print("User Selected Image")
        let story = UIStoryboard(name: "Main", bundle: nil)
        let Vc = story.instantiateViewController(withIdentifier: "ProfileVC") as! ProfileVC
        self.navigationController?.pushViewController(Vc, animated: true)
        
        
    }
    @IBAction func statusBtn(_ sender: UIButton) {
    
        if isAvailable == true {
            isAvailable = false
            sender.setTitle("Offline", for: .normal)
            statusLbl.backgroundColor = .red
        } else {
            isAvailable = true
            sender.setTitle("Online", for: .normal)
            statusLbl.backgroundColor = .systemGreen

        }
        
        
    }
    
    
    
    
}

extension SPSideMenuVC: UITableViewDelegate , UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return nameList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! SPSideMenuTC
        cell.titleLbl.text = nameList[indexPath.row]
        cell.imgView.image = UIImage(named: "\(imgList[indexPath.row])")
        cell.dataView.layer.cornerRadius = 10
        
        return  cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row {
            
        case 0:
        let story = UIStoryboard(name: "Main", bundle: nil)
        let VC = story.instantiateViewController(withIdentifier: "PagingVC") as! PagingVC
            self.navigationController?.pushViewController(VC, animated: true)
        GlobalVariables.isDoctor = true

        case 1:
        let story = UIStoryboard(name: "Main", bundle: nil)
        let VC = story.instantiateViewController(withIdentifier: "PassViewController") as! PassViewController
        self.navigationController?.pushViewController(VC, animated: true)
        GlobalVariables.isDoctor = true
         
        default:
            break
        }
    }
    
    
    
    
    
}
