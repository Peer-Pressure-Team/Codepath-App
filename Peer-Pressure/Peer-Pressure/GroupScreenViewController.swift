//
//  GroupScreenViewController.swift
//  Peer-Pressure
//
//  Created by Leonardo Valdivia on 5/29/21.
//

import UIKit
import Parse
import AlamofireImage

class GroupScreenViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{

    @IBOutlet weak var navBar: UINavigationItem!
    @IBOutlet weak var memberTableView: UITableView!
    
    var memberList = [PFObject]()
    var group = PFObject(className: "Group")
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.memberTableView.delegate = self
        self.memberTableView.dataSource = self
        
        navBar.title = group["groupName"] as? String
        
        memberList = group["members"] as! [PFObject]
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return memberList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == memberTableView {
            let cell = tableView.dequeueReusableCell(withIdentifier: "memberCell") as! memberCell
            
            let member = memberList[indexPath.row]
            try? member.fetch()
            
            cell.memberUsername.text = member["username"] as! String
            
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "memberCell") as! memberCell
            return cell
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "GroupSettingsSegue") {
            let groupTitle = group["groupName"] as! String
            
            let groupSettingsViewController = segue.destination as! GroupSettingsViewController

            groupSettingsViewController.groupTitle = groupTitle
        }
    }
    
}
