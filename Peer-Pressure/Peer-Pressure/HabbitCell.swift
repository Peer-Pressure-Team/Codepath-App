//
//  HabbitCell.swift
//  Peer-Pressure
//
//  Created by qiru hu on 5/17/21.
//

import UIKit

class HabbitCell: UITableViewCell {

    @IBOutlet weak var habbitLabel: UILabel!
    @IBOutlet weak var actualCount: UILabel!
    @IBOutlet weak var goalCount: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
