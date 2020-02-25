//
//  SpecializationTC.swift
//  One for Patient
//
//  Created by Idontknow on 20/12/19.
//  Copyright © 2019 AnnantaSourceLLc. All rights reserved.
//

import UIKit

class SpecializationTC: UITableViewCell {

    @IBOutlet weak var dataView: UIView!
    
    @IBOutlet weak var fromLbl: UILabel!
    
    @IBOutlet weak var TOLbl: UILabel!
    
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var gradeLbl: UILabel!
    
    @IBOutlet weak var delBtn: UIButton!
    @IBOutlet weak var universityLbl: UILabel!
    @IBOutlet weak var collegeLbl: UILabel!
    @IBOutlet weak var studyLbl: UILabel!
    
    @IBOutlet weak var dateView: UIView!
    @IBOutlet weak var gradeView: UIView!
    @IBOutlet weak var eduIDLbl: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        eduIDLbl.isHidden = true
       


    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
