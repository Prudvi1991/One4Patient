//
//  SlidesViewController.swift
//  One for Patient
//
//  Created by Idontknow on 28/11/19.
//  Copyright © 2019 AnnantaSourceLLc. All rights reserved.
//

import UIKit

class SlidesViewController: UIViewController, UIScrollViewDelegate {
    
    
    
    @IBOutlet weak var txtLbl: UILabel!
    @IBOutlet weak var subView: UIView!
    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var scrollView: UIScrollView!
    
    var titleArray = ["Doctors","Prescriptions","Appointments"]
    var contentArray = ["Find expert Doctors for a particular problem on one tap","All prescriptions medicines can bought from here on One tap","Book appointments and  get best treatment on One tap"]
    
        override func viewDidLoad() {
            super.viewDidLoad()
            
            startButton.layer.cornerRadius = 10
           
            self.navigationController?.navigationBar.isHidden = true
            
            
            
    }

       
    @IBAction func startBtnAxn(_ sender: UIButton) {
          let VC = self.storyboard?.instantiateViewController(withIdentifier: "LoginVC") as! LoginVC
            self.navigationController?.pushViewController(VC, animated: true)
    }
    @objc func moveToNextPage (){
            
            let pageWidth:CGFloat = self.scrollView.frame.width
            let maxWidth:CGFloat = pageWidth * 3
            let contentOffset:CGFloat = self.scrollView.contentOffset.x
            
            var slideToX = contentOffset + pageWidth
            
            if  contentOffset + pageWidth == maxWidth
            {
                slideToX = 0
            }
            self.scrollView.scrollRectToVisible(CGRect(x:slideToX, y:0, width:pageWidth, height:self.scrollView.frame.height), animated: true)
        }
    
    
    func scrollEffect() {
        
        
        
         self.scrollView.frame = CGRect(x:0, y:0, width:self.view.frame.width, height:self.view.frame.height)
         let scrollViewWidth:CGFloat = self.scrollView.frame.width
         let scrollViewHeight:CGFloat = self.scrollView.frame.height
         
         txtLbl.text = contentArray[0]
         nameLbl.text = titleArray[0]
         txtLbl.textAlignment = .center
         txtLbl.textColor = UIColor.black
         self.startButton.layer.cornerRadius = 4.0
         
         let imgOne = UIImageView(frame: CGRect(x:0, y:0,width:scrollViewWidth, height:scrollViewHeight))
         imgOne.image = UIImage(named: "slide1")
         let imgTwo = UIImageView(frame: CGRect(x:scrollViewWidth, y:0,width:scrollViewWidth, height:scrollViewHeight))
         imgTwo.image = UIImage(named: "slide2")
         let imgThree = UIImageView(frame: CGRect(x:scrollViewWidth*2, y:0,width:scrollViewWidth, height:scrollViewHeight))
         imgThree.image = UIImage(named: "slide3")
        
         
         self.scrollView.addSubview(imgOne)
         self.scrollView.addSubview(imgTwo)
         self.scrollView.addSubview(imgThree)
         
         self.scrollView.contentSize = CGSize(width:self.scrollView.frame.width * 3, height:self.scrollView.frame.height)
         self.scrollView.delegate = self
         self.pageControl.currentPage = 0
         
         Timer.scheduledTimer(timeInterval: 2, target: self, selector: #selector(moveToNextPage), userInfo: nil, repeats: true)
    }
    
    
    
    
    
    
    
    
}
    private typealias ScrollView = SlidesViewController
    extension ScrollView
    {
        func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView){
            // Test the offset and calculate the current page after scrolling ends
            let pageWidth:CGFloat = scrollView.frame.width
            let currentPage:CGFloat = floor((scrollView.contentOffset.x-pageWidth/2)/pageWidth)+1
            // Change the indicator
            self.pageControl.currentPage = Int(currentPage);
            // Change the text accordingly
            if Int(currentPage) == 0{
                  txtLbl.text = contentArray[0]
                nameLbl.text = titleArray[0]
            }else if Int(currentPage) == 1{
                  txtLbl.text = contentArray[1]
                  nameLbl.text = titleArray[1]
            }else {
            txtLbl.text = contentArray[2]
                          nameLbl.text = titleArray[2]
                // Show the "Let's Start" button in the last slide (with a fade in animation)
                UIView.animate(withDuration: 1.0, animations: { () -> Void in
                    self.startButton.alpha = 1.0
                    self.startButton.layer.cornerRadius = 10
                })
            }
        }
    }
