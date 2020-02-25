//
//  ProfileVC.swift
//  One for Patient
//
//  Created by Idontknow on 27/11/19.
//  Copyright © 2019 AnnantaSourceLLc. All rights reserved.
//

import UIKit

class ProfileVC: UIViewController,  UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    
    @IBOutlet weak var splView: UIView!
    @IBOutlet weak var profileView: UIView!
    @IBOutlet weak var userImgView: UIImageView!
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var IDLbl: UILabel!
    @IBOutlet weak var docIMGView: UIImageView!
    @IBOutlet weak var docNameLbl: UILabel!
    @IBOutlet weak var degreeLbl: UILabel!
    @IBOutlet weak var videoBtn: UIButton!
    @IBOutlet weak var chatBtn: UIButton!
    @IBOutlet weak var hospitalLbl: UILabel!
    @IBOutlet weak var insureView: UIView!
    @IBOutlet weak var insuranceBtn: UIButton!
    @IBOutlet weak var mobileTF: UITextField!
    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var emailSV: UIStackView!
    @IBOutlet weak var mobileSV: UIStackView!
    @IBOutlet weak var editBtn: UIButton!
    
    var pickedImage = UIImage()
    var isEdited:Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewChanges()
        getUserInfo()
        tapFunction()
    }
    func getUserInfo() {
    if reach.isConnectedToNetwork() == true {
            playLottie(fileName: "heartBeat")
    ApiService.callPostToken(url:ClientInterface.getAccountUrl, params: "", methodType: "GET", tag: "GetUserInfo", finish:finishPost)
        }  else {
        popUpAlert(title: "Alert", message: "Check Internet Connection", action: .alert)
        }
    }
    
    func viewChanges() {
        userImgView.makeRound()
        docIMGView.makeRound()
        profileView.elevate(elevation: 3.0)
        emailTF.isUserInteractionEnabled =  false
        mobileTF.isUserInteractionEnabled =  false
        splView.isHidden = true
        profileView.layer.cornerRadius = 10

    }
    
//    MARK: Editing EMail & Mobile Number
   
    
    @IBAction func editAxn(_ sender: UIButton) {
        
        if isEdited == true {
            isEdited = false
        if  emailTF.text?.isValidEmail(email: emailTF.text!) == false {
        popUpAlert(title: "Alert", message: "Enter Valid EMail.", action: .alert)
        } else if mobileTF.text?.count != 10 {
        popUpAlert(title: "ALert", message: "Enter 10 Digit Mobile Number", action: .alert)
        } else if reach.isConnectedToNetwork() == true {
        let details = [Email:emailTF.text! as Any,  PhoneNumber:mobileTF.text! as Any ] as [String:Any]
       
           playLottie(fileName: "heartBeat")
            ApiService.callPostToken(url:ClientInterface.updateAccountUrl, params: details, methodType: "POST", tag: "UpdateAccount", finish:finishPost)
        print("details = \(details)")
        } else {
        popUpAlert(title: "Alert", message: "Check Internet Connection", action: .alert)
        }
            
        } else {
            isEdited = true
            mobileTF.isUserInteractionEnabled = true
            emailTF.isUserInteractionEnabled = true
            sender.setImage(UIImage(named: "check"), for: .normal)
            emailTF.backgroundColor = .white
            mobileTF.backgroundColor = .white
        }
    }
    
    
//    MARK: Camera Action
    func tapFunction() {
        userImgView.isUserInteractionEnabled = true
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(onTapImg(_:)))
        tapGesture.numberOfTouchesRequired =  1
        tapGesture.numberOfTapsRequired = 1
        userImgView.addGestureRecognizer(tapGesture)
           
       }
       @objc func onTapImg( _ sender:UITapGestureRecognizer) {
           print("User Selected Image")
           cameraAlert()
           
    }
    
    
    
    
    
    //MARK: image picker
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any])
       {
           pickedImage = info[.editedImage] as! UIImage
           userImgView.image = pickedImage
           print("Image is picked")
        _ = info[UIImagePickerController.InfoKey.referenceURL] as! NSURL
//        let fileName = imageURL.absoluteString
           picker.dismiss(animated: true) {
//           self.saveImage()
           }
       }
    
//    MARK: Save Image
    func saveImage() {
        if userImgView.image == pickedImage {
        let details = ["profilePicFile":userImgView.image as Any ] as [String:Any]
        playLottie(fileName: "heartBeat")
        ApiService.callImageToken(url:ClientInterface.imageUrl, params: details, methodType: "POST", tag: "UploadPic", finish:finishPost)
        print("details = \(details)")
        } else {
        print("Image Not Picked")
        }
         
        
        
    }
    
    
    @IBAction func backBtn(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
   
    @IBAction func videoBtn(_ sender: UIButton) {
        DoctorInfo.setDocName(type: docNameLbl.text!)
        let imgStr = docIMGView.image?.toString()
        DoctorInfo.setDocImg(type: imgStr!)
        let VC = self.storyboard?.instantiateViewController(withIdentifier: "CallVC") as! CallVC
        self.navigationController?.pushViewController(VC, animated: true)
    }
//    MARK : Edit  Action
    
    @IBAction func chatBtnAxn(_ sender: UIButton) {
        DoctorInfo.setDocName(type: docNameLbl.text!)
        let imgStr = docIMGView.image?.toString()
        DoctorInfo.setDocImg(type: imgStr!)
        let VC = self.storyboard?.instantiateViewController(withIdentifier: "TextChatViewController") as! TextChatViewController
        self.navigationController?.pushViewController(VC, animated: true)
        
    }
    
    @IBAction func insureBtnAxn(_ sender: UIButton) {
        popUpAlert(title: "Alert", message: "Under Development", action: .alert)
        
    }
    
    
    
    
    
    func finishPost (message:String, data:Data? , tag: String) -> Void {
        stopLottie()
        if tag == "UpdateAccount" {
        do {
        if let jsonData = data {
        let parsedData = try JSONDecoder().decode(CommonResponse.self, from: jsonData)
        print(parsedData)
        if parsedData.StatusCode == 200 {
            popUpAlert(title: "Success", message: "Updated Successfully", action: .alert)
            editBtn.setImage(UIImage(named: "pen"), for: .normal)
            emailTF.isUserInteractionEnabled = false
            mobileTF.isUserInteractionEnabled =  false
            emailTF.backgroundColor  = .baseColor
            mobileTF.backgroundColor = .baseColor
            
            getUserInfo()

        } else {
        popUpAlert(title: "Alert", message: "Update Failed", action: .alert)
        }
        }
        } catch {
        print("Parse Error: \(error)")
        }
        } else {
        
       do {
       if let jsonData = data {
       let parsedData = try JSONDecoder().decode(UserInfoResponse.self, from: jsonData)
       print(parsedData)
       if parsedData.StatusCode == 200 {
        nameLbl.text = parsedData.Result.UserName
        emailTF.text = parsedData.Result.Email
        mobileTF.text = parsedData.Result.PhoneNumber
        IDLbl.text = "ID#\(parsedData.Result.Id!)"
        AccountInfo.setProfileID(type: parsedData.Result.Id!)
        GlobalVariables.profileID = "\(parsedData.Result.Id!)"
        let imageUrl = ClientConfig.BASE_URL + "\(parsedData.Result.Profile?.ProfilePic)"
        print("imageUrl = \(imageUrl)")
//        userImgView.getFromUrl(str: imageUrl)
      
       } else {
         popUpAlert(title: "Getting User info Failed", message: parsedData.Message!, action: .alert)
       }
       }
       } catch {
    
        print("Parse Error: \(error)")
       }
       }
       }
    
    
}
