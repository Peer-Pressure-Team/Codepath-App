import UIKit
import AlamofireImage
import Parse

class CreateGroupViewController: UIViewController, UIImagePickerControllerDelegate & UINavigationControllerDelegate {

    @IBOutlet weak var groupPicture: UIImageView!
    @IBOutlet weak var groupName: UITextField!
    @IBOutlet weak var habitName: UITextField!
    @IBOutlet weak var habitPeriodSegment: UISegmentedControl!
    @IBOutlet weak var habitFrequency: UITextField!
    
    var habitPeriod = ""
    
    @IBAction func onBackButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func onCameraButton(_ sender: Any) {
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.allowsEditing = true
        
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            picker.sourceType = .camera
        } else {
            picker.sourceType = .photoLibrary
        }
        
        present(picker, animated: true, completion: nil)
    }
    
    @IBAction func onCreateButton(_ sender: Any) {
        
        let option = habitPeriodSegment.selectedSegmentIndex
        
        if option == 0 {
            habitPeriod = "Daily"
        } else if option == 1 {
            habitPeriod = "Weekly"
        } else if option == 2 {
            habitPeriod = "Monthly"
        }
        // Creates group
        let group = PFObject(className: "Group")
        
        group["groupName"] = groupName.text!
        group["username"] = PFUser.current()?.username
        group["memberCount"] = 1
        let imageData = groupPicture.image!.pngData()
        let file = PFFileObject(name: "image.png", data: imageData!)
        
        group["image"] = file
        
        // adds user to member list
        group.add(PFUser.current(), forKey: "members")
        //var memberCount = group["memberCount"] as! Int + 1
        //group["memberCount"] = memberCount
        
        // Creates Group Habit
        let parseObject = PFObject(className:"GroupHabit")
        parseObject["habitName"] = habitName.text
        parseObject["period"] = habitPeriod
        group["habitPointer"] = parseObject
        
        let userHabit = PFObject(className: "Habit")
        userHabit["username"] = PFUser.current()?.username
        userHabit["habitName"] = habitName.text
        userHabit["period"] = habitPeriod
        userHabit["goalCount"] = Int(habitFrequency.text!)
        userHabit["groupPointer"] = group
        
        userHabit.saveInBackground { (success, error) in
            if success {
                print("habit saved")
            } else {
                print("error saving habit")
            }
        }
        
        group.saveInBackground { (success, error) in
            if success {
                // Refreshes original view controller. Too slow
                let parentVC = self.presentingViewController as? GroupViewController
                parentVC?.groupTableView.reloadData()
                self.dismiss(animated: true, completion: nil)
                print("Saved")
            } else {
                print("error!")
            }
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let image = info[.editedImage] as! UIImage
        
        let size = CGSize(width: 300, height: 300)
        let scaledImage = image.af.imageScaled(to: size)
        
        groupPicture.image = scaledImage
        
        dismiss(animated: true, completion: nil)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        groupPicture.layer.borderWidth = 1
        groupPicture.layer.masksToBounds = false
        groupPicture.layer.borderColor = UIColor.clear.cgColor
        groupPicture.layer.cornerRadius = groupPicture.frame.height/2
        groupPicture.clipsToBounds = true
        
    }
    
}
