//
//  SpecialityTC.swift
//  One for Patient
//
//  Created by Idontknow on 27/12/19.
//  Copyright © 2019 AnnantaSourceLLc. All rights reserved.
//

import UIKit

class SpecialityTC: UITableViewCell {
    
    var isExpanded:Bool = false
    @IBOutlet weak var descriptionLbl: UILabel!
    @IBOutlet weak var specialityLbl: UILabel!
    
    @IBOutlet weak var IDLbl: UILabel!
    @IBOutlet weak var expandBtn: UIButton!
    
    @IBOutlet weak var dataView: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        
//        descriptionLbl.isHidden = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func expandBtn(_ sender: UIButton) {
        if isExpanded == false {
            
        isExpanded = true
        sender.setImage(UIImage(named: "up"), for: .normal)
        descriptionLbl.isHidden = false
        } else {
            sender.setImage(UIImage(named: "down"), for: .normal)
            descriptionLbl.isHidden = true
            isExpanded = false
        }
//        isExpanded != isExpanded
    }
    
    
    

}
