//
//  SpecialityVC.swift
//  One for Patient
//
//  Created by Idontknow on 27/12/19.
//  Copyright © 2019 AnnantaSourceLLc. All rights reserved.
//

import UIKit



class SpecialityVC: UIViewController {
    
    var dataArray:[SpecialtyResult] = []
    
    @IBOutlet weak var dataTV: UITableView!
    
    @IBOutlet weak var profileView: UIView!
    
    @IBOutlet weak var lastVisitLbl: UILabel!
    @IBOutlet weak var userImgView: UIImageView!
    
    @IBOutlet weak var skipBtn: UIButton!
    @IBOutlet weak var userIDLbl: UILabel!
    @IBOutlet weak var userName: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        viewChanges()
        getData()
    }
    func viewChanges() {
        userImgView.makeRounded()
        profileView.layer.cornerRadius = 10
        profileView.elevate(elevation: 5.0)
        if BookingFor.isUserSelected == true {
            userName.text = BookingFor.userName
            userIDLbl.text = BookingFor.userEmail
        } else {
            userName.text = GlobalVariables.userName
            userIDLbl.text = GlobalVariables.userEmail
        }
        skipBtn.layer.cornerRadius = 10
        GlobalVariables.specialityID = ""
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        clearOnAppearance()
    }
    
    func clearOnAppearance() {
        GlobalVariables.specialityID = ""

        if let selectedIndexPath = dataTV.indexPathForSelectedRow {
            dataTV.deselectRow(at: selectedIndexPath, animated: true)
        }
    }
    
    func getData()  {
        if reach.isConnectedToNetwork() == true {
        playLottie(fileName: "heartBeat")
        ApiService.callPostToken(url: ClientInterface.getSpecialityUrl, params: "", methodType: "GET", tag: "Specilaty", finish:finishPost)
//        dataTV.rowHeight = 120
        } else {
        popUpAlert(title: "Alert", message: "Please Check Internet Connection", action: .alert)
        }
    }
    
    @IBAction func backAxn(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    func finishPost (message:String, data:Data? , tag: String) -> Void {

        stopLottie()
        do {
        if let jsonData = data {
                
        let parsedData = try JSONDecoder().decode(GetSpecilaityResponse.self, from: jsonData)
        print(parsedData)
        if parsedData.StatusCode == 200 {
        dataArray = parsedData.Result
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
    
    
    @IBAction func skipAxn(_ sender: UIButton) {
        GlobalVariables.specialityID = ""
        let VC = self.storyboard?.instantiateViewController(withIdentifier: "SymptomsVC") as! SymptomsVC
        self.navigationController?.pushViewController(VC, animated: true)
    }
    
    
    
}
extension SpecialityVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! SpecialityTC
        let cellItem = dataArray[indexPath.row]
        cell.specialityLbl.text = cellItem.Name!
        cell.descriptionLbl.text = cellItem.Description
        cell.IDLbl.text = "\(String(describing: cellItem.Id!))"
        print("ID = \(String(describing: cell.IDLbl.text))")
        cell.descriptionLbl.isHidden = true
        cell.dataView.layer.cornerRadius = 10
        cell.dataView.elevate(elevation: 3.0)
//        cell.expandBtn.addTarget(self, action: <#T##Selector#>, for: .touchUpInside)
        return cell
    }
    
    func onClickBtn(_ sender:UIButton) {
        sender.setImage(UIImage(named: "up"), for: .normal)
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! SpecialityTC
            GlobalVariables.specialityID =  "\(String(describing: cell.IDLbl.text!))"
        print("selectedspecialityID = \(String(describing: GlobalVariables.specialityID))")
        let VC = self.storyboard?.instantiateViewController(withIdentifier: "SymptomsVC") as! SymptomsVC
        self.navigationController?.pushViewController(VC, animated: true)
    }
    
    
    
    
    
}
