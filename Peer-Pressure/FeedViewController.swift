//
//  FeedViewController.swift
//  Peer-Pressure
//
//  Created by qiru hu on 5/15/21.
//

import UIKit
import Parse
import AlamofireImage
import MessageInputBar

class FeedViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, MessageInputBarDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    
    var myRefreshControl = UIRefreshControl()
    let commentBar = MessageInputBar()
    
    var statuses = [PFObject]()
    var totalStatuses: Int32 = 0
    var showsCommentBar = false
    var selectedStatus: PFObject!
    
    override var inputAccessoryView: UIView? {
        return commentBar
    }
    
    override var canBecomeFirstResponder: Bool {
        return showsCommentBar
    }
    
    func messageInputBar(_ inputBar: MessageInputBar, didPressSendButtonWith text: String) {
        // create the comment
        let comment = PFObject(className: "Comments")
        comment["text"] = commentBar.inputTextView.text as String
        comment["status"] = selectedStatus
        comment["user"] = PFUser.current()
            
        // every post has an array called comments
        selectedStatus.add(comment, forKey: "comments")
            
        selectedStatus.saveInBackground { (success, error) in
            if success {
                print("Comment saved")
            } else {
                print("Error saving comment: \(String(describing: error))")
            }
        }
        
        // reload table view to display comment
        tableView.reloadData()
        
        // clear and dismiss input bar
        commentBar.inputTextView.text = nil
        showsCommentBar = false
        becomeFirstResponder()
        commentBar.inputTextView.resignFirstResponder()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //1 for status + 1 for each comment + 1 for comment bar
        let status = statuses[section]
        let comments = (status["comments"] as? [PFObject]) ?? []
        
        return comments.count + 2;
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        // each status is a section
        print(statuses.count)
        return statuses.count;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //grab PFObject
        let status = statuses[indexPath.section]
        //grab comments
        let comments = (status["comments"] as? [PFObject]) ?? []
        
        // post cell
        if indexPath.row == 0 {
            //grab cell
            let cell = tableView.dequeueReusableCell(withIdentifier: "FeedCell") as! FeedCell

            
            let user = status["user"] as! PFUser
            
            cell.usernameLabel.text = user.username
            cell.messageLabel.text = status["progressUpdate"] as? String
            
            let imageFile = user["image"] as! PFFileObject
            let urlString = imageFile.url!
            let url = URL(string: urlString)!
            
            cell.profileImageView.af.setImage(withURL: url)
            
            cell.statusId = status.objectId!
            
            let numLikes = status["likesCount"] as! Int
            let likesText = String(numLikes) + " likes"
            
            cell.likesLabel.text = likesText
            cell.profileImageView.translatesAutoresizingMaskIntoConstraints = false
            
            return cell
            
        } else if indexPath.row <= comments.count {
            //grab cell
            let cell = tableView.dequeueReusableCell(withIdentifier: "CommentCell") as! CommentCell

            // zeroth comment at row 1 so subtract 1
            let comment = comments[indexPath.row - 1]
            
            let user = comment["user"] as! PFUser
            
            cell.usernameLabel.text = user.username
            cell.commentLabel.text = comment["text"] as? String
            
            return cell
            
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "AddCommentCell")!
            
            return cell
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        commentBar.inputTextView.placeholder = "Add a comment..."
        commentBar.sendButton.title = "Post"
        commentBar.delegate = self
        
        tableView.delegate = self
        tableView.dataSource = self
        
        myRefreshControl.addTarget(self, action: #selector(loadStatuses), for: .valueChanged)
        
        tableView.refreshControl = myRefreshControl
        
        tableView.keyboardDismissMode = .interactive
        
        // NotificationCenter broadcasts all notifications
        let center = NotificationCenter.default
        center.addObserver(self, selector: #selector(keyboardWillBeHidden(note:)), name: UIResponder.keyboardWillHideNotification, object: nil)

        // Do any additional setup after loading the view.
    }
    
    @objc func keyboardWillBeHidden(note: Notification) {
        commentBar.inputTextView.text = nil
        
        // toggle view
        showsCommentBar = false
        becomeFirstResponder()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        loadStatuses()
    }
    
    @objc func loadStatuses() {
        let query = PFQuery(className: "Status")
        //include the pointers to user and comments and comments.user
        query.includeKeys(["user", "comments", "comments.user"])
        query.limit = 5
        query.order(byDescending: "createdAt")
        
        //get query
        query.findObjectsInBackground { (statuses, error) in
            if statuses != nil {
                //store data
                self.statuses.removeAll()
                self.statuses = statuses!
                //reload table view
                self.tableView.reloadData()
                self.myRefreshControl.endRefreshing()
            }
        }
    }
    
    func totalStatusesCount() {
        let query = PFQuery(className:"Status")
        query.countObjectsInBackground { (count: Int32, error: Error?) in
            if let error = error {
                // The request failed
                print(error.localizedDescription)
            } else {
                self.totalStatuses = count;
            }
        }
    }
    
    func loadMoreStatuses() {
        let query = PFQuery(className: "Status")
        //include the pointer to user
        query.includeKey("user")
        query.order(byDescending: "createdAt")
        
        //count available posts and don't load more than available
        totalStatusesCount()
        let totalCount = Int(self.totalStatuses)
        var limit = totalCount - self.statuses.count
        if !(limit > 0) {
            return
        }
        if (limit > 5) {
            limit = 5
        }
        query.limit = limit
        
        query.skip = self.statuses.count
        
        //get query
        query.findObjectsInBackground { (statuses, error) in
            if statuses != nil {
                //store data
                self.statuses.append(contentsOf: statuses!)
                //reload table view
                self.tableView.reloadData()
            }
        }
        
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row + 1 == statuses.count {
            loadMoreStatuses()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let status = statuses[indexPath.section]
        let comments = (status["comments"] as? [PFObject]) ?? []
        if indexPath.row == comments.count + 1 {
            //show comment bar
            showsCommentBar = true
            
            // first responder is focus
            becomeFirstResponder()
            commentBar.inputTextView.becomeFirstResponder()
            
            selectedStatus = status
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
