//
//  OffersTableViewCell.swift
//  HatleyOriginal
//
//  Created by Apple on 10/21/19.
//  Copyright © 2019 amirahmed. All rights reserved.
//

import UIKit
import Cosmos

class OffersTableViewCell: UITableViewCell {

    @IBOutlet weak var starImage: UIImageView!
    @IBOutlet weak var starName: UILabel!
    @IBOutlet weak var starRating: CosmosView!
    @IBOutlet weak var offerPrice: UILabel!
    @IBOutlet weak var offerTime: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
