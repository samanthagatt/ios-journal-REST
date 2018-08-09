//
//  EntryTableViewCell.swift
//  Journal
//
//  Created by Samantha Gatt on 8/9/18.
//  Copyright © 2018 Samantha Gatt. All rights reserved.
//

import UIKit

class EntryTableViewCell: UITableViewCell {

    // MARK: - Functions
    
    func updateView() {
        
        guard let title = entry?.title,
            let timestamp = entry?.timestamp,
            let body = entry?.body else { return }
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .short
        dateFormatter.timeStyle = .short
        let date = dateFormatter.string(from: timestamp)
        
        titleTextLabel.text = title
        timestampTextLabel.text = date
        bodyTextLabel.text = body
    }
    
    
    // MARK: - Properties
    
    var entry: Entry? {
        didSet {
            updateView()
        }
    }
    
    
    // MARK: - Outlets
    
    @IBOutlet weak var titleTextLabel: UILabel!
    @IBOutlet weak var timestampTextLabel: UILabel!
    @IBOutlet weak var bodyTextLabel: UILabel!
}
