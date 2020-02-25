//
//  ContentViewController.swift
//  One for Patient
//
//  Created by Idontknow on 10/11/19.
//  Copyright © 2019 AnnantaSourceLLc. All rights reserved.
//

import UIKit

class ContentViewController: UIViewController {

    
    @IBOutlet weak var verifySV: UIStackView!
    @IBOutlet weak var passwordSV: UIStackView!
    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var submitBtn: UIButton!
    @IBOutlet weak var sendBtn: UIButton!
    @IBOutlet weak var confirmTF: UITextField!
    @IBOutlet weak var PassTF: UITextField!
    @IBOutlet weak var verifyBtn: UIButton!
    @IBOutlet weak var pinTF: UITextField!
    var validationToken = String()
    
      override func viewDidLoad() {
        super.viewDidLoad()
       viewChanges()

    }
    
    func viewChanges() {
        verifySV.isHidden = true
        passwordSV.isHidden = true
        submitBtn.isHidden = true
   }
    
    
    @IBAction func sendAxn(_ sender: UIButton) {
        if emailTF.text?.isValidEmail(email: emailTF.text!) == false {
            popUpAlert(title: "Alert", message: "Enter a Valid Email.", action: .alert)
        } else if reach.isConnectedToNetwork() ==  true {
            let details = [Email:emailTF.text as Any] as [String:Any]
            print("details = \(details)")

        ApiService.callPost(url:ClientInterface.forgotPasswordUrl, params: details, methodType: "POST", tag: "ForgotPassword", finish:finishPost)
                   
        } else {
             popUpAlert(title: "Alert", message: "Check Internet Connection", action: .alert)
        }
    }
    
    
    @IBAction func verifyAxn(_ sender: UIButton) {
        if pinTF.text!.count != 6 {
            popUpAlert(title: "Alert", message: "Enter 6 digit PassCode", action: .alert)
        } else if reach.isConnectedToNetwork() == true {
            let details = [Email:emailTF.text as Any, "PassCode":pinTF.text as Any] as [String:Any]
             print("details = \(details)")
         ApiService.callPost(url:ClientInterface.validatePasscodeUrl, params: details, methodType: "POST", tag: "VerifyPassCode", finish:finishPost)
        } else {
            popUpAlert(title: "Alert", message: "Check Internet Connection", action: .alert)
        }
        
    
    }
    
    
    @IBAction func submitBtn(_ sender: UIButton) {
        if PassTF.text!.isEmpty ==  true || confirmTF.text!.isEmpty == true {
            popUpAlert(title: "Alert", message: "Please Enter all Details", action: .alert)
        } else if reach.isConnectedToNetwork() == true  {
        let details = [Email:emailTF.text! as Any, Password:PassTF.text! as Any, ConfirmPassword:confirmTF.text! as Any ,
                "PasswordResetToken":validationToken as Any ]  as [String:Any]
            print("details = \(details)")
        ApiService.callPost(url:ClientInterface.resetPasswordUrl, params: details, methodType: "POST", tag: "ResetPassword", finish:finishPost)
        } else {
            popUpAlert(title: "Alert", message: "Check Internet Connection", action: .alert)
        }
    }
    
    
    
    @IBAction func backBtnAxn(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    
     func finishPost (message:String, data:Data? , tag: String) -> Void {
         if tag == "ForgotPassword" {
         do {
         if let jsonData = data {
         let parsedData = try JSONDecoder().decode(CommonResponse.self, from: jsonData)
         print(parsedData)
            
         if parsedData.StatusCode == 200 {
         popUpAlert(title: "Success - Passcode sent to your email", message: "Enter PassCode to Verify ", action: .alert)
            verifySV.isHidden = false
            verifySV.showPopupAnimation()
         } else {
         popUpAlert(title: "Failed", message: parsedData.Message!, action: .alert)
         }
         }
         } catch {
         print("Parse Error: \(error)")
         }
         } else if tag == "VerifyPassCode" {
         do {
            if let jsonData = data {
            let parsedData = try JSONDecoder().decode(ValidatePasscodeRes.self, from: jsonData)
            print(parsedData)
            if parsedData.StatusCode == 200 {
            popUpAlert(title: "Verified Successfully", message: "Change your Password", action: .alert)
            validationToken = parsedData.Result.PasswordResetToken!
            passwordSV.isHidden = false
            passwordSV.showPopupAnimation()
                
            submitBtn.isHidden = false
               
            } else {
            popUpAlert(title: "Verifaction Failed", message: parsedData.Message!, action: .alert)
            }
            }
            } catch {
            print("Parse Error: \(error)")
            }
        } else {
            do {
            if let jsonData = data {
            let parsedData = try JSONDecoder().decode(CommonResponse.self, from: jsonData)
            print(parsedData)
            if parsedData.StatusCode == 200 {
            popUpAlert(title: "Reset Password Success", message: "Happy Login..!", action: .alert)
                          
                } else {
            popUpAlert(title: "Reset Password Failed", message: "Try Again..!", action: .alert)
            }
            }
            } catch {
            print("Parse Error: \(error)")
            }
        }
    }
    
}
