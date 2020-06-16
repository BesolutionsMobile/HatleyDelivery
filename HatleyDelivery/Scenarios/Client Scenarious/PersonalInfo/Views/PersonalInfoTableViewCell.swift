//
//  PersonalInfoTableViewCell.swift
//  HatleyOriginal
//
//  Created by Apple on 11/5/19.
//  Copyright © 2019 amirahmed. All rights reserved.
//

import UIKit

class PersonalInfoTableViewCell: UITableViewCell {

    @IBOutlet weak var itemImage: UIImageView!
    @IBOutlet weak var itemName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
