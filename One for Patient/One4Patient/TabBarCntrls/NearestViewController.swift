//
//  NearestViewController.swift
//  One for Patient
//
//  Created by Idontknow on 10/11/19.
//  Copyright © 2019 AnnantaSourceLLc. All rights reserved.
//

import UIKit

class NearestViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func notifyBtnAct(_ sender: UIButton) {
    let VC = self.storyboard?.instantiateViewController(withIdentifier: "NotificationViewController") as! NotificationViewController
        
  self.navigationController?.pushViewController(VC, animated: true)
    }
    

    
    
}
