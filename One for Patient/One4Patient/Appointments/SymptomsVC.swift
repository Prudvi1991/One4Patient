//
//  SymptomsVC.swift
//  One for Patient
//
//  Created by Idontknow on 21/11/19.
//  Copyright © 2019 AnnantaSourceLLc. All rights reserved.
//

import UIKit


class SymptomsVC: UIViewController {
    
    @IBOutlet weak var addView: UIView!
    @IBOutlet weak var symptomTF: UITextField!
    
    @IBOutlet weak var symptomCV: UICollectionView!
    @IBOutlet weak var addBtn: UIButton!
    @IBOutlet weak var userImgView: UIImageView!
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var userView: UIView!
    @IBOutlet weak var dataTV: UITableView!
    @IBOutlet weak var lastViewLbl: UILabel!
    @IBOutlet weak var IDLbl: UILabel!
    @IBOutlet weak var nextBtn: UIButton!
    
    @IBOutlet weak var sympView: UIView!
    var selectdIndex = [IndexPath]()
    var symptomsList: [Symptoms] = []
    var isTapped:Bool = false
    var addedSymptoms = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewchanges()
        getData()
        CVChanges()
       
    }
    func viewchanges() {
        userView.elevate(elevation: 5.0)
        userView.layer.cornerRadius = 10
        userImgView.makeRound()
        dataTV.delegate = self
        dataTV.dataSource  = self
        dataTV.rowHeight = 50
        userView.layer.cornerRadius = 10
        nextBtn.layer.cornerRadius = 10
       if BookingFor.isUserSelected == true {
            nameLbl.text = BookingFor.userName
            IDLbl.text = BookingFor.userEmail
        } else {
            nameLbl.text = GlobalVariables.userName
            IDLbl.text = GlobalVariables.userEmail
        }
        GlobalVariables.savedSymptoms.removeAll()
        addView.layer.cornerRadius = 5

    }
    
    func CVChanges() {
           let cellSize = CGSize(width:130 , height:25)
           let layout = UICollectionViewFlowLayout()
           layout.scrollDirection = .horizontal //.horizontal
           layout.itemSize = cellSize
           layout.sectionInset = UIEdgeInsets(top: 1, left: 5, bottom: 1, right: 1)
           layout.minimumLineSpacing = 5.0
               layout.minimumInteritemSpacing = 1.0
           symptomCV.setCollectionViewLayout(layout, animated: true)
           symptomCV.delegate = self
           symptomCV.dataSource = self
           symptomCV.reloadData()
       }
           
    
    func clearOnAppearance() {
    if let selectedIndexPath = dataTV.indexPathForSelectedRow {
        dataTV.deselectRow(at: selectedIndexPath, animated: true)
    }
    }
    
    @IBAction func backBtn(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    func getData() {
    if reach.isConnectedToNetwork() == true {
        playLottie(fileName: "heartBeat")

    ApiService.callPost(url: ClientInterface.symptomsListUrl, params: "", methodType: "GET", tag: "symptoms", finish:finishPost)
    } else {
    popUpAlert(title: "Alert", message: "Check Internet Connection", action: .alert)
    }
         
    }
    
    override func viewWillAppear(_ animated: Bool) {
       
        clearOnAppearance()
    }
    
    
    
    @IBAction func bookBtn(_ sender: UIButton) {
        if GlobalVariables.savedSymptoms.isEmpty == true {
        popUpAlert(title: "Alert", message: "select Symptoms", action: .alert)
        } else  {
        print("savedSymptoms = \(GlobalVariables.savedSymptoms)")
        let VC = self.storyboard?.instantiateViewController(withIdentifier: "SpecialistVC") as! SpecialistVC
        self.navigationController?.pushViewController(VC, animated: true)
        }
        
    }
    func finishPost (message:String, data:Data? , tag: String) -> Void {

        stopLottie()
        do {
        if let jsonData = data {
        let parsedData = try JSONDecoder().decode(SymptomsResult.self, from: jsonData)
        print(parsedData)
        if parsedData.StatusCode == 200 {
        self.symptomsList = parsedData.Result!
        self.dataTV.reloadWithAnimation()
        dataTV.fadeVisibleCells()
        } else {
        popUpAlert(title: "Alert", message: "Error in getting SymptomsList ", action: .alert)
        }
        } else {
            popUpAlert(title: "Alert", message: "Check Internet Connection", action: .alert)
        }
        } catch {
            popUpAlert(title: "Alert", message: "Error in getting SymptomsList ", action: .alert)

              print("Parse Error: \(error)")
          }
      }
    
    
    
    
    @IBAction func addSymBtn(_ sender: UIButton) {
        if symptomTF.text?.isEmpty == true {
            popUpAlert(title: "Alert", message: "Add Symptom", action: .alert)
        } else {
        GlobalVariables.addedSymptoms.append(symptomTF.text!)
            print("added Symptoms = \(GlobalVariables.addedSymptoms)")
            symptomCV.reloadData()
            symptomTF.text = ""
        }
    }
    
    
    
    
    
    
    
    
    

}
extension SymptomsVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return symptomsList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! SymptomsTC
        let cellItem = symptomsList[indexPath.row]
        print("cellItem = \(cellItem)")
        if GlobalVariables.savedSymptoms.isEmpty == false {
            if GlobalVariables.savedSymptoms.contains("\(cellItem.Id!)") == true {
        print("savedSymptoms = \(GlobalVariables.savedSymptoms)")
                print("cellItem = \(String(describing: cellItem.Id))")
        cell.checkImg.image = UIImage(named: "chk")
        } else {
        cell.checkImg.image = UIImage(named: "unchw")
        }
        }
        cell.nameLbl.text = cellItem.Name
        cell.symID.text = "\(cellItem.Id!)"
        cell.dataView.layer.cornerRadius = 10
        cell.dataView.elevate(elevation: 3.0)

        return cell 
    }
    
   func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    let cell = tableView.cellForRow(at: indexPath) as! SymptomsTC
        cell.checkImg.image = UIImage(named: "chk")
        let SelectedId = cell.symID.text!
