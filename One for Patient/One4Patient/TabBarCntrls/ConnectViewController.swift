//
//  ConnectViewController.swift
//  One for Patient
//
//  Created by Idontknow on 10/11/19.
//  Copyright © 2019 AnnantaSourceLLc. All rights reserved.
//

import UIKit

class ConnectViewController: UIViewController, UISearchResultsUpdating, UISearchBarDelegate {
    
    
    @IBOutlet weak var dataTV: UITableView!
  

        
    var searchController = UISearchController()
    let refreshControl = UIRefreshControl()
    var dataArray:[DoctorsListResult] = []
    var filteredArray = [String]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        viewChanges()
//        searchCntrl()
        
    }
   
    func viewChanges() {
    dataTV.rowHeight = 100
    dataTV.delegate = self
    dataTV.dataSource = self
    dataTV.sectionHeaderHeight = 40
    hideKeyboardWhenTappedAround()
    getData()
   
    }

    @IBAction func notifyBtn(_ sender: UIButton) {
    let VC = self.storyboard?.instantiateViewController(withIdentifier: "NotificationViewController") as! NotificationViewController
    self.navigationController?.pushViewController(VC, animated: true)
    }
    
    
   func updateSearchResults(for searchController: UISearchController) {
    if searchController.searchBar.text?.isEmpty == false {
    for names in dataArray {
        print("Searching")
        searchController.searchBar.text!.contains(names.userName)
        filteredArray.append(names.userName)
        print("filteredArray = \(filteredArray)")
        dataTV.reloadWithAnimation()
    }
    } else {
        print("No Searching")
    }
    }
    

    
    
    

    
