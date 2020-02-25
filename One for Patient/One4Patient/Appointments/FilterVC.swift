//
//  FilterVC.swift
//  One for Patient
//
//  Created by Idontknow on 21/01/20.
//  Copyright © 2020 AnnantaSourceLLc. All rights reserved.
//

import UIKit

class FilterVC: UIViewController {

    @IBOutlet var filterView: UIView!
    @IBOutlet weak var filterTypeSC: UISegmentedControl!
    @IBOutlet weak var typeSC: UISegmentedControl!
    @IBOutlet weak var fromDateTF: UITextField!
    @IBOutlet weak var dataTV: UITableView!
    @IBOutlet weak var TODate: UITextField!
    @IBOutlet weak var cancelBtn: UIButton!
    @IBOutlet weak var submitBtn: UIButton!
    
    @IBOutlet var notifyView: UIView!
    
    
    var dataArray:[AppointmentListResult] = []
    var sendStatus = "0"
    var sendID = GlobalVariables.accountID
    var isFiltered :Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewChanges()

    }
    func viewChanges() {
        dataTV.rowHeight = 100
        getData()
        submitBtn.layer.cornerRadius = 10
        cancelBtn.layer.cornerRadius = 10
        notifyFunc()
//        showFilterView()
    }
    
    
    @IBAction func backAxn(_ sender: UIButton) {
    self.navigationController?.popViewController(animated: true)
    }
    
    func notifyFunc() {
        self.view.addSubview(notifyView)
       notifyView.center = self.view.center

        notifyView.isHidden = true
    }
    
    func showFilterView() {
        view.addSubview(filterView)
         filterView.layer.cornerRadius = 10
        filterView.elevate(elevation: 10.0)
        isFiltered = true
        filterView.isHidden = false
//        filterView.center = self.view.center
        filterView.frame = CGRect(x: 20, y: 150, width: self.view.frame.width - 40, height: 220)
      
               
    }
    
    
    @IBAction func dateAxn(_ sender: UITextField) {
        sender.pastDatePicker()
    }
    
//    MARK: Add Filter View
    @IBAction func filterAxn(_ sender: UIButton) {
       showFilterView()
    }
    
    @IBAction func filterTypeAxn(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 1 {
        TODate.isHidden = false
        fromDateTF.isHidden = false
        } else {
        TODate.isHidden = true
        fromDateTF.isHidden = false
        
        }
    }
    
