//
//  VitalsVC.swift
//  One for Patient
//
//  Created by Idontknow on 31/01/20.
//  Copyright © 2020 AnnantaSourceLLc. All rights reserved.
//

import UIKit

class VitalsVC: UIViewController {
    
    @IBOutlet weak var BMITF: UITextField!
    
    @IBOutlet weak var BPTF: UITextField!
    
    @IBOutlet weak var tempTF: UITextField!
    @IBOutlet weak var weightTF: UITextField!
    
    @IBOutlet weak var rateTF: UITextField!
    @IBOutlet weak var pulseTF: UITextField!
    @IBOutlet weak var heightTF: UITextField!
    
    @IBOutlet weak var saturationTF: UITextField!
    
    @IBOutlet weak var headTF: UITextField!
    @IBOutlet weak var updateBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        viewChanges()
    }
    
    func viewChanges() {
        hideKeyboardWhenTappedAround()
        updateBtn.layer.cornerRadius = 10
    }

    
    
    
    @IBAction func updateAxn(_ sender: UIButton) {
    }
    
    func getData()  {
       if reach.isConnectedToNetwork() == true {
       playLottie(fileName: "heartBeat")

       ApiService.callPostToken(url: ClientInterface.getAllSplListUrl, params: "", methodType: "GET", tag: "VitalDetails", finish:finishPost)
       
       } else {
       popUpAlert(title: "Alert", message: "Check Internet Connecion", action: .alert)
                  
       }
       }
          
          
          
       func finishPost (message:String, data:Data? , tag: String) -> Void {
           
           stopLottie()
           
           do {
           if let jsonData = data {
           let parsedData = try JSONDecoder().decode(DoctorsListResponse.self, from: jsonData)
           print(parsedData)
           if parsedData.statusCode == 200 {
              
            } else {
            popUpAlert(title: "Alert", message: "Error in Getting Data ", action: .alert)
            }
            } else {
            popUpAlert(title: "Alert", message: "Error in Connecting Server ", action: .alert)
            }
            } catch {
             popUpAlert(title: "Alert", message: "Error in Connecting Server ", action: .alert)
             print("Parse Error: \(error)")
            }
       }
    
    
}
