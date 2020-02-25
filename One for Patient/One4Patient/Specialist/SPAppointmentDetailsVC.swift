//
//  SPAppointmentDetailsVC.swift
//  One for Patient
//
//  Created by Idontknow on 20/01/20.
//  Copyright © 2020 AnnantaSourceLLc. All rights reserved.
//

import UIKit

class SPAppointmentDetailsVC: UIViewController {
    @IBOutlet weak var timeLbl: UILabel!
    @IBOutlet weak var appTypeLbl: UILabel!
    @IBOutlet weak var profileView: UIView!
    @IBOutlet weak var dateLbl: UILabel!
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var userIMGView: UIImageView!
    @IBOutlet weak var reasonLbl: UILabel!
    @IBOutlet weak var statusSC: UISegmentedControl!
    @IBOutlet weak var emergencyLbl: UILabel!
    @IBOutlet weak var cancelTF: UITextField!
    @IBOutlet weak var updateBtn: UIButton!
    @IBOutlet weak var symptomsCV: UICollectionView!
    
    @IBOutlet weak var statusLbl: UILabel!
    
    var dataArray:[AppointmentSymptomMap] = []
    var sendStatus = ""
    override func viewDidLoad() {
        super.viewDidLoad()

        viewChanges()
    }
    
    func viewChanges() {
        getData()
        userIMGView.makeRound()
        CVChanges()
        cancelTF.isHidden = true
        statusLbl.layer.cornerRadius = 10
        updateBtn.layer.cornerRadius = 10
        profileView.layer.cornerRadius = 10
        profileView.elevate(elevation: 3.0)
        statusLbl.makeRound()
    }
    
    
    @IBAction func statusAxn(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 1 {
        cancelTF.isHidden = false
        sendStatus = "2"
        } else if sender.selectedSegmentIndex == 2 {
        cancelTF.isHidden = false
        sendStatus = "4"
        } else if sender.selectedSegmentIndex == 3 {
        cancelTF.isHidden = true
        sendStatus = "5"
        } else {
        cancelTF.isHidden = true
        sendStatus = "1"
        }
    }
    
    
    @IBAction func updateAxn(_ sender: UIButton) {
        if statusSC.selectedSegmentIndex != 0 && statusSC.selectedSegmentIndex != 1 && statusSC.selectedSegmentIndex != 2 && statusSC.selectedSegmentIndex != 3   {
        popUpAlert(title: "Alert", message: " Appointment Starus is not Selected.", action: .alert)
        } else if statusSC.selectedSegmentIndex == 1 || statusSC.selectedSegmentIndex == 2 {
            
        if cancelTF.text == "" {
        popUpAlert(title: "Alert", message: "Please Specify Reason ", action: .alert)
        } else {
        postData()
        }
            
        } else {
        postData()
        }
    }
    
    
    @IBAction func backAxn(_ sender: UIButton) {
    self.navigationController?.popViewController(animated: true)
        
    }
    
//    MARK: API Call
    func getData() {
    if reach.isConnectedToNetwork() == true {
        dataArray.removeAll()
    playLottie(fileName: "heartBeat")
        
    ApiService.callPostToken(url: ClientInterface.getAppbyIDUrl + "\(GlobalVariables.appointmentID)", params: "", methodType: "GET", tag: "GetAppointment", finish:finishPost)
    } else {
    popUpAlert(title: "Alert", message: "Check Internet Connection", action: .alert)
    }
    }
    
