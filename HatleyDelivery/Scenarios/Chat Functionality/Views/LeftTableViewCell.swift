//
//  LeftTableViewCell.swift
//  Firebase Chat Sample
//
//  Created by Apple on 12/13/18.
//  Copyright © 2018 amirahmed. All rights reserved.
//

import UIKit

class LeftTableViewCell: UITableViewCell {

    
    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var message: UILabel!
    @IBOutlet weak var time: UILabel!
    @IBOutlet weak var container: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        userImage.layer.masksToBounds = false
        userImage.layer.cornerRadius = userImage.frame.size.width / 2
        userImage.clipsToBounds = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
