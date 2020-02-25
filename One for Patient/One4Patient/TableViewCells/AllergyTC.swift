//
//  AllergyTC.swift
//  One for Patient
//
//  Created by Idontknow on 01/02/20.
//  Copyright © 2020 AnnantaSourceLLc. All rights reserved.
//

import UIKit

class AllergyTC: UITableViewCell {
    
    
    @IBOutlet weak var nameLbl: UILabel!
    
    @IBOutlet weak var timeTypeLbl: UILabel!
    @IBOutlet weak var dataView: UIView!
    
    @IBOutlet weak var severityLbl: UILabel!
    @IBOutlet weak var deleteBtn: UIButton!
    @IBOutlet weak var timeLbl: UILabel!
    @IBOutlet weak var IDLbl: UILabel!
    
    @IBOutlet weak var infoLbl: UILabel!
    @IBOutlet weak var allergyTypeLbl: UILabel!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

}
