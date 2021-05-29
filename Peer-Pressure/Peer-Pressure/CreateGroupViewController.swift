import UIKit
import AlamofireImage
import Parse

class CreateGroupViewController: UIViewController, UIImagePickerControllerDelegate & UINavigationControllerDelegate {

    @IBOutlet weak var groupPicture: UIImageView!
    @IBOutlet weak var groupName: UITextField!
    
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
        let group = PFObject(className: "Group")
        
        group["groupName"] = groupName.text!
        //group["author"] = PFUser.current()!
        
        let imageData = groupPicture.image!.pngData()
        let file = PFFileObject(name: "image.png", data: imageData!)
        
        group["image"] = file
        
        group.saveInBackground { (success, error) in
            if success {
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
