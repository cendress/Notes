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
    
    let save = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(saveNote))
    let activityIndicator = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(shareTapped))
    
    navigationItem.rightBarButtonItems = [save, activityIndicator]
  }
  
  func textViewDidChange(_ textView: UITextView) {
    note?.text = textView.text
  }
  
  override func viewWillDisappear(_ animated: Bool) {
    super.viewWillDisappear(animated)
    if let updatedNote = note {
      onNoteUpdate?(updatedNote)
    }
  }
  
  @objc func saveNote() {
      guard let updatedNote = note else { return }
      note?.text = textView.text
      onNoteUpdate?(updatedNote)
      navigationController?.popViewController(animated: true)
  }
  
  @objc func shareTapped() {
    
  }
}
