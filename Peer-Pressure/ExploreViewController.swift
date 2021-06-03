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
        
        return cell
    }
    

}
