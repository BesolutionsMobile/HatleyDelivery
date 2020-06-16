//
//  ClientNotificationsTableViewCell.swift
//  HatleyOriginal
//
//  Created by Apple on 10/24/19.
//  Copyright © 2019 amirahmed. All rights reserved.
//

import UIKit

class ClientNotificationsTableViewCell: UITableViewCell {

    @IBOutlet weak var notificationImage: UIImageView!
    @IBOutlet weak var notificationTitle: UILabel!
    @IBOutlet weak var notificationContent: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
