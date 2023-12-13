//
//  Note.swift
//  Notes
//
//  Created by Christopher Endress on 12/13/23.
//

import Foundation

struct Note: Codable {
  let title: String
  let text: String
  
  static let savedNotesKey = "SavedNotes"
  
  static func saveNotes(notes: [Note]) {
    let defaults = UserDefaults.standard
    let encoder = JSONEncoder()
    
    do {
      let encoded = try encoder.encode(notes)
      defaults.setValue(encoded, forKey: savedNotesKey)
    } catch {
      print("Failed to encode the data, \(error.localizedDescription)")
    }
  }
  
  static func loadNotes() -> [Note] {
    let defaults = UserDefaults.standard
    let decoder = JSONDecoder()
    
    if let savedNotes = defaults.object(forKey: savedNotesKey) as? Data {
      do {
        return try decoder.decode([Note].self, from: savedNotes)
      } catch {
        print("Failed to decode the data, \(error.localizedDescription)")
      }
    }
    
    return []
  }
}
