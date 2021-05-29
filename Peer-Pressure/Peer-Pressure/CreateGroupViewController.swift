//
//  CreateGroupViewController.swift
//  Peer-Pressure
//
//  Created by Leonardo Valdivia on 5/29/21.
//

import UIKit

class CreateGroupViewController: UIViewController {

    @IBOutlet weak var groupPicture: UIImageView!
    @IBAction func onBackButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        groupPicture.layer.borderWidth = 1
        groupPicture.layer.masksToBounds = false
        groupPicture.layer.borderColor = UIColor.clear.cgColor
        groupPicture.layer.cornerRadius = groupPicture.frame.height/2
        groupPicture.clipsToBounds = true
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
