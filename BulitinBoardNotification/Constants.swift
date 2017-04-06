//
//  Constants.swift
//  BulitinBoardNotification
//
//  Created by Nick Reichard on 4/6/17.
//  Copyright © 2017 Nick Reichard. All rights reserved.
//

import Foundation

struct Constants {
    
    // MARK: - CloudKit Keys
    static let postRecordType = "Post"
    static let postTextKey = "postText"
    static let postDateKey = "postDate"
    
    // MARK: - UItableViewCell Reuse Identifiers 
    
    static let postCellReuseIdentifier = "postCell"
    
    // MARK: - Notification Center Names 
    static let DidRefreshNotification = Notification.Name("DidRefreshNotification")
}
