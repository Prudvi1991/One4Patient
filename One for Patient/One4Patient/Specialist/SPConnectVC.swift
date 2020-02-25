//
//  SPConnectVC.swift
//  One for Patient
//
//  Created by Idontknow on 17/01/20.
//  Copyright © 2020 AnnantaSourceLLc. All rights reserved.
//

import UIKit

class SPConnectVC: UIViewController {
    
    @IBOutlet weak var dataTV: UITableView!
    
    var nameList = ["Patient1","Patient2"]
    var IDList = ["1", "2"]
    var dataArray:[PatientListResult] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        viewChanges()
     
    }
    
    func viewChanges() {
    dataTV.rowHeight = 80
    getData()
    }
    
    func getData() {
    if reach.isConnectedToNetwork() == true {
    playLottie(fileName: "heartBeat")
    ApiService.callPostToken(url: ClientInterface.getPatientsListUrl, params: "", methodType: "GET", tag: "UserList", finish:finishPost)
    } else {
    popUpAlert(title: "Alert", message: "Check Internet Connection", action: .alert)
    }
       
    }
       
       
    func finishPost (message:String, data:Data? , tag: String) -> Void {

    stopLottie()
        
    do {
    if let jsonData = data {
    let parsedData = try JSONDecoder().decode(PatientListResponse.self, from: jsonData)
             print(parsedData)
    if parsedData.statusCode == 200 {
        
    if parsedData.result.isEmpty == false {
    dataTV.isHidden = false
    dataArray = parsedData.result
    dataTV.reloadWithAnimation()
    print("Got User's List Details")
            
    } else {
    popUpAlert(title: "Alert", message: "No Patient's List", action: .alert)
    }
               
    } else {
    popUpAlert(title: "Alert", message: "Error in getting User's List ", action: .alert)
    }
        
    } else {
    popUpAlert(title: "Alert", message: "Error in getting User's List ", action: .alert)
    }
    
    } catch {
    popUpAlert(title: "Alert", message: "Error in getting User's List ", action: .alert)
             print("Parse Error: \(error)")
    }
             
    }
    

    
}
extension SPConnectVC : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return dataArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! SPConnectTC
    let cellPath = dataArray[indexPath.row]
    cell.nameLbl.text = cellPath.userName
    cell.IDLbl.text = "\(cellPath.id)"
    cell.IMGView.makeRound()
    cell.videoBtn.tag  = indexPath.row
    cell.chatBtn.tag = indexPath.row
    cell.videoBtn.addTarget(self, action: #selector(onVideoButtontapped(_:)), for: UIControl.Event.touchUpInside)
    cell.chatBtn.addTarget(self, action: #selector(onChatButtontapped(_:)), for: UIControl.Event.touchUpInside)
    cell.dataView.elevate(elevation: 3.0)
    cell.dataView.layer.cornerRadius = 10
    return cell
    }
    
    @objc func onVideoButtontapped(_ sender:UIButton){
    let buttonPosition = sender.convert(CGPoint(), to:dataTV)
    let index = dataTV.indexPathForRow(at:buttonPosition)
         
    let currentCell = dataTV.cellForRow(at: index!) as! SPConnectTC
    print("Name = \(String(describing: currentCell.nameLbl.text!))")
    DoctorInfo.setDocName(type: currentCell.nameLbl.text!)
    print("getDoctor = \(DoctorInfo.getDocName())")
    print("Current call tag/index = \(sender.tag)" )
        
    if let IMGString:String = currentCell.IMGView.image!.toString() {
              DoctorInfo.setDocImg(type: IMGString)
    } else {
    print("Unable to convert")
    }
        
    let story = UIStoryboard(name: "Main", bundle: nil)
    let VC = story.instantiateViewController(withIdentifier: "CallVC") as! CallVC
    self.navigationController?.pushViewController(VC, animated: true)
    }
      
    @objc func onChatButtontapped(_ sender:UIButton){
    let buttonPosition = sender.convert(CGPoint(), to:dataTV)
    let index = dataTV.indexPathForRow(at:buttonPosition)
    let currentCell = dataTV.cellForRow(at: index!) as! SPConnectTC
    print("Name = \(String(describing: currentCell.nameLbl.text!))")
    DoctorInfo.setDocName(type: currentCell.nameLbl.text!)
    print("getDoctor = \(DoctorInfo.getDocName())")
    print("Current chattag/index = \(sender.tag)" )
    if let IMGString:String = currentCell.IMGView.image!.toString() {
    DoctorInfo.setDocImg(type: IMGString)
    } else {
    print("Unable to convert")
    }
    let story = UIStoryboard(name: "Main", bundle: nil)
    let VC = story.instantiateViewController(withIdentifier: "TextChatViewController") as! TextChatViewController
    self.navigationController?.pushViewController(VC, animated: true)
         
    }
    
    
    
    
    
    
}

