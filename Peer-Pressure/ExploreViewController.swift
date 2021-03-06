import UIKit
import Parse
import Alamofire

class ExploreViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var groups = [PFObject]()
    
    @IBOutlet weak var groupTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        groupTableView.delegate = self
        groupTableView.dataSource = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        let query = PFQuery(className: "Group")
        query.whereKey("members", notEqualTo: PFUser.current())
        query.limit = 20
        
        query.findObjectsInBackground { (groups, error) in
            if groups != nil {
                self.groups = groups!
                print("This")
                self.groupTableView.reloadData()
            }
        }
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == groupTableView {
            return groups.count
        }
        else {
            return 5
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "GroupCell") as! GroupCell
        
        let group = groups[indexPath.row]
        var toHabit = group["habitPointer"] as! PFObject
        let firstQuery = PFQuery(className: "GroupHabit")

        let groupHabit = try? firstQuery.getObjectWithId(toHabit.objectId!)
        
        
        cell.groupName.text = (group["groupName"] as! String)
        cell.groupMemberCount.text! = "Group Members: \(group["memberCount"] ?? "" )"
        cell.groupGoal.text = groupHabit?["habitName"] as? String
        let imageFile = group["image"] as! PFFileObject
        let urlString = imageFile.url!
        let url = URL(string: urlString)!
        
        cell.groupImage.af.setImage(withURL: url)
        
        cell.groupImage.layer.borderWidth = 1
        cell.groupImage.layer.masksToBounds = false
        cell.groupImage.layer.borderColor = UIColor.clear.cgColor
        cell.groupImage.layer.cornerRadius = cell.groupImage.frame.height/2
        cell.groupImage.clipsToBounds = true
        
        cell.joinButton.addTarget(self, action: #selector(joined(sender:)), for: .touchUpInside)
        cell.joinButton.target(forAction: #selector(joined(sender:)), withSender: self)
        cell.joinButton.tag = indexPath.row
        
        return cell
        
    }
    
    @objc func joined(sender: UIButton!) {
       
        let joinedGroup = groups[Int(sender.tag)]
        joinedGroup.add(PFUser.current(), forKey: "members")
        var memCount = joinedGroup["memberCount"] as! Int
        memCount += 1
        joinedGroup["memberCount"] = memCount
        
        let toHabit = joinedGroup["habitPointer"] as! PFObject
        let firstQuery = PFQuery(className: "GroupHabit")
        let groupHabit = try? firstQuery.getObjectWithId(toHabit.objectId!)
        
        let newHabit = PFObject(className: "Habit")
        newHabit["username"] = PFUser.current()?.username
        newHabit["habitName"] = groupHabit?["habitName"]
        newHabit["period"] = "Weekly"
        newHabit["goalCount"] = 3
        newHabit["groupPointer"] = joinedGroup
      
        joinedGroup.saveInBackground()
        newHabit.saveInBackground { (success, error) in
            if success {
                print("habit saved")
            } else {
                print("error saving habit")
            }
        }
        
    }
}
