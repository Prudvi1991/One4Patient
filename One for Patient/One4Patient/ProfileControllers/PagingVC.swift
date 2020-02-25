//
//  PagingVC.swift
//  One for Patient
//
//  Created by Idontknow on 19/12/19.
//  Copyright © 2019 AnnantaSourceLLc. All rights reserved.
//

import UIKit


@objc public protocol CustomGestureDelegate {
  func gestureRecognizerShouldRecognizeSimultaneouslyWith(_ gestureRecognizer: UIGestureRecognizer, otherGestureRecognizer: UIGestureRecognizer) -> Bool
}
class PagingVC: UIViewController {
    
    @IBOutlet weak var profileCV: UIView!
    @IBOutlet weak var specializationCV: UIView!
    @IBOutlet weak var eduCV: UIView!
    var controllerArray : [UIViewController] = []

    @IBOutlet weak var typeSC: UISegmentedControl!
    open weak var gestureDelegate: CustomGestureDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
         viewChanges()

//        setupPages()
    }
    
    func viewChanges() {
        eduCV.isHidden = true
        specializationCV.isHidden = true
        profileCV.isHidden = false

    }
    
    @IBAction func backBtn(_ sender: UIButton) {
        if GlobalVariables.isDoctor == true {
            let story = UIStoryboard(name: "Specialist", bundle: nil)
            
        let VC = story.instantiateViewController(withIdentifier: "MainViewController") as! MainViewController
            self.navigationController?.pushViewController(VC, animated: true)
        } else {
        let VC = self.storyboard?.instantiateViewController(withIdentifier: "MainViewController") as! MainViewController
        self.navigationController?.pushViewController(VC, animated: true)
        }
    }
    
    @IBAction func typeSCAxn(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 1 {
            profileCV.isHidden = true
            specializationCV.isHidden = true
            eduCV.isHidden = false
        } else if sender.selectedSegmentIndex == 2 {
            profileCV.isHidden = true
            specializationCV.isHidden = false
            eduCV.isHidden = true
        } else {
            profileCV.isHidden = false
            specializationCV.isHidden = true
            eduCV.isHidden = true
        }
        
        
    }
    

    

    
    
}

