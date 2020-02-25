//
//  AddMemeberVC.swift
//  One for Patient
//
//  Created by Idontknow on 24/01/20.
//  Copyright © 2020 AnnantaSourceLLc. All rights reserved.
//

import UIKit

class AddMemeberVC: UIViewController {

    @IBOutlet weak var firstNameTF: UITextField!
    
    @IBOutlet weak var genderSC: UISegmentedControl!
    
    @IBOutlet weak var DOBTF: UITextField!
    @IBOutlet weak var LNameTF: UITextField!
    
    @IBOutlet weak var emailTF: UITextField!
    
    @IBOutlet weak var UNameTF: UITextField!
    
    @IBOutlet weak var addBtn: UIButton!
    
    @IBOutlet weak var conformTF: UITextField!
    @IBOutlet weak var passwordTF: UITextField!
    @IBOutlet weak var mobileTF: UITextField!
    var genderType = "0"
    override func viewDidLoad() {
        super.viewDidLoad()

       viewChanges()
    }
    
    func viewChanges(){
        addBtn.layer.cornerRadius = 10
    }
    
    
    
    
    
    
    @IBAction func genderSCAxn(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 1 {
            genderType = "1"
        } else {
            genderType = "0"
        }
    }
    
    @IBAction func backAxn(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    @IBAction func DOBAxn(_ sender: UITextField) {
        
        sender.pastDatePicker()
    }
    
    
    
    
    @IBAction func addBtnAxn(_ sender: UIButton) {
        if firstNameTF.text == "" || LNameTF.text == "" || UNameTF.text == "" ||
        emailTF.text == "" || DOBTF.text == "" ||
        mobileTF.text == "" || passwordTF.text == "" || conformTF.text == "" {
        popUpAlert(title: "Alert", message: "Please Enter all Details..!", action: .alert)
                
        } else if firstNameTF.text!.count < 5 || LNameTF.text!.count < 5 || UNameTF.text!.count < 5 {
        popUpAlert(title: "Name", message: "Not lessthan 5 letters ", action: .alert)
        } else if emailTF.text?.isValidEmail(email: emailTF.text!) != true  {
        popUpAlert(title: "Eamil", message: "Enter valid Email", action: .alert)
            
        } else if mobileTF.text?.count != 10 {
        popUpAlert(title: "Alert", message: "Mobile No: should be 10 numbers", action: .alert)
            
        }  else if passwordTF.text?.isValidPassword() == false {
        
        popUpAlert(title: "Alert", message: "The Password must contain Min 6 letters[1 Capital Letter, 1 Small Letter,1 Symbol, 1 Number]", action: .alert)
              
        } else if conformTF.text != passwordTF.text {
        popUpAlert(title: "Password doesn't match", message: "Please conform password", action: .alert)
        } else {
            postData()
        }
    }
    
    
    
    func postData() {
        if reach.isConnectedToNetwork() == true {
            playLottie(fileName: "heartBeat")
        let registration : Dictionary = [FName : firstNameTF.text!, LName : LNameTF.text!, UserName : UNameTF.text!, Email : emailTF.text!, ConfirmPassword : conformTF.text!, PhoneNumber: mobileTF.text!, DOB: DOBTF.text!, Gender: genderType, MasterSubscriptionId:"1", MasterSubscriptionPlanId: "1",Password:passwordTF.text!] as [String : Any]
            
            ApiService.callPostToken(url: ClientInterface.addMemberUrl, params: registration, methodType: "POST", tag: "ADDMember", finish:finishPost)
                print("details = \(registration)")
                }  else {
            popUpAlert(title: "ALert", message: "Check Internet Connection", action: .alert)
        }
        
        
    }
    
    
               
             
          
       
       func finishPost (message:String, data:Data? , tag: String) -> Void {
           stopLottie()
           do {
           if let jsonData = data {
           let parsedData = try JSONDecoder().decode(RegisterResponse.self, from: jsonData)
           print(parsedData)
           if parsedData.StatusCode == 200 {
               popUpAlert(title: "Success", message: "Member Added", action: .alert)
               firstNameTF.text = ""
               LNameTF.text = ""
               UNameTF.text = ""
               DOBTF.text = ""
               mobileTF.text = ""
               passwordTF.text = ""
               conformTF.text = ""
               emailTF.text = ""
            genderSC.selectedSegmentIndex = -1
           } else {
               popUpAlert(title: "Registration Failed", message: "Check Details", action: .alert)
           }
           }
           } catch {
           popUpAlert(title: "Registration Failed", message: "Check Details", action: .alert)
               print("Parse Error: \(error)")
           }
    }
           
    
    
    
    
    
    
}
