//
//  MyOrdersTableViewCell.swift
//  HatleyOriginal
//
//  Created by Apple on 11/5/19.
//  Copyright © 2019 amirahmed. All rights reserved.
//

import UIKit
import Cosmos

class MyOrdersTableViewCell: UITableViewCell {

    @IBOutlet weak var fromLabel: UILabel!
    @IBOutlet weak var toLabel: UILabel!
    @IBOutlet weak var orderDate: UILabel!
    @IBOutlet weak var orderRating: CosmosView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
