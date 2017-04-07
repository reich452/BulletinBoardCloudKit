//
//  PostTableViewController.swift
//  BulitinBoardNotification
//
//  Created by Nick Reichard on 4/6/17.
//  Copyright © 2017 Nick Reichard. All rights reserved.
//

import UIKit
import NotificationCenter

class PostListTableViewController: UITableViewController {
    
    @IBOutlet weak var postTextField: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(self, selector: #selector(postsWereUpdated), name: Constants.DidRefreshNotification, object: nil)
    }
    
    func postsWereUpdated() {
        tableView.reloadData()
    }
    
    // MARK: - Action
    
    @IBAction func postButtonTapped(_ sender: Any) {
        guard let postText = postTextField.text else { return }
        
        PostController.shared.create(withPost: postText) { (_) in
            DispatchQueue.main.async {
                self.postTextField.text = nil
                self.postTextField.resignFirstResponder()
            }
        }
    }
    
    let dateFormater: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.timeStyle = .short
        formatter.doesRelativeDateFormatting = true
        return formatter
    }()
    

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return PostController.shared.posts.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.postCellReuseIdentifier, for: indexPath)
        let post = PostController.shared.posts[indexPath.row]
        cell.textLabel?.text = post.postText
        cell.detailTextLabel?.text = "\(post.date)"

        return cell
    }
 
    

    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            
       
        }    
    }
 

}
