import UIKit
import Parse
import AlamofireImage

class GroupViewController: UITableViewController {

    var groups = [PFObject]()
    
    @IBOutlet var groupTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        groupTableView.delegate = self
        groupTableView.dataSource = self
        
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        let query = PFQuery(className: "Group")
        query.whereKey("members", equalTo: PFUser.current())
        query.limit = 20
        
        query.findObjectsInBackground { (groups, error) in
            if groups != nil {
                self.groups = groups!
                print(groups as Any)
                self.groupTableView.reloadData()
            } else {
                print(error?.localizedDescription as Any)
            }
        }
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if tableView == groupTableView {
            return groups.count
        }
        else {
            return 5
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "GroupCell") as! GroupCell
        
        let group = groups[indexPath.row]
        var toHabit = group["habitPointer"] as! PFObject
        let firstQuery = PFQuery(className: "GroupHabit")

        let groupHabit = try? firstQuery.getObjectWithId(toHabit.objectId!)
        
        
        cell.groupName.text = (group["groupName"] as! String)
        cell.groupMemberCount.text! = "Group Members: \(group["memberCount"] ?? "" )"
        cell.groupGoal.text = groupHabit?["habitName"] as! String
        let imageFile = group["image"] as! PFFileObject
        let urlString = imageFile.url!
        let url = URL(string: urlString)!
        
        cell.groupImage.af.setImage(withURL: url)
        
        cell.groupImage.layer.borderWidth = 1
        cell.groupImage.layer.masksToBounds = false
        cell.groupImage.layer.borderColor = UIColor.clear.cgColor
        cell.groupImage.layer.cornerRadius = cell.groupImage.frame.height/2
        cell.groupImage.clipsToBounds = true
        
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

        if (segue.identifier == "SegueGroupScreen") {
            let cell = sender as! UITableViewCell
            let indexPath = tableView.indexPath(for: cell)!

            let group = groups[indexPath.row]

            let groupScreenViewController = segue.destination as! GroupScreenViewController

            groupScreenViewController.group = group
       
            tableView.deselectRow(at: indexPath, animated: true)
        }
   }
    
}
