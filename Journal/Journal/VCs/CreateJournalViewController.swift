//
//  CreateJournalViewController.swift
//  Journal
//
//  Created by Samantha Gatt on 8/9/18.
//  Copyright © 2018 Samantha Gatt. All rights reserved.
//

import UIKit

class CreateJournalViewController: UIViewController {

    
    // MARK: - Actions
    
    @IBAction func save(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    
    // MARK: - Outlets
    
    @IBOutlet weak var titleTextField: UITextField!
    
}
