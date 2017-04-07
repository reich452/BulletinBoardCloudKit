//
//  Post.swift
//  BulitinBoardNotification
//
//  Created by Nick Reichard on 4/6/17.
//  Copyright © 2017 Nick Reichard. All rights reserved.
//

import Foundation
import CloudKit

class Post {
    
    let postText: String
    let date: Date
    
    init(postText: String, date: Date = Date()) {
        self.postText = postText
        self.date = date
    }
}

