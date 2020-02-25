//
//  HabitsTC.swift
//  One for Patient
//
//  Created by Idontknow on 01/02/20.
//  Copyright © 2020 AnnantaSourceLLc. All rights reserved.
//

import UIKit

class HabitsTC: UITableViewCell {
    
    @IBOutlet weak var dataView: UIView!
    
    @IBOutlet weak var IDLbl: UILabel!
    @IBOutlet weak var infoLbl: UILabel!
    @IBOutlet weak var timeTypeLbl: UILabel!
    @IBOutlet weak var delBtn: UIButton!
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var timeLbl: UILabel!
    
    @IBOutlet weak var habitTypeLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