//    func updateSearchResults(for searchController: UISearchController) {
//    filteredArray.removeAll(keepingCapacity: false)
//        _ = NSPredicate(format: "SELF CONTAINS[c] %@", searchController.searchBar.text!)
//    print("\(searchController.searchBar.text!)")
//        let predicateObj = NSPredicate(format: "self contains[c] %@", searchController.searchBar.text!)
//        for
//
//        filteredArray = dataArray.map ( ["status": $0.status, "correct": $0.correct, "chapter": $0.chapter]  )
//
//    self.dataTV.reloadWithAnimation()
//   }
    
   func searchCntrl() {
    searchController = UISearchController(searchResultsController: nil)
    dataTV.tableHeaderView = searchController.searchBar
    searchController.searchBar.showsCancelButton = true
    searchController.searchResultsUpdater = self
    searchController.searchBar.delegate = self
    searchController.obscuresBackgroundDuringPresentation = false
    definesPresentationContext = true
    searchController.searchBar.sizeToFit()
    refreshControl.addTarget(self, action: #selector(refresh), for: UIControl.Event.valueChanged)
    }
    @objc func refresh(){
        print("Refresh Completete")
        refreshControl.endRefreshing()
    }
    
    
    func getData()  {
    if reach.isConnectedToNetwork() == true {
    playLottie(fileName: "heartBeat")

    ApiService.callPostToken(url: ClientInterface.getAllSplListUrl, params: "", methodType: "GET", tag: "DoctorsList", finish:finishPost)
    print("All Doc List")
    
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
            dataArray = parsedData.result
//            dataTV.reloadWithType(type: .right)

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



extension ConnectViewController : UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
    return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searchController.isActive && searchController.searchBar.text != ""  {
            return filteredArray.count
            } else {
            return dataArray.count
        }
//    if section == 0 {
//        if searchController.isActive && searchController.searchBar.text != ""  {
//    return filter1.count
//    } else {
//    return doctrList1.count
//    }
//    } else {
//    if searchController.isActive && searchController.searchBar.text != "" {
//    return filter2.count
//    } else {
//    return doctrList2.count
//    }
//    }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! DoctorListCell
        let cellPath = dataArray[indexPath.row]
        if searchController.isActive == true  && searchController.searchBar.text != ""{
        cell.nameLbl.text = "Dr. \(filteredArray[indexPath.row])"
        } else {
            cell.nameLbl.text = "Dr. \(cellPath.userName)"
        }
        
//    if indexPath.section == 0 {
//    if searchController.isActive == true  && searchController.searchBar.text != ""{
//    cell.nameLbl.text = "Dr. \(filter1[indexPath.row])"
//    } else {
//    cell.nameLbl.text = "Dr. \(doctrList1[indexPath.row])"
//    }
//    } else {
//    if searchController.isActive == true && searchController.searchBar.text != "" {
//    cell.nameLbl.text = "Dr. \(filter2[indexPath.row])"
//    } else {
//    cell.nameLbl.text = "Dr. \(doctrList2[indexPath.row])"
//    }
//    }
        
//    if indexPath.section == 0{
//
//    cell.profileImgView.image = UIImage(named: "\(imgList1[indexPath.row])")
//    } else {
//    cell.typeLbl.text = hospitslList[indexPath.row]
//    cell.profileImgView.image = UIImage(named: "\(imgList2[indexPath.row])")
//    }
        if cellPath.profile.educations.isEmpty == false {
        cell.degreeLbl.text = cellPath.profile.educations.last?.title
        } else {
             cell.degreeLbl.text = "Empty"
        }
        if cellPath.profile.specializations.isEmpty == false {
        
            cell.specilatyLbl.text = cellPath.profile.specializations.last?.title
            } else {
                 cell.specilatyLbl.text = "Empty"
            }
        cell.IDLbl.text = "\(cellPath.id)"
        cell.profileImgView.makeRound()
        cell.videoBtn.makeRound()
        cell.chatBtn.makeRound()
        cell.videoBtn.tag  = indexPath.row
        cell.chatBtn.tag = indexPath.row
        cell.videoBtn.addTarget(self, action: #selector(onVideoButtontapped(_:)), for: UIControl.Event.touchUpInside)
        cell.chatBtn.addTarget(self, action: #selector(onChatButtontapped(_:)), for: UIControl.Event.touchUpInside)
        cell.dataView.elevate(elevation: 3.0)
        cell.dataView.layer.cornerRadius = 10
        return cell
    }
    
//    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
//    let headerView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.bounds.width, height: 40))
//    let label = UILabel(frame: CGRect(x: 15, y: 0, width: tableView.bounds.width - 30, height: 40))
//    label.font = UIFont(name: "OpenSans", size: 15.0)
//    label.textColor = UIColor.baseColor
//    headerView.addSubview(label)
//    if section == 0 {
//    label.text = "One4Patient"
//    } else {
//    label.text = "Other Hospitals"
//    }
//    return headerView
//    }
    
    

          
            
    @objc func onVideoButtontapped(_ sender:UIButton){
        let buttonPosition = sender.convert(CGPoint(), to:dataTV)
        let index = dataTV.indexPathForRow(at:buttonPosition)
       
        let currentCell = dataTV.cellForRow(at: index!) as! DoctorListCell
        print("Name = \(String(describing: currentCell.nameLbl.text!))")
        DoctorInfo.setDocName(type: currentCell.nameLbl.text!)
        print("getDoctor = \(DoctorInfo.getDocName())")

        print("Current call tag/index = \(sender.tag)" )
        if let IMGString:String = currentCell.profileImgView.image!.toString() {
            DoctorInfo.setDocImg(type: IMGString)
        } else {
            print("Unable to convert")
        }
        let VC = self.storyboard?.instantiateViewController(withIdentifier: "CallVC") as! CallVC
        self.navigationController?.pushViewController(VC, animated: true)
    }
    
    @objc func onChatButtontapped(_ sender:UIButton){
        let buttonPosition = sender.convert(CGPoint(), to:dataTV)
        let index = dataTV.indexPathForRow(at:buttonPosition)
        let currentCell = dataTV.cellForRow(at: index!) as! DoctorListCell
        print("Name = \(String(describing: currentCell.nameLbl.text!))")
        DoctorInfo.setDocName(type: currentCell.nameLbl.text!)
        print("getDoctor = \(DoctorInfo.getDocName())")
           print("Current chattag/index = \(sender.tag)" )
        if let IMGString:String = currentCell.profileImgView.image!.toString() {
            DoctorInfo.setDocImg(type: IMGString)
        } else {
            print("Unable to convert")
        }
        let VC = self.storyboard?.instantiateViewController(withIdentifier: "TextChatViewController") as! TextChatViewController
        self.navigationController?.pushViewController(VC, animated: true)
       }
}
