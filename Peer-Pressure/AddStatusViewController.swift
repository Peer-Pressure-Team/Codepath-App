//
//  AddStatusViewController.swift
//  Peer-Pressure
//
//  Created by Adrian Lindell on 5/21/21.
//

import UIKit

class AddStatusViewController: UIViewController {
    @IBAction func onSubmit(_ sender: Any) {
        let status = statusTextView.text
    }
    
    @IBOutlet weak var statusTextView: UITextView!
    
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
