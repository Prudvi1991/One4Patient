//
//  HomeTableViewCell.swift
//  One for Patient
//
//  Created by Idontknow on 21/11/19.
//  Copyright © 2019 AnnantaSourceLLc. All rights reserved.
//

import UIKit

class HomeTableViewCell: UITableViewCell {
    
    @IBOutlet weak var profileIMGView: UIImageView!
    
    @IBOutlet weak var reasonLbl: UILabel!
    @IBOutlet weak var statusLbl: UILabel!
    @IBOutlet weak var dataView: UIView!
    @IBOutlet weak var chatBtn: UIButton!
    @IBOutlet weak var nameLbl: UILabel!
   
    @IBOutlet weak var dateLbl: UILabel!
    @IBOutlet weak var IDLbl: UILabel!
    
    
    @IBOutlet weak var timeLbl: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        statusLbl.makeRound()
    }

}
