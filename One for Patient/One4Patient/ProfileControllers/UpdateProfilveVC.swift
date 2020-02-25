//
//  UpdateProfilveVC.swift
//  One for Patient
//
//  Created by Idontknow on 12/12/19.
//  Copyright © 2019 AnnantaSourceLLc. All rights reserved.
//

import UIKit

class UpdateProfilveVC: UIViewController {
    
   
    @IBOutlet weak var MiddleNameTF: UITextField!
    @IBOutlet weak var DOBTF: UITextField!
    @IBOutlet weak var userIMGView: UIImageView!
    @IBOutlet weak var LnameTF: UITextField!
    @IBOutlet weak var FnameTF: UITextField!
    @IBOutlet weak var genderTF: UITextField!
    @IBOutlet weak var SSNTF: UITextField!
    @IBOutlet weak var FaxTF: UITextField!
    @IBOutlet weak var otherContactTF: UITextField!
    @IBOutlet weak var homeContactTF: UITextField!
    @IBOutlet weak var otherCodeTF: UITextField!
    @IBOutlet weak var homeCodeTF: UITextField!
    @IBOutlet weak var saveBtn: UIButton!
    @IBOutlet weak var addBtn: UIButton!
    @IBOutlet weak var adressBtn: UIButton!
    
    var isEdited:Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        basicDetailsInter(value: false)
        getDetails()
        DOBTF.isUserInteractionEnabled = false
        genderTF.isUserInteractionEnabled = false
    }
    
    func basicDetailsInter(value:Bool) {
        FnameTF.isUserInteractionEnabled = value
        MiddleNameTF.isUserInteractionEnabled = value
        LnameTF.isUserInteractionEnabled = value
        SSNTF.isUserInteractionEnabled = value
        FaxTF.isUserInteractionEnabled = value
        otherContactTF.isUserInteractionEnabled = value
        homeCodeTF.isUserInteractionEnabled = value
        otherCodeTF.isUserInteractionEnabled = value
        homeContactTF.isUserInteractionEnabled = value
        hideKeyboardWhenTappedAround()
        adressBtn.layer.cornerRadius = 10
        userIMGView.makeRound()
        
    }
    
    @IBAction func addressAxn(_ sender: UIButton) {
        let VC =  self.storyboard?.instantiateViewController(withIdentifier: "AddressDetailsVC") as! AddressDetailsVC
        self.navigationController?.pushViewController(VC, animated: true )
    }
    
    
    
    func basicColorChange(color:UIColor) {
        FnameTF.backgroundColor = color
        MiddleNameTF.backgroundColor = color
        LnameTF.backgroundColor = color
        SSNTF.backgroundColor = color
        FaxTF.backgroundColor = color
        otherCodeTF.backgroundColor = color
        homeCodeTF.backgroundColor = color
        otherContactTF.backgroundColor = color
        homeContactTF.backgroundColor = color
    }
    
    
   
   
   
   @IBAction func updateAxn(_ sender: UIButton) {
    if isEdited == true {
      
    if reach.isConnectedToNetwork() == true {
            
    let basicDetails = [FName:FnameTF.text! as Any , "MName":MiddleNameTF.text! as Any , LName:LnameTF.text! as Any, "HomeContactCountryCode":homeCodeTF.text! as Any , "HomeContact":homeContactTF.text! as Any , "WorkContactCountryCode":otherCodeTF.text! as Any, "WorkContact":otherContactTF.text! as Any, "SSN":SSNTF.text! as Any, "Fax":FaxTF.text!as Any ] as [String:Any]
             playLottie(fileName: "heartBeat")
    ApiService.callPostToken(url:ClientInterface.updateProfileUrl, params:basicDetails , methodType: "POST", tag: "PostBasicDetails", finish:finishPost)
        print("basicDetails = \(basicDetails)")
    
        }
        } else {
        sender.setImage(UIImage(named: "check"), for: .normal)
        isEdited = true
        basicDetailsInter(value: true)
        basicColorChange(color: .baseColor)
    }
        
    }
    
    
    
    func getDetails() {
        playLottie(fileName: "heartBeat")
          
       ApiService.callPostToken(url:ClientInterface.getProfileUrl, params: "", methodType: "GET", tag: "GetProfileInfo", finish:finishPost)
                         
       }
    
    
    
    func finishPost (message:String, data:Data? , tag: String) -> Void {
        stopLottie()
        if tag == "GetProfileInfo" {
        do {
           if let jsonData = data {
           let parsedData = try JSONDecoder().decode(ProfileInfoResponse.self, from: jsonData)
           print(parsedData)
           if parsedData.StatusCode == 200 {
            print("Got Details")

            FnameTF.text = parsedData.Result.FName
            MiddleNameTF.text = parsedData.Result.MName
            LnameTF.text = parsedData.Result.LName
            DOBTF.text = parsedData.Result.DOB
            genderTF.text = parsedData.Result.Gender.Name
            SSNTF.text = parsedData.Result.SSN
            FaxTF.text = parsedData.Result.Fax
            otherContactTF.text = parsedData.Result.WorkContact
            homeContactTF.text = parsedData.Result.HomeContact
            if let img:UIImage = parsedData.Result.ProfilePic?.toImage() {
                userIMGView.image = img

            } else {
                print("Unable to getImage")
            }
            } else {
               print("Check Details")
            }
            }
            } catch {
               
              print("Parse Error: \(error)")
            }
            
        } else {
            do {
        if let jsonData = data {
        let parsedData = try JSONDecoder().decode(PostProfileResponse.self, from: jsonData)
        print(parsedData)
        if parsedData.StatusCode == 200 {
        popUpAlert(title: "Success", message: "Updated Successfully", action: .alert)
        getDetails()
        basicDetailsInter(value: false)
        basicColorChange(color: .white)
        saveBtn.setImage(UIImage(named: "pen"), for: .normal)
        } else {
        popUpAlert(title: "Alert", message: "Update Failed", action: .alert)
        }
        }
        } catch {
        print("Parse Error: \(error)")
        }
        }
        }
           

}

