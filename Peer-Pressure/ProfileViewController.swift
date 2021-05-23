//
//  ProfileViewController.swift
//  Peer-Pressure
//
//  Created by qiru hu on 5/15/21.
//

import UIKit
import Parse
import AlamofireImage


class ProfileViewController: UIViewController,UITableViewDataSource, UITableViewDelegate {
    var habits = [PFObject]()
    var groups = [PFObject]()
    //var user : PFObject?
    
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var habbitTableView: UITableView!
    
    @IBOutlet weak var groupTableView: UITableView!
    @IBOutlet weak var username: UILabel!
    @IBOutlet weak var userimage: UIImageView!
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        if tableView == habbitTableView{
//            print("habbits: \(habits.count)")
//            return habits.count
//        } else {
//            print("groups: \(groups.count)")
//            return groups.count
//        }
        return 1

    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == habbitTableView{
            let habit = habits[indexPath.section]
            print(habit["habitName"]!)
            let cell: HabbitCell = self.habbitTableView.dequeueReusableCell(withIdentifier: "HabbitCell", for: indexPath) as! HabbitCell
            cell.habitLabel?.text = habit["habitName"] as? String
            cell.actualCount?.text = "\(habit["actualCount"]!)"
            cell.goalCount?.text = "\(habit["goalCount"]!)"
            cell.backgroundColor = UIColor.green
            return cell
        } else {
            let group = groups[indexPath.section]
            print(group["groupName"]!)
            let cell: GroupCell = self.groupTableView.dequeueReusableCell(withIdentifier:"GroupCell", for: indexPath) as! GroupCell
            cell.groupName?.text = group["groupName"] as? String
            cell.memberCount?.text = "\(group["memberCount"]!)"

            //let imageFile = group["image"] as! PFFileObject
            
//            let urlString = imageFile.url!
//            let url = URL(string: urlString)!
            
            //cell.groupImage.af_setImage(withURL: url)
            let groupImage = group["image"] as? PFFileObject
            groupImage?.getDataInBackground{ (imageData, error)in
                DispatchQueue.main.async {
                  if imageData != nil, error == nil {
                    let image = UIImage(data: imageData!)
                    cell.groupImage?.image = image
                  } else {
                    print("error getting image: \(error)")
                  }
               }
            }
            cell.backgroundColor = UIColor.yellow
            return cell
        }
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        if tableView == habbitTableView{
            print("habbits: \(habits.count)")
            return habits.count
        } else {
            print("groups: \(groups.count)")
            return groups.count
        }
    }
    
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        if tableView == groupTableView {
//            return 100.0;//Choose your custom row height
//        } else {
//            return 70.5;
//        }
//
//    }
    


    override func viewDidLoad() {
        super.viewDidLoad()
        //self.habbitTableView.register(HabbitCell.self,forCellReuseIdentifier:"HabbitCell")
        self.habbitTableView.delegate = self
        self.habbitTableView.dataSource = self
        
        //self.habbitTableView.register(GroupCell.self,forCellReuseIdentifier:"GroupCell")
        self.groupTableView.delegate = self
        self.groupTableView.dataSource = self
        // Do any additional setup after loading the view.
        
        self.habbitTableView.estimatedRowHeight = 40.0;
        self.habbitTableView.rowHeight = UITableView.automaticDimension;
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print("viewDidAppear")
        var user = PFUser.current()!
        username.text = user.username
        

//        var firstQuery:  PFQuery = PFUser.query()!
//        firstQuery.includeKeys(["location","publicity"])
//        firstQuery.whereKey("username", equalTo: user.username!)
//
//        firstQuery.getFirstObjectInBackground
//        {(user, error) in
//                        if user != nil {
//                            self.locationLabel.text = (user?["location"] as! String)
//
//                        } else {
//                            print("error in finding user: \(error)")
//                        }
//        }
        let useravatar = user["image"] as? PFFileObject
        useravatar?.getDataInBackground{ (imageData, error)in
            DispatchQueue.main.async {
              if imageData != nil, error == nil {
                let image = UIImage(data: imageData!)
                self.userimage.image = image

              }
           }
        }
        
        
        let secondQuery = PFQuery(className: "Habit")
        secondQuery.includeKeys(["habitname","goalCounts","actualCount"])
        secondQuery.whereKey("username", equalTo: user["username"]!)

        secondQuery.findObjectsInBackground { (habits, error) in
                        if habits != nil {
                            self.habits = habits!
                            self.habbitTableView.reloadData()
                        } else {
                            print("error in finding habbits: \(error)")
                        }
                    }
        
        let thirdQuery = PFQuery(className: "Group")
        thirdQuery.includeKeys(["groupName","location","image","memberCount", "groupProgress"])
        thirdQuery.whereKey("username", equalTo: user["username"]!)

        thirdQuery.findObjectsInBackground { (groups, error) in
                        if groups != nil {
                            self.groups = groups!
                            self.groupTableView.reloadData()
                        } else {
                            print("error in finding groups: \(error)")
                        }
                    }
    }
    
    @IBAction func onLogout(_ sender: Any) {
        PFUser.logOut()
        let main = UIStoryboard(name: "Main", bundle: nil)
        let loginViewController = main.instantiateViewController(identifier: "LoginViewController")
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene, let delegate = windowScene.delegate as? SceneDelegate else {return}
        delegate.window?.rootViewController = loginViewController
        print("logout")
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView == self.habbitTableView {
            // you clicked the first table
            self.habbitTableView.deselectRow(at: indexPath, animated: true)
        } else {
            // you clicked the second table
            self.groupTableView.deselectRow(at: indexPath, animated: true)
        }
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

