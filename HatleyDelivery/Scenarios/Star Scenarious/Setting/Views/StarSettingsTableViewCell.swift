import UIKit

class StarSettingTableViewCell: UITableViewCell {

    
    
    @IBOutlet weak var listIcon: UIImageView!
    @IBOutlet weak var listName: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
