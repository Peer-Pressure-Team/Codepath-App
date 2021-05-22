//
//  FeedViewController.swift
//  Peer-Pressure
//
//  Created by qiru hu on 5/15/21.
//

import UIKit
//import Parse
//import MessageInputBar

class FeedViewController: UIViewController, UITableViewDelegate, UITableViewDataSource/*, MessageInputBarDelegate*/ {
    
//    var statuses = [PFObject]()
    
    /*Comment (reply) bar setup*/
//    let commentBar = MessageInputBar()
    
//    override var inputAccessoryView: UIView? {
//        return commentBar
//    }
//
//    override var canBecomeFirstResponder: Bool {
//        return showsCommentBar
//    }
    
//    func messageInputBar(_ inputBar: MessageInputBar, didPressSendButtonWith text: String) {
//        // create the comment
//        let comment = PFObject(className: "Comments")
//        comment["text"] = commentBar.inputTextView.text as String
//        comment["post"] = selectedPost
//        comment["author"] = PFUser.current()
//
//        // every post has an array called comments
//        selectedPost.add(comment, forKey: "comments")
//
//        selectedPost.saveInBackground { (success, error) in
//            if success {
//                print("Comment saved")
//            } else {
//                print("Error saving comment: \(String(describing: error))")
//            }
//        }
//
//        // reload table view to display comment
//        tableView.reloadData()
//
//        // clear and dismiss input bar
//        commentBar.inputTextView.text = nil
//        showsCommentBar = false
//        becomeFirstResponder()
//        commentBar.inputTextView.resignFirstResponder()
//    }
    
//    @objc func keyboardWillBeHidden(note: Notification) {
//        commentBar.inputTextView.text = nil
//
//        // toggle view
//        showsCommentBar = false
//        becomeFirstResponder()
//    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //1 for status + 1 for each comment + 1 for comment bar
        return 1;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = statuses[indexPath.section] as! FeedCell
        let cell = FeedCell()
        return cell;
    }
    
//    func numberOfSections(in tableView: UITableView) -> Int {
//        return statuses.count
//    }
    
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let status = statuses[indexPath.section]
//        let comments = (status["comments"] as? [PFObject]) ?? []
//
//        if indexPath.row == comments.count + 1 {
//            //show comment bar
//            showsCommentBar = true
//
//            // first responder is focus
//            becomeFirstResponder()
//            commentBar.inputTextView.becomeFirstResponder()
//
//            selectedStatus = status
//        }
//    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
//        commentBar.inputTextView.placeholder = "Add a comment..."
//        commentBar.sendButton.title = "Post"
//        commentBar.delegate = self
//
//        tableView.delegate = self
//        tableView.dataSource = self
//
//        myRefreshControl.addTarget(self, action: #selector(loadPosts), for: .valueChanged)
//
//        tableView.refreshControl = myRefreshControl
//
//        tableView.keyboardDismissMode = .interactive
//
//        // NotificationCenter broadcasts all notifications
//        let center = NotificationCenter.default
//        center.addObserver(self, selector: #selector(keyboardWillBeHidden(note:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        //load statuses
    }
    
//    @objc func loadStatuses() {
//        let query = PFQuery(className: "Status")
//        //include the pointers to user and comments and comments.author
//        query.includeKeys(["author", "comments", "comments.author"])
//        query.limit = 5
//        query.order(byDescending: "createdAt")
//
//        //get query
//        query.findObjectsInBackground { (status, error) in
//            if posts != nil {
//                //store data
//                self.statuses.removeAll()
//                self.statuses = statuses!
//                //reload table view
//                self.tableView.reloadData()
//                self.myRefreshControl.endRefreshing()
//            }
//        }
//    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
