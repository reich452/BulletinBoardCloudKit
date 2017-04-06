//
//  Post+CloudKit.swift
//  BulitinBoardNotification
//
//  Created by Nick Reichard on 4/6/17.
//  Copyright © 2017 Nick Reichard. All rights reserved.
//

import Foundation
import CloudKit

extension Post {
    
    init?(cloudKitRecord: CKRecord) {
        guard let postText = cloudKitRecord[Constants.postDateKey] as? String,
            let date = cloudKitRecord.creationDate ?? (cloudKitRecord[Constants.postDateKey] as? Date), cloudKitRecord.recordType == Constants.postRecordType else { return nil }
        self.init(postText: postText, date: date)
    }
    
    var cloudKitRecord: CKRecord {
        let record = CKRecord(recordType: Constants.postRecordType)
        record[Constants.postTextKey] = postText as CKRecordValue?
        record[Constants.postTextKey] = date as NSDate
        return record
    }
}
