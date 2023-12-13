//
//  DetailVC.swift
//  Notes
//
//  Created by Christopher Endress on 12/13/23.
//

import UIKit

class DetailVC: UIViewController, UITextViewDelegate {
  @IBOutlet weak var textView: UITextView!
  
  var note: Note?
  var allNotes: [Note]?
  var onNoteUpdate: ((Note) -> Void)?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    navigationController?.navigationBar.prefersLargeTitles = false
    
    if let noteToShow = note {
      self.title = noteToShow.title
      textView.text = noteToShow.text
    }
  }
  
  func textViewDidChange(_ textView: UITextView) {
    note?.text = textView.text
    Note.saveNotes(notes: note)
  }
}
