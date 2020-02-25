//
//  SymptomsTC.swift
//  One for Patient
//
//  Created by Idontknow on 21/11/19.
//  Copyright © 2019 AnnantaSourceLLc. All rights reserved.
//

import UIKit

class SymptomsTC: UITableViewCell {
    
    @IBOutlet weak var dataView: UIView!
    
    @IBOutlet weak var nameLbl: UILabel!
    
    @IBOutlet weak var symID: UILabel!
    
    @IBOutlet weak var checkImg: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    override func prepareForReuse() {
        
//        checkImg.image = UIImage(named: "uncheck2")
    }

}
