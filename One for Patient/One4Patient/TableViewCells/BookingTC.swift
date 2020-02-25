//
//  BookingTC.swift
//  One for Patient
//
//  Created by Idontknow on 27/01/20.
//  Copyright © 2020 AnnantaSourceLLc. All rights reserved.
//

import UIKit

class BookingTC: UITableViewCell {
    
    
    @IBOutlet weak var userIDLbl: UILabel!
    @IBOutlet weak var relationLbl: UILabel!
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var userIMGView: UIImageView!
    
    
    @IBOutlet weak var dataView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        
    }

}