    func postData() {
        
        if reach.isConnectedToNetwork() == true {
        playLottie(fileName: "heartBeat")
        let details = ["AppointmentStatus":sendStatus as Any, "StatusMessage":cancelTF.text!] as [String:Any]
        ApiService.callPostToken(url: ClientInterface.EditAppStatusUrl, params: details, methodType: "POST", tag: "EditStatus", finish:finishPost)
        print("details = \(details)")
        } else {
        popUpAlert(title: "Alert", message: "Check Internet Connection", action: .alert)
        }
        
    }
    
       
//       MARK: API Response
    func finishPost (message:String, data:Data? , tag: String) -> Void {
        stopLottie()

        if tag == "EditStatus" {
            
        do {
        if let jsonData = data {
        let parsedData = try JSONDecoder().decode(EditAppStatusResponse.self, from: jsonData)
        print(parsedData)
        if parsedData.StatusCode == 200 {
        popUpAlert(title: "Success", message: "Appoinment Status Updated successfully", action: .alert)
        cancelTF.text = ""
        statusSC.selectedSegmentIndex = -1
        getData()
            
        } else {
        popUpAlert(title: "Alert", message: "Error in Updating Appointment. Check Details.!", action: .alert)
        }
        } else {
        popUpAlert(title: "Alert", message: "Error in Updating Appointment. Check Details.!", action: .alert)
        }
        } catch {
          popUpAlert(title: "Alert", message: "Error in Connecting Server ", action: .alert)
                print("Parse Error: \(error)")
        }
            
        } else {
                
           do {
           if let jsonData = data {
                               
           let parsedData = try JSONDecoder().decode(SingleAppoinmentResponse.self, from: jsonData)
           print(parsedData)
           if parsedData.statusCode == 200 {
            
            symptomsCV.reloadData()
            print("AppID = \(parsedData.result.id)")
            dataArray = parsedData.result.appointmentSymptomMaps
            nameLbl.text = parsedData.result.patient.userName!
            appTypeLbl.text = "Appointment Type :  \(parsedData.result.preferredModeOfContact)"
            if parsedData.result.isEmergency == true {
                emergencyLbl.text = "IS Emergency : YES"
            } else {
                emergencyLbl.text = "IS Emergency : NO"
             }
            
            switch parsedData.result.currentStatus {
            case 0:
                statusLbl.text = "Queued"
                statusLbl.backgroundColor = .systemOrange
            case 1:
                statusLbl.text = "Accepted"
                statusLbl.backgroundColor = .green
            case 2:
                statusLbl.text = "Declined"
                statusLbl.backgroundColor = .red
            case 3:
                statusLbl.text = "Cancelled"
                statusLbl.backgroundColor = .red
            case 4:
                statusLbl.text = "Closed"
                statusLbl.backgroundColor = .orange
            case 5:
                statusLbl.text = "FollowUp"
                statusLbl.backgroundColor = .baseColor

            case 6:
                statusLbl.text = "Pooled"
                statusLbl.backgroundColor = .baseColor

            case 7:
                statusLbl.text = "PopFromPool"
                statusLbl.backgroundColor = .baseColor
                
            case 8:
                statusLbl.text = "PushToPool"
                statusLbl.backgroundColor = .baseColor
                
            default:
                statusLbl.backgroundColor = .baseColor
        }
            
            let dateStr = parsedData.result.dateOfAppointment.prefix(10)
               dateLbl.text = "\(dateStr)"
            let timeStr = parsedData.result.startTimeOfAppointment.suffix(8)
               timeLbl.text = "\(timeStr)"
               reasonLbl.text = parsedData.result.reasonForAppointment
               symptomsCV.reloadData()
               print("Got Appointment Details")
            
        } else {
           popUpAlert(title: "Alert", message: "Error in getting appointment details ", action: .alert)
           }
            
       } else {
           popUpAlert(title: "Alert", message: "Error in getting appointment details ", action: .alert)
           }
       } catch {
           popUpAlert(title: "Alert", message: "Error in Connecting Server ", action: .alert)
           print("Parse Error: \(error)")
           }
        }
           
    }
       
      
//      MARK: SymptomCV Changes
    func CVChanges() {
       let cellSize = CGSize(width:130 , height:25)
       let layout = UICollectionViewFlowLayout()
       layout.scrollDirection = .horizontal //.horizontal
       layout.itemSize = cellSize
       layout.sectionInset = UIEdgeInsets(top: 1, left: 5, bottom: 1, right: 1)
       layout.minimumLineSpacing = 5.0
           layout.minimumInteritemSpacing = 1.0
       symptomsCV.setCollectionViewLayout(layout, animated: true)
       symptomsCV.delegate = self
       symptomsCV.dataSource = self
    }
    
    
    
    

}

extension SPAppointmentDetailsVC: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! SymptomsCVC
        let cellPath = dataArray[indexPath.row]
        cell.textLbl.text = cellPath.symptom.name
        
//        let titleLbl = UILabel(frame: CGRect(x: 5, y: 0, width: cell.bounds.size.width, height: 25))
//        titleLbl.textColor = .white
//        titleLbl.text = "\(cellPath.symptom.name)"
//        titleLbl.font = UIFont(name: "Baskerville", size: 14)
//        cell.contentView.addSubview(titleLbl)
        cell.contentView.layer.cornerRadius = 10
        return cell
    }
    
    
    
    
    
    
    
}
