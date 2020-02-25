//
//  MedicationTC.swift
//  One for Patient
//
//  Created by Idontknow on 30/01/20.
//  Copyright © 2020 AnnantaSourceLLc. All rights reserved.
//

import UIKit

class MedicationTC: UITableViewCell {

    
    @IBOutlet weak var titleLbl: UILabel!
    
    @IBOutlet weak var scheduleLbl: UILabel!
    
    
    @IBOutlet weak var deleteBtn: UIButton!
    @IBOutlet weak var MUnitLbl: UILabel!
    
    @IBOutlet weak var MStrengthLbl: UILabel!
    
    @IBOutlet weak var MTypeLbl: UILabel!
    @IBOutlet weak var dataView: UIView!
    @IBOutlet weak var IDLbl: UILabel!
   
    
    @IBOutlet weak var descriptionLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
