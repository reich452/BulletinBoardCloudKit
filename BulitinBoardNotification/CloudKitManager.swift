//
//  CloudKitManager.swift
//  BulitinBoardNotification
//
//  Created by Nick Reichard on 4/6/17.
//  Copyright © 2017 Nick Reichard. All rights reserved.
//

import Foundation
import CloudKit

class CloudKitManager {
    
    let publicDatabase = CKContainer.default().publicCloudDatabase
    
    func fetchRecords(ofType type: String,
                      withSortDescriptors sortDescriptors: [NSSortDescriptor]? = nil,
                      completion: @escaping ([CKRecord]?, Error?) -> Void) {
        
        let query = CKQuery(recordType: type, predicate: NSPredicate(value: true))
        query.sortDescriptors = sortDescriptors
        publicDatabase.perform(query, inZoneWith: nil, completionHandler: completion)
    }
    
    func save(_ record: CKRecord, completion: @escaping ((Error?) -> Void) ) {
        publicDatabase.save(record) { (_, error) in
            completion(error)
        }
    }
    
    func subscribeToCreationOFRecords(withtype type: String, completion: @escaping ((Error?) -> Void) = { _ in}) {
        let subscription = CKQuerySubscription(recordType: type, predicate: NSPredicate(value: true), options: .firesOnRecordCreation)
        let notificationInfo = CKNotificationInfo()
        notificationInfo.alertBody = "There's a new post on the bulletin board!"
        subscription.notificationInfo = notificationInfo
        publicDatabase.save(subscription) { (_, error) in
            if let error = error {
                NSLog("Error saving subscription:\n\(error)")
            }
            completion(error)
        }
    }
 
    
}
