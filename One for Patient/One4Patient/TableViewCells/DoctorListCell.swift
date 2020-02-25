//
//  DoctorListCell.swift
//  One for Patient
//
//  Created by Idontknow on 23/11/19.
//  Copyright © 2019 AnnantaSourceLLc. All rights reserved.
//

import UIKit

class DoctorListCell: UITableViewCell {

    
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var IDLbl: UILabel!
    
    @IBOutlet weak var degreeLbl: UILabel!
    
    @IBOutlet weak var typeLbl: UILabel!
    
    @IBOutlet weak var videoBtn: UIButton!
    
    @IBOutlet weak var chatBtn: UIButton!
    
    @IBOutlet weak var profileImgView: UIImageView!
    
    @IBOutlet weak var dataView: UIView!
    
    @IBOutlet weak var specilatyLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
