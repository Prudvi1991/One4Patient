//
//  SPHomeVC.swift
//  One for Patient
//
//  Created by Idontknow on 17/01/20.
//  Copyright © 2020 AnnantaSourceLLc. All rights reserved.
//

import UIKit

class SPHomeVC: UIViewController {
    
    
    @IBOutlet weak var typeSC: UISegmentedControl!
    @IBOutlet weak var dataTV: UITableView!
    
    @IBOutlet var notifyView: UIView!
    @IBOutlet weak var notifyLbl: UILabel!
    var dataArray:[AppointmentListResult] = []
    var sendQuery = "Today"
    

    override func viewDidLoad() {
        super.viewDidLoad()

    viewChanges()
    }
    
    func viewChanges() {
    dataTV.rowHeight = 100
    getData()
    showNotify()

    }
    func showNotify() {
        self.view.addSubview(notifyView)
        notifyView.center = self.view.center
        notifyView.isHidden = true
    }
    
    
    
    @IBAction func moreAxn(_ sender: UIButton) {
    GlobalVariables.isDoctor = true
    let story = UIStoryboard(name: "Main", bundle: nil)
    let VC = story.instantiateViewController(withIdentifier: "FilterVC") as! FilterVC
    self.navigationController?.pushViewController(VC, animated: true)
    }
    
    
    @IBAction func typeSCAxn(_ sender: UISegmentedControl) {
    if sender.selectedSegmentIndex == 1 {
    sendQuery = "Upcoming"
    getData()
    } else if sender.selectedSegmentIndex == 2 {
    sendQuery = "Past"
    getData()
    } else {
    sendQuery = "Today"
    getData()
    }
    }
    
   
    
    
    func getData() {
    if reach.isConnectedToNetwork() == true {
    notifyView.isHidden = true
    playLottie(fileName: "heartBeat")
    let  details = ["SpecialistUserId":GlobalVariables.accountID as Any, "CustomQuery":sendQuery as Any ] as [String:Any]
    ApiService.callPostToken(url: ClientInterface.appointmentListUrl, params: details, methodType: "POST", tag: "AppointmentList", finish:finishPost)
        print("Completeddetails = \(details)")
    } else {
    popUpAlert(title: "Alert", message: "Check Internet Connection", action: .alert)
    }
    
    }
    
    
    func finishPost (message:String, data:Data? , tag: String) -> Void {

    stopLottie()
    do {
    if let jsonData = data {
    let parsedData = try JSONDecoder().decode(AppointmentListResponse.self, from: jsonData)
          print(parsedData)
    if parsedData.statusCode == 200 {
            
    if parsedData.result.isEmpty == false {
        dataTV.isHidden = false
        dataArray = parsedData.result
        dataTV.reloadWithAnimation()
        print("Got Appointment Details")
        
    } else {
        dataTV.isHidden = true
        notifyView.isHidden = false
//        if typeSC.selectedSegmentIndex == 1 {
//        popUpAlert(title: "Alert", message: "No Upcoming's Appointment List", action: .alert)
//        } else if typeSC.selectedSegmentIndex == 2 {
//        popUpAlert(title: "Alert", message: "No Completed Appointment List", action: .alert)
//        } else {
//        popUpAlert(title: "Alert", message: "No Today's Appointment List", action: .alert)
//        }
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
extension SPHomeVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as!  SPHomeTC
        let cellPath = dataArray[indexPath.row]
        cell.nameLbl.text = cellPath.patient.userName!
        let date = cellPath.dateOfAppointment.prefix(10)
        cell.dateLbl.text = "\(date)"
        let time = cellPath.startTimeOfAppointment.suffix(8)
        cell.timeLbl.text = "\(time)"
        cell.IDLbl.text = "\(cellPath.id)"
        cell.dataView.layer.cornerRadius = 10
        cell.dataView.elevate(elevation: 3.0)
        cell.statusLbl.layer.cornerRadius = 10
        cell.appTypeLbl.text = "Appointment Type: \(cellPath.preferredModeOfContact)"
        cell.IMGView.makeRound()
        cell.contentView.layer.cornerRadius = 10
        cell.contentView.layer.borderWidth = 2.0
        cell.contentView.layer.borderColor = UIColor.baseColor.cgColor
        switch cellPath.currentStatus {
        case 0:
            cell.statusLbl.text = "Queued"
            cell.statusLbl.backgroundColor = .white

        case 1:
            cell.statusLbl.text = "Accepted"
            cell.statusLbl.backgroundColor = .systemGreen

        case 2:
            cell.statusLbl.text = "Declined"
            cell.statusLbl.backgroundColor = .systemRed

        case 3:
            cell.statusLbl.text = "Cancelled"
            cell.statusLbl.backgroundColor = .systemOrange

        case 4:
            cell.statusLbl.text = "Closed"
            cell.statusLbl.backgroundColor = .systemRed

        default:
            break
        }
         return cell
        
       
    }
    
    
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
         let cell = tableView.cellForRow(at: indexPath as IndexPath) as! SPHomeTC
        
        GlobalVariables.appointmentID = cell.IDLbl.text!
        print("selected AppId = \(GlobalVariables.appointmentID)")
        let VC = self.storyboard?.instantiateViewController(withIdentifier: "SPAppointmentDetailsVC") as! SPAppointmentDetailsVC
    self.navigationController?.pushViewController(VC, animated: true)
        
               
    }
    
    
    
    
    
    
}
