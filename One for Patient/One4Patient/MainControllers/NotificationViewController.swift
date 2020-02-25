//
//  NotificationViewController.swift
//  One for Patient
//
//  Created by Idontknow on 21/11/19.
//  Copyright © 2019 AnnantaSourceLLc. All rights reserved.
//

import UIKit

class NotificationViewController: UIViewController {

    @IBOutlet weak var backBtn: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    
    @IBAction func backBtnAct(_ sender: UIButton) {
        
    self.navigationController?.popViewController(animated: true)
        
    }
    
}

