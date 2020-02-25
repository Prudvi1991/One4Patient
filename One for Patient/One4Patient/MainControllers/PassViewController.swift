//
//  PassViewController.swift
//  One for Patient
//
//  Created by Idontknow on 18/12/19.
//  Copyright © 2019 AnnantaSourceLLc. All rights reserved.
//

import UIKit

class PassViewController: UIViewController {

    
    @IBOutlet weak var oldPassTF: UITextField!
    
    @IBOutlet weak var confirmTF: UITextField!
    
    
    @IBOutlet weak var saveBtn: UIButton!
    @IBOutlet weak var newPassTF: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        viewChanges()
        
    }
    func viewChanges() {
        saveBtn.layer.cornerRadius = 10.0
    }
    
    
    
    @IBAction func backAxn(_ sender: UIButton) {
        if GlobalVariables.isDoctor == true {
            let story = UIStoryboard(name: "Specialist", bundle: nil)
            
        let VC = story.instantiateViewController(withIdentifier: "MainViewController") as! MainViewController
        self.navigationController?.pushViewController(VC, animated: true)
        } else {
        let VC = self.storyboard?.instantiateViewController(withIdentifier: "MainViewController") as! MainViewController
        self.navigationController?.pushViewController(VC, animated: true)
        }
        
    }
    
    

    @IBAction func saveAxn(_ sender: UIButton) {
        if oldPassTF.text?.isEmpty == true || newPassTF.text?.isEmpty == true  || confirmTF.text?.isEmpty == true  {
            popUpAlert(title: "Alert", message: "Enter all Details", action: .alert)
        } else if reach.isConnectedToNetwork() == true {
            
            
            let details = ["OldPassword":oldPassTF.text as Any, "NewPassword":newPassTF.text as Any, "ConfirmPassword":confirmTF.text as Any] as [String:Any]
            
                print("details = \(details)")
            playLottie(fileName: "heartBeat")
        ApiService.callPostToken(url:ClientInterface.changePassUrl, params: details, methodType: "POST", tag: "ChangePassword", finish:finishPost)
            
        }
        
        
        
        
        
    }
    
    func finishPost (message:String, data:Data? , tag: String) -> Void {
        stopLottie()
    if tag == "ForgotPassword" {
    do {
    if let jsonData = data {
    let parsedData = try JSONDecoder().decode(CommonResponse.self, from: jsonData)
    print(parsedData)
       
    if parsedData.StatusCode == 200 {
    popUpAlert(title: "Success", message: "Password Changed ", action: .alert)
        oldPassTF.text = ""
        newPassTF.text = ""
        confirmTF.text = ""
       
    } else {
    popUpAlert(title: "Failed", message: "Try Again", action: .alert)
    }
    }
    } catch {
    popUpAlert(title: "Failed", message: "Try Again", action: .alert)
    print("Parse Error: \(error)")
    }
    
    }
    }
}
