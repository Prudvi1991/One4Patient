//
//  VideoChatVC.swift
//  One for Patient
//
//  Created by Idontknow on 25/11/19.
//  Copyright © 2019 AnnantaSourceLLc. All rights reserved.
//

import UIKit
import WebKit

class VideoChatVC: UIViewController {
    
    var webView = WKWebView()
    
   
      
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    
    override func viewWillAppear(_ animated: Bool) {
         print("Zoom Url = \(ZoomDetails.ZoomUrl)")
    }
   
    @IBAction func backBtn(_ sender: UIButton) {
        
        self.navigationController?.popViewController(animated: true)
        
    }
    
   
    
}

extension VideoChatVC: WKNavigationDelegate {
    func loadAddress() {
            
            let myUrl = URL(string: ZoomDetails.ZoomUrl)
            let myRequset = URLRequest(url: myUrl!)
            webView.load(myRequset)
            webView.allowsBackForwardNavigationGestures = true
   

            print("WebView:oaded Success")
            
            
        }
    
    
    
    
}
