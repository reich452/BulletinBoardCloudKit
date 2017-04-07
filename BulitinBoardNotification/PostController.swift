//
//  PostController.swift
//  BulitinBoardNotification
//
//  Created by Nick Reichard on 4/6/17.
//  Copyright © 2017 Nick Reichard. All rights reserved.
//

import Foundation
import CloudKit

class PostController {
    
    static let shared = PostController()
    
   private(set) var posts = [Post]() { // Can only be set inside of this class 
        didSet {
            // Implement notification for when posts are set
            DispatchQueue.main.async {
                let notificationCenter = NotificationCenter.default
                notificationCenter.post(name: Constants.DidRefreshNotification, object: self)
            }
        }
    }
    
    private let cloudKitManager = CloudKitManager()
    
    init(){
        refreshData()
    }
    
    func create(withPost postText: String, andDate date: Date = Date(), completion: @escaping ((Error?) -> Void) = { _ in }) {
        let post = Post(postText: postText)
        let record = post.cloudKitRecord
        cloudKitManager.save(record) { (error) in
            defer { completion (error) } // instead of calling it at the end over every return
            if let error = error {
                NSLog("Error saving \(post.postText) to CloudKit with error:\n\(error)")
                return
            }
            self.posts.insert(post, at: 0)
        }
    }
    
    func refreshData(completion: @escaping ((Error?) -> Void) = { _ in }) {
        let sortDescriptors = [NSSortDescriptor(key: Constants.postDateKey, ascending: false)]
        cloudKitManager.fetchRecords(ofType: Constants.postRecordType, withSortDescriptors: sortDescriptors) { (records, error) in
            defer { completion(error) }
            if let error = error {
                NSLog("Error fetching posts: \n\(error)")
                return
            }
            guard let records = records else { return }
            self.posts = records.flatMap { Post(cloudKitRecord: $0)}
        }
    }
    
    func subscribeToPushNotification(completion: @escaping ((Error?) -> Void) = { _ in }) {
        cloudKitManager.subscribeToCreationOFRecords(withtype: Constants.postRecordType) {
            (error) in
            if let error = error {
                NSLog("Error saving subscription:\n\(error)")
            } else {
                NSLog("Subscribed to push notification for new posts")
            }
            completion(error)
        }
        
    }
    
}
