//
//  GroupViewController.swift
//  Peer-Pressure
//
//  Created by Leonardo Valdivia on 5/22/21.
//

import UIKit
import Parse
import AlamofireImage

class GroupViewController: UITableViewController {

    var groups = [PFObject]() 
    
    @IBOutlet var groupTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //circularImage.layer.masksToBounds = true
        //circularImage.layer.cornerRadius = circularImage.bounds.width / 2
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 0
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return groups.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "GroupCell") as! GroupCell
        
        let group = groups[indexPath.row]
        
        cell.groupName.text = group["groupName"] as! String
        
        cell.groupMemberCount.text = group["memberCount"] as? String
        
        let imageFile = group["image"] as! PFFileObject
        let urlString = imageFile.url!
        let url = URL(string: urlString)!
        
        cell.groupImage.af.setImage(withURL: url)
        
        return cell
    }
}
