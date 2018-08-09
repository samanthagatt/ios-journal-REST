//
//  EntryDetailViewController.swift
//  Journal
//
//  Created by Samantha Gatt on 8/9/18.
//  Copyright © 2018 Samantha Gatt. All rights reserved.
//

import UIKit

class EntryDetailViewController: UIViewController {

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        updateViews()
    }
    
    
    // MARK: - Functions
    
    func updateViews() {
        if isViewLoaded {
            
            guard let thisEntry = entry else {
                navigationItem.title = "Create Entry"
                return
            }
            
            navigationItem.title = thisEntry.title
            titleTextField.text = thisEntry.title
            bodyTextView.text = thisEntry.body
        }
    }
    
    
    // MARK: - Actions
    
    @IBAction func save(_ sender: Any) {
        
        guard let title = titleTextField.text,
            let body = bodyTextView.text else { return }
        
        if let thisEntry = entry {
            entryController?.update(entry: thisEntry, title: title, body: body, completion: { (error) in
                DispatchQueue.main.async {
                    self.navigationController?.popViewController(animated: true)
                }
            })
        } else {
            entryController?.create(title: title, body: body, completion: { (error) in
                DispatchQueue.main.async {
                    self.navigationController?.popViewController(animated: true)
                }
            })
        }
    }
    
    
    // MARK: - Properties
    
    var entry: Entry? {
        didSet {
            // Don't really know if this is ever going to be called on a background thread but better to be safe I guess
            DispatchQueue.main.async {
                self.updateViews()
            }
        }
    }
    var entryController: EntryController?
    
    
    // MARK: - Outlets
    
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var bodyTextView: UITextView!
}
