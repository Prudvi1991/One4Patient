//
//  SpecialTableViewCell.swift
//  One for Patient
//
//  Created by Idontknow on 22/11/19.
//  Copyright © 2019 AnnantaSourceLLc. All rights reserved.
//

import UIKit

class SpecialTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var doctrImgView: UIImageView!
    
    @IBOutlet weak var dataView: UIView!
    
    @IBOutlet weak var IdLbl: UILabel!
    @IBOutlet weak var typeLbl: UILabel!
    @IBOutlet weak var degreeLbl: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
