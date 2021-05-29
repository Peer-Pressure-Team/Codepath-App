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

    
    @IBAction func onBackButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    @IBOutlet weak var navBar: UINavigationItem!
    
    var group = PFObject(className: "Group")
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navBar.title = group["groupName"] as? String
    }
    
    

}
