//
//  EncountersListTC.swift
//  One for Patient
//
//  Created by AnnantaSource on 17/02/20.
//  Copyright © 2020 AnnantaSourceLLc. All rights reserved.
//

import UIKit

class EncountersListTC: UITableViewCell {
    
    
    @IBOutlet weak var patientNameLbl: UILabel!
    @IBOutlet weak var statusLbl: UILabel!
    
    @IBOutlet weak var SPNameLbl: UILabel!
    @IBOutlet weak var IDLbl: UILabel!
    @IBOutlet weak var titleLbl: UILabel!
    
    
    @IBOutlet weak var notesDetailsBtn: UIButton!
    @IBOutlet weak var chatDetailsBtn: UIButton!
    @IBOutlet weak var roomBtn: UIButton!
    
    @IBOutlet weak var dataView: UIView!
    
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
