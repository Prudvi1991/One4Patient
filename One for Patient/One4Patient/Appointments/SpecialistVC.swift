//
//  SpecialistVC.swift
//  One for Patient
//
//  Created by Idontknow on 22/11/19.
//  Copyright © 2019 AnnantaSourceLLc. All rights reserved.
//

import UIKit



class SpecialistVC: UIViewController {
    
    @IBOutlet weak var profileView: UIView!
    
    @IBOutlet weak var dataTV: UITableView!
    @IBOutlet weak var userIMGView: UIImageView!
    @IBOutlet weak var nameLbl: UILabel!
    
    @IBOutlet weak var visitLbl: UILabel!
    @IBOutlet weak var IDLbl: UILabel!
    
    var ischecked:Bool = false
    var doctrListArr = ["Hina Sharma","Jingle Cabansy","Mina Abdulla","Emma Watson"]
    var degreeArr = ["M.D","M.S","M.S", "PharmD BCPS"]
    var imageArr = ["doctor1","doctor2","doctor3","doctor1"]
    var hospitalArr = ["One4Patient","One4Patient","Apollo","Govt Hospital"]
    var dataArray:[DoctorsListResult] = []
    var selectedDoc = [String]()
    override func viewDidLoad() {
        super.viewDidLoad()

       viewChanges()
        getData()
        print("GSym = \(GlobalVariables.savedSymptoms)")
    }
    
    func viewChanges() {
    profileView.elevate(elevation: 5.0)
    profileView.layer.cornerRadius = 10
        userIMGView.makeRound()
        dataTV.delegate = self
        dataTV.dataSource = self
        dataTV.rowHeight = 80
        dataTV.reloadWithAnimation()
       if BookingFor.isUserSelected == true {
            nameLbl.text = BookingFor.userName
            IDLbl.text = BookingFor.userEmail
        } else {
            nameLbl.text = GlobalVariables.userName
            IDLbl.text = GlobalVariables.userEmail
        }
        
    }
     
    override func viewWillAppear(_ animated: Bool) {
        clearOnAppearance()
    }
    
    
    func clearOnAppearance() {
    if let selectedIndexPath = dataTV.indexPathForSelectedRow {
        dataTV.deselectRow(at: selectedIndexPath, animated: true)
    }
    }
    
    
    
    @IBAction func backBtn(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    func getData()  {
        if reach.isConnectedToNetwork() == true {
        playLottie(fileName: "heartBeat")
        if GlobalVariables.specialityID.isEmpty == false {
            
        ApiService.callPostToken(url: ClientInterface.getSplbySpltyUrl, params: "", methodType: "GET", tag: "SplDocbySpeiality", finish:finishPost)
            print("Speiality Doc")
        } else {
        ApiService.callPostToken(url: ClientInterface.getAllSplListUrl, params: "", methodType: "GET", tag: "SplDoc", finish:finishPost)
            print("All Doc List")
        }
        } else {
            popUpAlert(title: "Alert", message: "Check Internet Connecion", action: .alert)
            
        }
    }
    
    
    
    func finishPost (message:String, data:Data? , tag: String) -> Void {
        stopLottie()

        do {
        if let jsonData = data
        {
        let parsedData = try JSONDecoder().decode(DoctorsListResponse.self, from: jsonData)
                print(parsedData)
                
        if parsedData.statusCode == 200 {
        dataArray = parsedData.result
        self.dataTV.reloadWithAnimation()
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
extension SpecialistVC : UITableViewDelegate , UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! SpecialTableViewCell
        let cellItem = dataArray[indexPath.row]
        cell.nameLbl.text = "Dr. \(cellItem.userName)"
//        cell.degreeLbl.text = degreeArr[indexPath.row]
//        cell.typeLbl.text = hospitalArr[indexPath.row]
//        cell.doctrImgView.image = UIImage(named: "\(imageArr[indexPath.row])")
        cell.doctrImgView.makeRound()
        cell.IdLbl.text = "\(cellItem.id)"
        if cellItem.profile.educations.isEmpty == false {
        cell.degreeLbl.text = cellItem.profile.educations.last?.title
        } else {
            cell.degreeLbl.text = "Empty"
        }
        if cellItem.profile.specializations.isEmpty == false {
        cell.typeLbl.text = cellItem.profile.specializations.last?.title
        } else {
            cell.typeLbl.text = "Empty"
        }
        
        cell.contentView.elevate(elevation: 3.0)
//        cell.checkBtn.addTarget(self, action: #selector(checkAction(_:)), for: .touchUpInside)
//        cell.dataView.layer.cornerRadius = 10
        cell.dataView.layer.cornerRadius = 10
        cell.dataView.elevate(elevation: 3.0)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
     let cell = tableView.cellForRow(at: indexPath as IndexPath) as! SpecialTableViewCell
        
        cell.accessoryType = .checkmark
        GlobalVariables.specialistID = cell.IdLbl.text!
        let VC = self.storyboard?.instantiateViewController(withIdentifier: "ScheduleAppVC") as! ScheduleAppVC
        self.navigationController?.pushViewController(VC, animated: true)
        selectedDoc.append(cell.nameLbl.text!)
        print("selectedDoc =  \(selectedDoc)")
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
       let cell = tableView.cellForRow(at: indexPath as IndexPath) as! SpecialTableViewCell
        cell.accessoryType = .none
        for (index,value) in selectedDoc.enumerated() {
        if value == cell.nameLbl.text {
        selectedDoc.remove(at:index)
        print("selectedDoc =  \(selectedDoc)")
        }
        }
    }
    
    
   @objc func checkAction(_ sender: UIButton) {
      if(ischecked == false) {
       sender.setImage(UIImage(named: "check"), for: .normal)
      } else {
      sender.setImage(UIImage(named: "uncheck2"), for: .normal)
      }
      ischecked = !ischecked
      }
    
    
    
    
}
