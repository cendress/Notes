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
  var toolbar: UIToolbar!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    configureToolbar()
    
    navigationController?.navigationBar.prefersLargeTitles = false
    
    if let noteToShow = note {
      self.title = noteToShow.title
      textView.text = noteToShow.text
    }
    
    let save = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(saveNote))
    let activityIndicator = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(shareTapped))
    
    navigationItem.rightBarButtonItems = [activityIndicator, save]
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
    guard let noteText = note?.text else { return }
    
    let activityVC = UIActivityViewController(activityItems: [noteText], applicationActivities: nil)
    
    if let popoverController = activityVC.popoverPresentationController {
      popoverController.barButtonItem = navigationItem.rightBarButtonItem
    }
    
    present(activityVC, animated: true)
  }
  
  private func configureToolbar() {
    toolbar = UIToolbar()
    toolbar.translatesAutoresizingMaskIntoConstraints = false
    view.addSubview(toolbar)
    
    NSLayoutConstraint.activate([
      toolbar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
      toolbar.trailingAnchor.constraint(equalTo: view.trailingAnchor),
      toolbar.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
    ])
  }
}
