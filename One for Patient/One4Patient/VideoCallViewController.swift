//
//  VideoCallViewController.swift
//  One for Patient
//
//  Created by Idontknow on 26/10/19.
//  Copyright © 2019 AnnantaSourceLLc. All rights reserved.
//

import UIKit
import Sinch

@available(iOS 13.0, *)
class VideoCallViewController: UIViewController {
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.

    }
    
    func videoController() -> SINVideoController {

           return appDelegate._client.videoController()
    }
    
   
}
