//
//  HomeViewController.swift
//  One for Patient
//
//  Created by Idontknow on 10/11/19.
//  Copyright © 2019 AnnantaSourceLLc. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    
    
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var profileView: UIView!
    
    @IBOutlet weak var bellBtn: UIButton!
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var userIMGView: UIImageView!
    @IBOutlet weak var emailLbl: UILabel!
   
    override func viewDidLoad() {
        super.viewDidLoad()
        viewChanges()
       
    }
    
    func viewChanges() {
        topView.layer.cornerRadius = 10
    profileView.layer.cornerRadius = 10
    topView.elevate(elevation: 5.0)
        userIMGView.isUserInteractionEnabled = true
        tapFunction()
        userIMGView.makeRound()
        nameLbl.text = GlobalVariables.userName
        emailLbl.text = GlobalVariables.userEmail
    }
    
    @IBAction func typeSCAxn(_ sender: UISegmentedControl) {
        
        
        
    }
    //    MARK: Tap Function
    
    func tapFunction() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(onTapImg(_:)))
        tapGesture.numberOfTouchesRequired =  1
        tapGesture.numberOfTapsRequired = 1
        userIMGView.addGestureRecognizer(tapGesture)
           
    }
    @objc func onTapImg( _ sender:UITapGestureRecognizer) {
           print("User Selected Image")
        let Vc = self.storyboard?.instantiateViewController(withIdentifier: "ProfileVC") as! ProfileVC
        self.navigationController?.pushViewController(Vc, animated: true)
           
       }
    
    @IBAction func notifyBtnAct(_ sender: UIButton) {
    let VC = self.storyboard?.instantiateViewController(withIdentifier: "NotificationViewController") as!  NotificationViewController
    self.navigationController?.pushViewController(VC, animated: true)
        
    }
    
    
    
    
    
}


