//
//  MainViewController.swift
//  One for Patient
//
//  Created by Idontknow on 10/11/19.
//  Copyright © 2019 AnnantaSourceLLc. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {

    @IBOutlet weak var contentViewLead: NSLayoutConstraint!
    
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var sideMenuLead: NSLayoutConstraint!
    
    @IBOutlet weak var sideMenuView: UIView!
    var menuVisible = false
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
     viewChanges()
    self.navigationController?.navigationBar.isHidden = true
    panGestureFunc()
    }
    func viewChanges() {
        if GlobalVariables.viewAppointments == true {
            self.tabBarController?.selectedIndex = 1
        } else {
            print("No selected INdex")
        }
    }
    
    
    func panGestureFunc() {
    let panGestureRecognizser = UIPanGestureRecognizer(target: self, action: #selector(handlePan(_:)) )
    view.addGestureRecognizer(panGestureRecognizser)
    self.navigationController?.isNavigationBarHidden = true
    sideMenuLead.constant = 0 - UIScreen.main.bounds.width
    }
    

    @IBAction func menuClick(_ sender: Any) {
          toggleSideMenu(fromViewController: self)
    }
    
//  Handling SideMenu by PanGesture
       @objc func toggleSideMenu(fromViewController: UIViewController) {
           if(menuVisible){
            UIView.animate(withDuration: 0.5, animations: {
            self.sideMenuLead.constant = 0 - self.sideMenuView.frame.size.width
            self.contentViewLead.constant = 0
            self.view.layoutIfNeeded()
            self.contentView.removeBlurEffect()
               })
           } else {
            self.view.layoutIfNeeded()
            UIView.animate(withDuration: 0.5, animations: {
                   // move the side menu to the right to show it
            self.sideMenuLead.constant = 0
                   // move the content view (tab bar controller) to the right
            self.contentViewLead.constant = self.sideMenuView.frame.size.width
            self.view.layoutIfNeeded()
            self.contentView.addBlurEffect()
               })
           }
           
           menuVisible = !menuVisible
       }

       // function to handle the pan gesture
       @objc func handlePan(_ recognizer: UIPanGestureRecognizer){
           // how much distance have user finger moved since touch start (in X and Y)
        let translation = recognizer.translation(in: self.view)
        // for demonstration purpose below, you can ignore this line
        print("panned x: \(translation.x), y: \(translation.y)")
        // when user lift up finger / end drag
        if(recognizer.state == .ended || recognizer.state == .failed || recognizer.state == .cancelled){
            if(menuVisible){
               // user finger moved to left before ending drag
            if(translation.x < 0){
                 // toggle side menu (to fully hide it)
            toggleSideMenu(fromViewController: self)
            }
            } else {
               // user finger moved to right and more than 100pt
            if(translation.x > 100.0){
                 // toggle side menu (to fully show it)
            toggleSideMenu(fromViewController: self)
            } else {
            // user finger moved to right but too less
            // hide back the side menu (with animation)
            view.layoutIfNeeded()
            UIView.animate(withDuration: 0.5, animations: {
            self.sideMenuLead.constant = 0 - self.sideMenuView.frame.size.width
            self.contentViewLead.constant = 0
            self.view.layoutIfNeeded()
            })
            }
            }
             return
           }
                 
       }
    
    
    
}
