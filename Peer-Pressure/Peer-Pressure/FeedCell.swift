//
//  FeedCell.swift
//  Peer-Pressure
//
//  Created by Adrian Lindell on 5/15/21.
//

import UIKit
import Parse
import AlamofireImage

// do we want to have a number of likes (possibly doesn't save liked status) or how to store a certain user's likes?

class FeedCell: UITableViewCell {
    var isLiked:Bool = false
    var statusId:String = "id"
    
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var likeButton: UIButton!
    @IBOutlet weak var likesLabel: UILabel!
    
    @IBAction func onReply(_ sender: Any) {
    }
    
    @IBAction func onLike(_ sender: Any) {
        //query this status by objectId
        let query = PFQuery(className: "Status")
        query.getObjectInBackground(withId: statusId) { (thisStatus, error) in
            if thisStatus != nil {
                //object found. update likes
                if(!self.isLiked) {
                    //like
                    self.setLike(true)
                    let numLikes = thisStatus?["likesCount"] as! Int
                    thisStatus?["likesCount"] = numLikes + 1
                    
                    thisStatus?.saveInBackground { (success, error) in
                        if success {
                            print("Saved update")
                        } else {
                            print("Could not update: \(String(describing: error?.localizedDescription))")
                        }
                    }
                }
                else {
                    //unlike
                    self.setLike(false)
                    let numLikes = thisStatus?["likesCount"] as! Int
                    thisStatus?["likesCount"] = numLikes - 1
                    
                    thisStatus?.saveInBackground { (success, error) in
                        if success {
                            print("Saved update")
                        } else {
                            print("Could not update: \(String(describing: error?.localizedDescription))")
                        }
                    }
                }
                
            } else {
                //print error
                print("Could not find object: \(String(describing: error))")
            }
        }
    }
    
    func setLike(_ liked:Bool){
        isLiked = liked
        if(isLiked) {
            //set image to red if liked
            likeButton.setImage(UIImage(named:"favor-icon-red"), for: UIControl.State.normal)
        }
        else {
            //set image to gray if not liked
            likeButton.setImage(UIImage(named:"favor-icon"), for: UIControl.State.normal)
        }
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
