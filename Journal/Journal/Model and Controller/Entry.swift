//
//  Entry.swift
//  Journal
//
//  Created by Samantha Gatt on 8/9/18.
//  Copyright © 2018 Samantha Gatt. All rights reserved.
//

import Foundation

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
