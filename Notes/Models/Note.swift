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
        defaults.setValue(notes, forKey: savedNotesKey)
    } catch {
      print("Failed to encode data, \(error.localizedDescription)")
    }
  }
}
