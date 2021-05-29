//
//  FeedProfileViewController.swift
//  Peer-Pressure
//
//  Created by Adrian Lindell on 5/29/21.
//

import UIKit
import Parse

class FeedProfileViewController: UIViewController {
    @IBOutlet weak var profileImageView: UIImageView!
    
    @IBOutlet weak var usernameLabel: UILabel!
    
    
    
    
    @IBOutlet weak var myStackView: UIStackView!
    @IBOutlet weak var habitTableView: UITableView!
    @IBOutlet weak var groupTableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
