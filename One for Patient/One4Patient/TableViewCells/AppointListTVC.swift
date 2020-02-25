//
//  AppointListTVC.swift
//  One for Patient
//
//  Created by Idontknow on 23/11/19.
//  Copyright © 2019 AnnantaSourceLLc. All rights reserved.
//

import UIKit

class AppointListTVC: UITableViewCell {
    
    
    @IBOutlet weak var dataView: UIView!
    @IBOutlet weak var statusLbl: UILabel!
    @IBOutlet weak var ImgView: UIImageView!
    @IBOutlet weak var timeLbl: UILabel!
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var degreeLbl: UILabel!
    @IBOutlet weak var docTypeLbl: UILabel!
    @IBOutlet weak var dateLbl: UILabel!
    
    @IBOutlet weak var appID: UILabel!
    @IBOutlet weak var appTypeLbl: UILabel!
    
    @IBOutlet weak var displayIDLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        ImgView.makeRound()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

}
