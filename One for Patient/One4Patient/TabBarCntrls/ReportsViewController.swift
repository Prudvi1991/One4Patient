//
//  ReportsViewController.swift
//  One for Patient
//
//  Created by Idontknow on 10/11/19.
//  Copyright © 2019 AnnantaSourceLLc. All rights reserved.
//

import UIKit

class ReportsViewController: UIViewController {
    
    @IBOutlet weak var headTF: UITextField!
    @IBOutlet weak var editBtn: UIButton!
    @IBOutlet weak var pulseTF: UITextField!
    @IBOutlet weak var tempTF: UITextField!
    
    @IBOutlet weak var typeASC: UISegmentedControl!
    @IBOutlet weak var typeBSC: UISegmentedControl!
    
    @IBOutlet weak var typeCSC: UISegmentedControl!
    @IBOutlet weak var saturationTF: UITextField!
    @IBOutlet weak var BMITF: UITextField!
    @IBOutlet weak var rateTF: UITextField!
    @IBOutlet weak var weightTF: UITextField!
    @IBOutlet weak var heightTF: UITextField!
    
    @IBOutlet weak var BPTF: UITextField!
    
    var isEdited:Bool = false
   override func viewDidLoad() {
        super.viewDidLoad()

        viewChanges()
    }
    
    func viewChanges() {
        isUserAxnEnabled(value: false)
    }
    
    
    func isUserAxnEnabled(value:Bool) {
        heightTF.isUserInteractionEnabled = value
        weightTF.isUserInteractionEnabled = value
        BMITF.isUserInteractionEnabled = value
        BPTF.isUserInteractionEnabled = value
        tempTF.isUserInteractionEnabled = value
        pulseTF.isUserInteractionEnabled = value
        rateTF.isUserInteractionEnabled = value
        saturationTF.isUserInteractionEnabled = value
        headTF.isUserInteractionEnabled = value
        
        }

    @IBAction func editAxn(_ sender: UIButton) {
        sender.setImage(UIImage(named: "check"), for: .normal)
        isEdited = true
        isUserAxnEnabled(value: true)
        if isEdited == true {
            sender.setImage(UIImage(named: "pen"), for: .normal)
        isEdited = false
        isUserAxnEnabled(value: false)
        }
    }
    

    
    
    @IBAction func SCAxn(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
       
        case 1 :
            let VC = self.storyboard?.instantiateViewController(withIdentifier: "MedicationVC") as! MedicationVC
        self.navigationController?.pushViewController(VC, animated: true)
        case 2 :
            let VC = self.storyboard?.instantiateViewController(withIdentifier: "AllergyVC") as! AllergyVC
            self.navigationController?.pushViewController(VC, animated: true)
        default:
            break
        }
        
        }
    
    @IBAction func typeBAxn(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        
         case 1 :
             let VC = self.storyboard?.instantiateViewController(withIdentifier: "MConditionsVC") as! MConditionsVC
         self.navigationController?.pushViewController(VC, animated: true)
         case 0 :
             let VC = self.storyboard?.instantiateViewController(withIdentifier: "HabitsVC") as! HabitsVC
             
            self.navigationController?.pushViewController(VC, animated: true)
         default:
             break
         }
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
