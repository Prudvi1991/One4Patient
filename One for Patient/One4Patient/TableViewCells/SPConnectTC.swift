//
//  SPConnectTC.swift
//  One for Patient
//
//  Created by Idontknow on 17/01/20.
//  Copyright © 2020 AnnantaSourceLLc. All rights reserved.
//

import UIKit

class SPConnectTC: UITableViewCell {
    
    @IBOutlet weak var IDLbl: UILabel!
    
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var dataView: UIView!
    
    @IBOutlet weak var chatBtn: UIButton!
    @IBOutlet weak var IMGView: UIImageView!
    
    @IBOutlet weak var videoBtn: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
