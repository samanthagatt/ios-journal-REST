//
//  EntriesTableViewController.swift
//  Journal
//
//  Created by Samantha Gatt on 8/9/18.
//  Copyright © 2018 Samantha Gatt. All rights reserved.
//

import UIKit

class EntriesTableViewController: UITableViewController {

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        entryController.fetch { (error) in
            if let error = error {
                NSLog("Error fetching data: \(error)")
                return
            }
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return entryController.entries.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "EntryCell", for: indexPath) as! EntryTableViewCell

        cell.entry = entryController.entries[indexPath.row]

        return cell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete {
            
            let entry = entryController.entries[indexPath.row]
            
            entryController.delete(entry: entry) { (error) in
                
                if let error = error {
                    NSLog("Error deleting data: \(error)")
                    return
                }
                
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
        }
    }
    
    
    // MARK: - Properties
    
    let entryController = EntryController()

    
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let destVC = segue.destination as! EntryDetailViewController
        destVC.entryController = entryController
        
        if segue.identifier == "ShowEntryDetails" {
            guard let index = tableView.indexPathForSelectedRow?.row else { return }
            let entry = entryController.entries[index]
            destVC.entry = entry
        }
    }
}
