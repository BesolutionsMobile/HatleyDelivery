//
//  GetOrdersTableViewCell.swift
//  HatleyOriginal
//
//  Created by Apple on 10/22/19.
//  Copyright © 2019 amirahmed. All rights reserved.
//

import UIKit
import Cosmos

class GetOrdersTableViewCell: UITableViewCell {

    @IBOutlet weak var expectedPriceView: UIView!
    @IBOutlet weak var orderDetailsView: UIView!
    
    @IBOutlet weak var orderExpectedPrice: UILabel!
    @IBOutlet weak var orderExpectedTime: UILabel!
    @IBOutlet weak var orderTitle: UILabel!
    @IBOutlet weak var orderFrom: UILabel!
    @IBOutlet weak var orderTo: UILabel!
    
    @IBOutlet weak var orderClientName: UILabel!
    @IBOutlet weak var orderClientRate: CosmosView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.expectedPriceView.layer.borderWidth = 1.0
        self.expectedPriceView.layer.borderColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
        self.expectedPriceView.layer.cornerRadius = 10.0
        
        self.orderDetailsView.layer.borderWidth = 1.0
        self.orderDetailsView.layer.borderColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
        self.orderDetailsView.layer.cornerRadius = 10.0
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
