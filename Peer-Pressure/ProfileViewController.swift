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
    //var user : PFObject?
    
    @IBOutlet weak var habbitTableView: UITableView!
    
    @IBOutlet weak var groupTableView: UITableView!
    @IBOutlet weak var username: UILabel!
    @IBOutlet weak var userimage: UIImageView!
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == habbitTableView{
            return habits.count
        } else {
            return 5
        }
            
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == habbitTableView{
            let habit = habits[indexPath.section]
            let cell = habbitTableView.dequeueReusableCell(withIdentifier:"HabbitCell", for: indexPath) as! HabbitCell
            cell.habbitLabel?.text = (habit["habitName"] as! String)
            cell.actualCount?.text = (habit["actualCount"] as! String)
            cell.goalCount?.text = (habit["goalCount"] as! String)
            return cell
        } else {
            let cell = groupTableView.dequeueReusableCell(withIdentifier:"GroupCell", for: indexPath)
            return cell
        }
        
    }
    
//    func numberOfSections(in tableView: UITableView) -> Int {
//        return habits.count
//    }
    


    override func viewDidLoad() {
        super.viewDidLoad()
        habbitTableView.register(UITableViewCell.self,forCellReuseIdentifier:"HabbitCell")
        habbitTableView.delegate = self
        habbitTableView.dataSource = self
        
        habbitTableView.register(UITableViewCell.self,forCellReuseIdentifier:"GroupCell")
        groupTableView.delegate = self
        groupTableView.dataSource = self
        // Do any additional setup after loading the view.
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print("viewDidAppear")
        var user = PFUser.current()!
        username.text = user.username
        let useravatar = user["image"] as? PFFileObject
        useravatar?.getDataInBackground{ (imageData, error)in
            DispatchQueue.main.async {
              if imageData != nil, error == nil {
                let image = UIImage(data: imageData!)
                self.userimage.image = image

              }
           }
        }
//        let query = PFQuery(className: "User")
//        query.includeKeys(["username","image"])
//        query.whereKey("username", equalTo: PFUser.current()!.username!)
//        query.findObjectsInBackground { (user, error) in
//                    if user != nil {
//                        self.user = (user?[0])!
//                    }
//        }
//        username.text = (user!["username"] as! String)
//
//        let imageFile = user?["image"] as! PFFileObject
//        let urlString = imageFile.url!
//        let url = URL(string: urlString)!
//
//        userimage.af_setImage(withURL: url)
        
        
        let secondQuery = PFQuery(className: "Habit")
        secondQuery.includeKeys(["habitname","goalCounts","actualCount"])
        secondQuery.whereKey("username", equalTo: user["username"]!)

        secondQuery.findObjectsInBackground { (habits, error) in
                        if habits != nil {
                            self.habits = habits!
                            self.habbitTableView.reloadData()
                        }
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