//        savedSymptoms.append(SelectedId)
        GlobalVariables.savedSymptoms.append(SelectedId)
        print("Gsym = \(GlobalVariables.savedSymptoms)")
//        print("savedSymptoms =  \(savedSymptoms)")
        print("savedSymptomName = \(cell.nameLbl.text!)")
     
    

    }

    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {

        let cell = tableView.cellForRow(at: indexPath) as! SymptomsTC
        cell.checkImg.image = UIImage(named: "unchw")
        let unselectID = cell.symID.text!
        print("unselectId = \(unselectID)")
        print("unSavedSymptomName = \(cell.nameLbl.text!)")
        if GlobalVariables.savedSymptoms.contains(unselectID) == true {
        print("savedSymptoms = \(GlobalVariables.savedSymptoms)")
            GlobalVariables.savedSymptoms.filter { $0 != unselectID}
            print("FGsym = \(GlobalVariables.savedSymptoms)")
        GlobalVariables.savedSymptoms = GlobalVariables.savedSymptoms.filter { $0 != unselectID }
        print("filterSymptoms = \(GlobalVariables.savedSymptoms)")
        } else {
        print("No ID is matched")
        }
   }
        
    
    
   
    
   
}

extension SymptomsVC :  UICollectionViewDelegate , UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return GlobalVariables.addedSymptoms.count
        }
        
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! SymptomsCVC
            cell.contentView.backgroundColor = .baseColor
            cell.deleteBtn.makeRound()
            cell.layer.cornerRadius = 5
            cell.layer.borderColor = UIColor.black.cgColor
            cell.layer.borderWidth = 0.5
        
            cell.textLbl.text = GlobalVariables.addedSymptoms[indexPath.row]
            
            cell.deleteBtn.tag = indexPath.item
            cell.deleteBtn.addTarget(self, action: #selector(onBtnTapped(_:)), for: UIControl.Event.touchUpInside)
            
            return cell
    }
        
    @objc func onBtnTapped(_ sender: UIButton){
           print("tag = \(sender.tag)")
           let btnPosition = sender.convert(CGPoint(), to: symptomCV)
           let index = symptomCV.indexPathForItem(at: btnPosition)
    //        let indexPath = symptomsCV.indexPathForRow(at:btnPosition)
            
            let currentCell = symptomCV.cellForItem(at: index!) as! SymptomsCVC
            print("Name = \(String(describing: currentCell.textLbl.text!))")
        print("addedSymptoms = \(GlobalVariables.addedSymptoms)")
            GlobalVariables.addedSymptoms.remove(at: sender.tag)
        print("After Delete Sympt = \(GlobalVariables.addedSymptoms)")
            symptomCV.reloadData()
           
            
    }
        
        
        
        
}

   




