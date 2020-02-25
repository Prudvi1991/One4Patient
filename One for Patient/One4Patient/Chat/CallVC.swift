//
//  CallVC.swift
//  One for Patient
//
//  Created by Idontknow on 25/11/19.
//  Copyright © 2019 AnnantaSourceLLc. All rights reserved.
//

import UIKit

class CallVC: UIViewController {

    @IBOutlet weak var nameLbl: UILabel!
    
    @IBOutlet weak var IMGView: UIImageView!
    @IBOutlet weak var endBtn: UIButton!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

       viewChanges()
    }
    func viewChanges() {
        IMGView.makeRound()
        nameLbl.text = DoctorInfo.getDocName()
        if let Image = DoctorInfo.getDocImg().toImage() {
            IMGView.image = Image
        } else {
            print("Unable to convet")
        }
        self.view.backgroundColor = .baseColor
    }
    

    @IBAction func backBtnAxn(_ sender: UIButton) {
        
  self.navigationController?.popViewController(animated: true)
        
    }
    
}
