//
//  CreateHabitViewController.swift
//  Peer-Pressure
//
//  Created by qiru hu on 5/29/21.
//

import UIKit
import Parse

class CreateHabitViewController: UIViewController {
//    func dismiss(animated: true, completion: {
//        referenceToUnderlyingViewController.doTheBusiness()
//    })
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBOutlet weak var habitNameField: UITextField!
    
    @IBOutlet weak var endTimeField: UITextField!
    @IBOutlet weak var startTimeField: UITextField!
    @IBOutlet weak var frequencyTimeField: UITextField!
    
    
    @IBAction func onCloseButton(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func onCreateButton(_ sender: Any) {
        var user = PFUser.current()!
        var parseObject = PFObject(className:"Habit")
        parseObject["username"] = user.username
        parseObject["habitName"] = habitNameField.text
        parseObject["startTime"] = startTimeField.text
        parseObject["endTime"] = endTimeField.text
        parseObject["goalCount"] = Int(frequencyTimeField.text!)
        // Saves the new object.
        parseObject.saveInBackground {
          (success: Bool, error: Error?) in
          if (success) {
            let parentVC = self.presentingViewController as? ProfileViewController
            parentVC?.habbitTableView.reloadData()
            self.dismiss(animated: true, completion: nil)
            print("Habit saved: \(parseObject["habitName"])")
          } else {
            print("Error saving Habit: \(parseObject["habitName"])")
          }
        }
        NotificationCenter.default.post( name: NSNotification.Name(rawValue: "refresh"), object: nil)
        dismiss(animated: true, completion: nil)
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let parentVC = presentingViewController as? ProfileViewController {
                parentVC.habbitTableView.reloadData()
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
