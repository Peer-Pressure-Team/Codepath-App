//
//  GroupScreenViewController.swift
//  Peer-Pressure
//
//  Created by Leonardo Valdivia on 5/29/21.
//

import UIKit
import Parse
import AlamofireImage

class GroupScreenViewController: UIViewController {

    
    @IBOutlet weak var navBar: UINavigationItem!
    
    var group = PFObject(className: "Group")
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navBar.title = group["groupName"] as? String
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "GroupSettingsSegue") {
            let groupTitle = group["groupName"] as! String
            
            let groupSettingsViewController = segue.destination as! GroupSettingsViewController

            groupSettingsViewController.groupTitle = groupTitle
        }
    }
    
}
