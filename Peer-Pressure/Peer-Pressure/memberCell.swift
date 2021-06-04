//
//  memberCell.swift
//  Peer-Pressure
//
//  Created by Leonardo Valdivia on 6/3/21.
//

import UIKit

class memberCell: UITableViewCell {

    @IBOutlet weak var memberPicture: UIImageView!
    @IBOutlet weak var memberUsername: UILabel!
    @IBOutlet weak var memberHabit: UILabel!
    @IBOutlet weak var memberProgress: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
