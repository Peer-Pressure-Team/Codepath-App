//
//  FeedCell.swift
//  Peer-Pressure
//
//  Created by Adrian Lindell on 5/15/21.
//

import UIKit

class FeedCell: UITableViewCell {
    
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var profileImageView: UIImageView!
    
    
    @IBAction func onReply(_ sender: Any) {
    }
    
    @IBAction func onLike(_ sender: Any) {
    }
    
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
