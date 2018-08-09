//
//  Entry.swift
//  Journal
//
//  Created by Samantha Gatt on 8/9/18.
//  Copyright © 2018 Samantha Gatt. All rights reserved.
//

import Foundation

class Journal: Codable, Equatable {
    
    let title: String
    let identifier: String
    var timestamp: Date
    var entries: [Journal.Entry]
    
    struct Entry: Codable, Equatable {
    
        var title: String
        var body: String
        var timestamp: Date
        let identifier: String
        
        init(title: String, body: String, timestamp: Date = Date(), identifier: String = UUID().uuidString) {
            self.title = title
            self.body = body
            self.timestamp = timestamp
            self.identifier = identifier
        }
    }
    
    // MARK: - Initializers
    
    init(title: String, identifier: String = UUID().uuidString, timestamp: Date, entries: [Journal.Entry] = []) {
        self.title = title
        self.identifier = identifier
        self.timestamp = timestamp
        self.entries = entries
    }
    
    
    // MARK: - Equatable
    
    static func == (lhs: Journal, rhs: Journal) -> Bool {
        return
            lhs.title == rhs.title &&
                lhs.identifier == rhs.identifier &&
                lhs.timestamp == rhs.timestamp &&
                lhs.entries == rhs.entries
    }
}
