//
//  FeedViewController.swift
//  Peer-Pressure
//
//  Created by qiru hu on 5/15/21.
//

import UIKit
//import Parse

class FeedViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
//    var statuses = [PFObject]()
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = statuses[indexPath.row] as! FeedCell
        let cell = FeedCell()
        return cell;
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