//    MARK:REmove Filter View
    @IBAction func cancelAxn(_ sender: UIButton) {
        filterView.removeFromSuperview()
        isFiltered = false

    }
    
    
    
    @IBAction func submitBtn(_ sender: UIButton) {
        if reach.isConnectedToNetwork() == true {
            
        if filterTypeSC.selectedSegmentIndex == 1 {
            
            if fromDateTF.text?.isEmpty == true || TODate.text?.isEmpty == true {
            popUpAlert(title: "Alert", message: "Enter Date", action: .alert)
            } else  {
              postData()
            }
                
       } else  {
            if fromDateTF.text?.isEmpty == true {
            popUpAlert(title: "Alert", message: "Enter Date", action: .alert)
            } else  {
            postData()
            }
            }
            
        } else {
            popUpAlert(title: "Alert", message: "Check Internet Connection", action: .alert)
        }
    }
    
    
    
    
    @IBAction func typeSCAxn(_ sender: UISegmentedControl) {
        
        if sender.selectedSegmentIndex == 1 {
        sendStatus = "1"
        getData()
        } else if sender.selectedSegmentIndex == 2 {
        sendStatus = "2"
        getData()
        } else if sender.selectedSegmentIndex == 3 {
        sendStatus = "3"
        getData()
        } else {
        sendStatus = "0"
        getData()
        }
    }
    
    
    
    
    
    // MARK: POst Data API
    func postData() {
        if reach.isConnectedToNetwork() == true {
            notifyView.isHidden = true
            playLottie(fileName: "heartBeat")
            
        if filterTypeSC.selectedSegmentIndex == 1 {
            
        if GlobalVariables.isDoctor == true {
        let  details = ["SpecialistUserId":sendID as Any, "ByDate":"True" as Any, "DateOfAppointmentFrom":fromDateTF.text! as Any, "DateOfAppointmentTo":TODate.text! as Any  ] as [String:Any]
        ApiService.callPostToken(url:  ClientInterface.appointmentListUrl, params: details, methodType: "POST", tag: "GetAppointment", finish:finishPost)
        } else {
            if BookingFor.isUserSelected == true {
                sendID = BookingFor.userId
            } else {
            sendID = GlobalVariables.accountID
            }
            let  details = ["PatientUserId":sendID as Any, "ByDate":"True" as Any, "DateOfAppointmentFrom":fromDateTF.text! as Any, "DateOfAppointmentTo":TODate.text! as Any  ] as [String:Any]
           ApiService.callPostToken(url:  ClientInterface.appointmentListUrl, params: details, methodType: "POST", tag: "GetAppointment", finish:finishPost)
            print("details = \(details)")
            
            }
            
        } else  {
            
            if GlobalVariables.isDoctor == true {
            let  details = ["SpecialistUserId":sendID as Any, "ByDate":"True" as Any, "DateOfAppointmentFrom":fromDateTF.text! as Any ] as [String:Any]
            ApiService.callPostToken(url:  ClientInterface.appointmentListUrl, params: details, methodType: "POST", tag: "GetAppointment", finish:finishPost)
                
            } else {
                if BookingFor.isUserSelected == true {
                sendID = BookingFor.userId
                } else {
                sendID = GlobalVariables.accountID
                }
                let  details = ["PatientUserId":sendID as Any, "ByDate":"True" as Any, "DateOfAppointmentFrom":fromDateTF.text! as Any ] as [String:Any]
                
                 ApiService.callPostToken(url:  ClientInterface.appointmentListUrl, params: details, methodType: "POST", tag: "GetAppointment", finish:finishPost)
                print("details = \(details)")
            }
            
        }
            
        } else {
        popUpAlert(title: "Alert", message: "Check Internet Connection", action: .alert)
        }
            
    }
    
    func getData() {
        
        if reach.isConnectedToNetwork() == true {
            notifyView.isHidden = true
            playLottie(fileName: "heartBeat")

        if GlobalVariables.isDoctor == true {
        let  details = ["SpecialistUserId":sendID as Any, "CurrentStatus":sendStatus as Any ] as [String:Any]
        ApiService.callPostToken(url:  ClientInterface.appointmentListUrl, params: details, methodType: "POST", tag: "GetAppointment", finish:finishPost)
                print("details = \(details)")
        } else {
            
            if BookingFor.isUserSelected == true {
            sendID = BookingFor.userId
            } else {
            sendID = GlobalVariables.accountID
            }
            let  details = ["PatientUserId":sendID as Any, "CurrentStatus":sendStatus as Any ] as [String:Any]
            ApiService.callPostToken(url:  ClientInterface.appointmentListUrl, params: details, methodType: "POST", tag: "GetAppointment", finish:finishPost)
             print("details = \(details)")
        }
            
        } else {
        popUpAlert(title: "Alert", message: "Check Internet Connection", action: .alert)
        }
    }
             
    //    MARK: API Response
    func finishPost (message:String, data:Data? , tag: String) -> Void {
      
        stopLottie()
        do {
        if let jsonData = data {
        let parsedData = try JSONDecoder().decode(AppointmentListResponse.self, from: jsonData)
        print(parsedData)
        if parsedData.statusCode == 200 {
        if isFiltered == true {
        typeSC.selectedSegmentIndex = -1
        filterView.removeFromSuperview()
        isFiltered = false
        fromDateTF.text = ""
        TODate.text = ""
        } else {
        print("No Filter ")
        }
        if parsedData.result.isEmpty == false {
            dataTV.isHidden = false
        dataArray = parsedData.result
        dataTV.reloadWithAnimation()
        print("Got Appointment Details")
        } else {
            dataTV.isHidden = true
            notifyView.isHidden = false

        }
        } else {
        popUpAlert(title: "Alert", message: "Error in getting appointment details ", action: .alert)
        }
        } else {
        popUpAlert(title: "Alert", message: "Error in getting appointment details ", action: .alert)
        }
        } catch {
        popUpAlert(title: "Alert", message: "Error in getting appointment details ", action: .alert)
               print("Parse Error: \(error)")
        }
               
    }
           
           
}
extension FilterVC : UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
           return dataArray.count
    }
        
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! HomeTableViewCell
        let cellPath = dataArray[indexPath.row]
        
        if GlobalVariables.isDoctor == true {
            cell.nameLbl.text = cellPath.patient.userName!
        } else {
            if cellPath.specialist.userName == nil {
                cell.nameLbl.text = "Empty"
            } else {
             cell.nameLbl.text = cellPath.specialist.userName
            }
        }
        
        let dateStr = cellPath.dateOfAppointment.prefix(10)
        cell.dateLbl.text = "\(dateStr)"
        let timeStr = cellPath.startTimeOfAppointment.suffix(8)
        cell.timeLbl.text = "\(timeStr)"
        cell.IDLbl.text = "\(cellPath.id)"
        
        switch cellPath.currentStatus {
        case 0:
        cell.statusLbl.text = "Queued"
        cell.reasonLbl.text = "Reason :  \(cellPath.reasonForAppointment)"
        case 1:
        cell.statusLbl.text = "Accepted"
        cell.reasonLbl.text = "Reason for Appoinment:  \(cellPath.reasonForAppointment)"
        case 2:
        cell.statusLbl.text = "Declined"
        cell.reasonLbl.text = "Reason for Declined: \(cellPath.reasonForAppointment)"
        case 3:
        cell.statusLbl.text = "Cancelled"
        if cellPath.reasonForAppointment.isEmpty ==  true {
            cell.reasonLbl.text = "Empty"
        } else {
            cell.reasonLbl.text = "Reason for Cancelled:  \(cellPath.reasonForAppointment)"
        }
        
        default:
               break
        }
        cell.chatBtn.makeRound()
        cell.chatBtn.tag = indexPath.row
        cell.chatBtn.addTarget(self, action: #selector(chatBtnTapped(_:)), for: .touchUpInside)
        cell.profileIMGView.makeRound()
        cell.dataView.elevate(elevation: 3.0)
        cell.dataView.layer.cornerRadius = 10
        cell.dataView.layer.borderColor = UIColor.baseColor.cgColor
        cell.dataView.layer.borderWidth = 2.0
            return cell
        }
        
        
       @objc func chatBtnTapped(_ sender: UIButton) {
        print("tag = \(sender.tag)")
        let btnPosition = sender.convert(CGPoint(), to: dataTV)
        let indexPath = dataTV.indexPathForRow(at:btnPosition)
        let currentCell = dataTV.cellForRow(at: indexPath!) as! HomeTableViewCell
         print("Name = \(String(describing: currentCell.nameLbl.text!))")
        
         let VC = self.storyboard?.instantiateViewController(withIdentifier: "TextChatViewController") as! TextChatViewController
         self.navigationController?.pushViewController(VC, animated: true)
        
        }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
         let cell = tableView.cellForRow(at: indexPath as IndexPath) as! HomeTableViewCell
        
        GlobalVariables.appointmentID = cell.IDLbl.text!
        print("selected AppId = \(GlobalVariables.appointmentID)")
        if GlobalVariables.isDoctor == true {
            let story = UIStoryboard(name: "Specialist", bundle: nil)
        let VC = story.instantiateViewController(withIdentifier: "SPAppointmentDetailsVC") as! SPAppointmentDetailsVC
        self.navigationController?.pushViewController(VC, animated: true)
        } else {
            
        let VC = self.storyboard?.instantiateViewController(withIdentifier: "AppointmentDetailsVC") as! AppointmentDetailsVC
        self.navigationController?.pushViewController(VC, animated: true)
        }
               
    }
            
            
}
