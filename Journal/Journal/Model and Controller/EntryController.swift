//
//  EntryController.swift
//  Journal
//
//  Created by Samantha Gatt on 8/9/18.
//  Copyright © 2018 Samantha Gatt. All rights reserved.
//

import Foundation

class EntryController: Codable {
    
    // MARK: - Properties
    var entries: [Entry] = []
    static let baseURL = URL(string: "https://samanthagattsjournal.firebaseio.com/")!
    
    // MARK: - CRUD
    
    func create(title: String, body: String, completion: @escaping (Error?) -> Void) {
        
        let entry = Entry(title: title, body: body)
        
        put(entry: entry, completion: completion)
    }
    
    func update(entry: Entry, title: String, body: String, timestamp: Date = Date(), completion: @escaping (Error?) -> Void) {
        
        var scratch = entry
        scratch.title = title
        scratch.body = body
        scratch.timestamp = timestamp
        
        put(entry: scratch, completion: completion)
    }
    
    func delete(entry: Entry, completion: @escaping (Error?) -> Void) {
        
        let requestURL = EntryController.baseURL
            .appendingPathComponent(entry.identifier)
            .appendingPathExtension("json")
        
        var request = URLRequest(url: requestURL)
        request.httpMethod = "DELETE"
        
        URLSession.shared.dataTask(with: request) { (data, _, error) in
            
            if let error = error {
                NSLog("Error deleting \(entry.title) entry from server: \(error)")
                completion(error)
                return
            }
            
            guard let _ = data else {
                completion(error)
                return
            }
        }.resume()
    }
    
    
    // MARK: - Networking
    
    // Put
    func put(entry: Entry, completion: @escaping (Error?) -> Void) {
        
        let data: Data
        
        do {
            data = try JSONEncoder().encode(entry)
        } catch {
            NSLog("Error encoding \(entry.title) entry: \(error)")
            completion(error)
            return
        }
        
        let requestURL = EntryController.baseURL
            .appendingPathComponent(entry.identifier)
            .appendingPathExtension("json")
        
        var request = URLRequest(url: requestURL)
        request.httpMethod = "PUT"
        request.httpBody = data
        
        URLSession.shared.dataTask(with: request) { (data, _, error) in
            
            if let error = error {
                NSLog("Error pushing data to server: \(error)")
                completion(error)
                return
            }
            
            completion(nil)
            
        }.resume()
    }
    
    // Fetch
    func fetch(completion: @escaping (Error?) -> Void) {
        
        let requestURL = EntryController.baseURL.appendingPathExtension("json")
        
        URLSession.shared.dataTask(with: requestURL) { (data, _, error) in
            
            if let error = error {
                NSLog("Error fetching data from server: \(error)")
                completion(error)
                return
            }
            
            guard let data = data else {
                completion(error)
                return
            }
            
            do {
                
                let entryDicts = try JSONDecoder().decode([String: Entry].self, from: data)
                let entries = entryDicts.compactMap { $0.value }
                self.entries = entries.sorted { $0.timestamp > $1.timestamp }
                completion(nil)
                
            } catch {
                NSLog("Error decoding data: \(error)")
                completion(error)
                return
            }
        }.resume()
    }
}
