//
//  StudioVC.swift
//  One for Patient
//
//  Created by Idontknow on 17/01/20.
//  Copyright © 2020 AnnantaSourceLLc. All rights reserved.
//

import UIKit

class StudioVC: UIViewController {

    @IBOutlet weak var uploadBtn: UIButton!
    
    @IBOutlet weak var publishBtn: UIButton!
    @IBOutlet weak var shareLbl: UILabel!
    
    @IBOutlet weak var uploadView: UIView!
    
    @IBOutlet weak var shareBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

       viewChanges()
    }
    

    func viewChanges() {
        uploadView.layer.cornerRadius = 10
        uploadBtn.layer.cornerRadius = 10
        publishBtn.layer.cornerRadius = 10
        shareLbl.makeRound()
        shareBtn.layer.cornerRadius = 10


    }

}
