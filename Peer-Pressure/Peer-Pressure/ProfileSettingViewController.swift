//
//  ProfileSettingViewController.swift
//  Peer-Pressure
//
//  Created by qiru hu on 6/3/21.
//

import UIKit
import AlamofireImage
import Parse

class ProfileSettingViewController: UIViewController, UIImagePickerControllerDelegate & UINavigationControllerDelegate  {
    
    var habits = [PFObject]()
    var groups = [PFObject]()

    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var publicitySwitch: UISwitch!
    @IBOutlet weak var locationtextField: UITextField!
    @IBOutlet weak var usernameTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
//        profileImage.layer.borderWidth = 1
//        profileImage.layer.masksToBounds = false
//        profileImage.layer.borderColor = UIColor.clear.cgColor
//        profileImage.layer.cornerRadius = profileImage.frame.height/2
//        profileImage.clipsToBounds = true
    }
    
    @IBAction func onBackButton(_ sender: UIButton) {
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
    @IBAction func onSaveButton(_ sender: UIButton) {
        let imageData = profileImage.image!.pngData()
        let file = PFFileObject(name: "image.png", data: imageData!)
        var user = PFUser.current()!
        let query = PFQuery(className: "Usersetting")
        query.whereKey("username", equalTo: user["username"]!)
        //var usersetting = PFObject(className: "Usersetting")
        query.getFirstObjectInBackground
        {(usersetting, error) in
                        if usersetting != nil {
                            usersetting!["username"] = self.usernameTextField.text!
                            usersetting!["location"] = self.locationtextField.text!
                            usersetting?["publicity"] = self.publicitySwitch.isOn
                            usersetting?["image"] = file
                            usersetting?.saveInBackground { (success, error) in
                                if success {
                                    // Refreshes original view controller. Too slow
                                    
                                    print("Usersetting saved")
                                } else {
                                    print("Failed to save Usersetting: \(error)")
                                }
                            }

                        } else {
                            print("error in finding usersetting: \(String(describing: error))")
                        }
        }
        let secondQuery = PFQuery(className: "Habit")
        secondQuery.includeKeys(["habitname","goalCounts","actualCount"])
        secondQuery.whereKey("username", equalTo: user["username"]!)

        secondQuery.findObjectsInBackground { (habits, error) in
                        if habits != nil {
                            self.habits = habits!
                            for habit in self.habits {
                                habit["username"] = self.usernameTextField.text!
                                habit.saveInBackground()
                            }
                        } else {
                            print("error in finding habbits: \(String(describing: error))")
                        }
                    }
        
        let thirdQuery = PFQuery(className: "Group")
        thirdQuery.includeKeys(["groupName","location","image","memberCount", "groupProgress"])
        thirdQuery.whereKey("username", equalTo: user["username"]!)

        thirdQuery.findObjectsInBackground { (groups, error) in
                        if groups != nil {
                            self.groups = groups!
                            for group in self.groups {
                                group["username"] = self.usernameTextField.text!
                                group.saveInBackground()
                            }
                        } else {
                            print("error in finding groups: \(String(describing: error))")
                        }
                    }
        
        user.username = usernameTextField.text!
        user["image"] = file
        
        user.saveInBackground{
            (success,error) in
            if success {
                print("User saved")
                
            } else {
                print("Failed to save user: \(error)")
            }
        }
        
        let parentVC = self.presentingViewController as? ProfileViewController
        parentVC?.reloadUserInfo()
        self.dismiss(animated: true, completion: nil)
        
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let image = info[.editedImage] as! UIImage
        
        let size = CGSize(width: 300, height: 300)
        let scaledImage = image.af.imageScaled(to: size)
        
        profileImage.image = scaledImage
        print("Image loaded")
        dismiss(animated: true, completion: nil)
        
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
