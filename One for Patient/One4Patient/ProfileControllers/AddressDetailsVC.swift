//
//  AddressDetailsVC.swift
//  One for Patient
//
//  Created by Idontknow on 16/01/20.
//  Copyright © 2020 AnnantaSourceLLc. All rights reserved.
//

import UIKit

class AddressDetailsVC: UIViewController {
    
    
    @IBOutlet weak var userIMGView: UIImageView!
    @IBOutlet weak var cityTF: UITextField!
    
    @IBOutlet weak var address1TF: UITextField!
    @IBOutlet weak var stateTF: UITextField!
    @IBOutlet weak var ZIPTF: UITextField!
    
    @IBOutlet weak var saveBtn: UIButton!
    @IBOutlet weak var countryIDTF: UITextField!
    @IBOutlet weak var countryTF: UITextField!
    @IBOutlet weak var stateIDTF: UITextField!
    @IBOutlet weak var address2TF: UITextField!
    var isEdited:Bool = false
    override func viewDidLoad() {
        super.viewDidLoad()
       viewUpdates()
    }
    func viewUpdates() {
        userIMGView.makeRound()
        hideKeyboardWhenTappedAround()
        getDetails()
        addresDetailsInter(value: false)
    }
    
    
    
    @IBAction func backBtn(_ sender: UIButton) {
        
        self.navigationController?.popViewController(animated: true)
    }
    
    
    
    
    func addresDetailsInter(value :Bool) {
        address1TF.isUserInteractionEnabled = value
        address2TF.isUserInteractionEnabled = value
        cityTF.isUserInteractionEnabled = value
        stateTF.isUserInteractionEnabled = value
        stateIDTF.isUserInteractionEnabled = value
        ZIPTF.isUserInteractionEnabled = value
        countryTF.isUserInteractionEnabled = value
        countryIDTF.isUserInteractionEnabled = value

    }
    func addressDetailsColor(newColor: UIColor) {
      
         address1TF.backgroundColor = newColor 
         address2TF.backgroundColor = newColor
         cityTF.backgroundColor = newColor
         stateTF.backgroundColor = newColor
         stateIDTF.backgroundColor = newColor
         ZIPTF.backgroundColor = newColor
         countryTF.backgroundColor = newColor
         countryIDTF.backgroundColor = newColor
  }
    
    
    @IBAction func editAxn(_ sender: UIButton) {
        if isEdited == true {
           
        if reach.isConnectedToNetwork() == true {
            isEdited = false
            let addDetails = ["Address1":address1TF.text! as Any,"Address2":address2TF.text! as Any, "City":cityTF.text! as Any , "State":stateTF.text! as Any , "CountryId":countryIDTF.text! as Any , "StateId":stateIDTF.text!  as Any ,"Zip":ZIPTF.text! as Any ] as [String:Any]
          playLottie(fileName: "heartBeat")
          ApiService.callPostToken(url:ClientInterface.updateAddressUrl, params: addDetails, methodType: "POST", tag: "PostAddressDetails", finish:finishPost)
        print("addDetails = \(addDetails)")
        
       
        } else {
        popUpAlert(title: "Alert", message: "Check Internet Connection", action: .alert)
        }
        
        } else {
            isEdited = true
            addresDetailsInter(value: true)
            addressDetailsColor(newColor: .baseColor)
            sender.setImage(UIImage(named: "check"), for: .normal)

            
        }
    }
    
    func getDetails() {
        if reach.isConnectedToNetwork() == true {
         playLottie(fileName: "heartBeat")
         ApiService.callPostToken(url:ClientInterface.getProfileUrl, params: "", methodType: "GET", tag: "GetProfileInfo", finish:finishPost)
        } else {
        popUpAlert(title: "Alert", message: "Check Internet Connection", action: .alert)
        }
        
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

            address1TF.text = parsedData.Result.StreetAdd1
            address2TF.text = parsedData.Result.StreetAdd2
            cityTF.text = parsedData.Result.City
            stateTF.text = parsedData.Result.State
            stateIDTF.text = parsedData.Result.StateId
            ZIPTF.text = "\(parsedData.Result.Zip!)"
            countryTF.text = parsedData.Result.Country
            countryIDTF.text = parsedData.Result.CountryId
            
            if let img:UIImage = parsedData.Result.ProfilePic?.toImage() {
                userIMGView.image = img

            }  else {
                print("Unable to getImage")
            }
            }  else {
            
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
        addressDetailsColor(newColor: .white)
        saveBtn.setImage(UIImage(named: "pen"), for: .normal)
        getDetails()
                   
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
