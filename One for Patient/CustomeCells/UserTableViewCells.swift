//
//  UserTableViewCell.swift
//  iChat
//
//  Created by David Kababyan on 10/06/2018.
//  Copyright © 2018 David Kababyan. All rights reserved.
//

import UIKit


protocol UserTableViewCellDelegate {
    func didTapAvatarImage(indexPath: IndexPath)
}


class UserTableViewCells: UITableViewCell {

    
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var fullNameLabel: UILabel!
    
    var indexPath: IndexPath!
    var delegate: UserTableViewCellDelegate?
    
    
    let tapGestureRecognizer = UITapGestureRecognizer()
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        tapGestureRecognizer.addTarget(self, action: #selector(self.avatarTap))
        avatarImageView.isUserInteractionEnabled = true
        avatarImageView.addGestureRecognizer(tapGestureRecognizer)

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    

    
    
    
    
    @objc func avatarTap() {
        delegate!.didTapAvatarImage(indexPath: indexPath)
    }
    

}
