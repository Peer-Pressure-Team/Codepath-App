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
    @IBOutlet weak var userPicture: UIImageView!
    @IBOutlet weak var username: UILabel!
    
    var memberList = [PFObject]()
    var group = PFObject(className: "Group")
    var habit: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.memberTableView.delegate = self
        self.memberTableView.dataSource = self
        
        navBar.title = group["groupName"] as? String
        
        memberList = group["members"] as! [PFObject]
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let user = PFUser.current()!
        
        username.text = user.username
        let imageFile = user["image"] as! PFFileObject
        let urlString = imageFile.url!
        let url = URL(string: urlString)!
        userPicture.af.setImage(withURL: url)
        userPicture.layer.borderWidth = 1
        userPicture.layer.masksToBounds = false
        userPicture.layer.borderColor = UIColor.clear.cgColor
        userPicture.layer.cornerRadius = userPicture.frame.height/2
        userPicture.clipsToBounds = true
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return memberList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == memberTableView {
            let cell = tableView.dequeueReusableCell(withIdentifier: "memberCell") as! memberCell
            
            let member = memberList[indexPath.row]
            try? member.fetch()
            

            cell.memberUsername.text = member["username"] as? String
            cell.memberHabit.text = habit
            
            let imageFile = member["image"] as! PFFileObject
            let urlString = imageFile.url!
            let url = URL(string: urlString)!
            cell.memberPicture.af.setImage(withURL: url)
            
            cell.memberPicture.layer.borderWidth = 1
            cell.memberPicture.layer.masksToBounds = false
            cell.memberPicture.layer.borderColor = UIColor.clear.cgColor
            cell.memberPicture.layer.cornerRadius = cell.memberPicture.frame.height/2
            cell.memberPicture.clipsToBounds = true
            
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
