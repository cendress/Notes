//
//  ViewController.swift
//  Notes
//
//  Created by Christopher Endress on 12/13/23.
//

import UIKit

class NotesVC: UITableViewController {
  var notes: [Note] = []
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    notes = Note.loadNotes()
    
    navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addNote))
    navigationItem.leftBarButtonItem = self.editButtonItem
    
    navigationController?.navigationBar.prefersLargeTitles = true
  }
  
  //MARK: - Tableview data source methods
  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    notes.count
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "NoteCell", for: indexPath)
    let name = notes[indexPath.row].title
    cell.textLabel?.text = name
    cell.accessoryType = .disclosureIndicator
    return cell
  }
  
  override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
    if editingStyle == .delete {
      notes.remove(at: indexPath.row)
      tableView.deleteRows(at: [indexPath], with: .fade)
      Note.saveNotes(notes: notes)
      tableView.reloadData()
    }
  }
  
  //MARK: - Tableview delegate methods
  
  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    if let detailVC = navigationController?.storyboard?.instantiateViewController(identifier: "DetailVC") as? DetailVC {
      detailVC.note = notes[indexPath.row]
      detailVC.onNoteUpdate = { [weak self] updatedNote in
        guard let strongSelf = self else { return }
        if let index = strongSelf.notes.firstIndex(where: { $0.id == updatedNote.id }) {
          strongSelf.notes[index] = updatedNote
          Note.saveNotes(notes: strongSelf.notes)
          strongSelf.tableView.reloadData()
        }
      }
      navigationController?.pushViewController(detailVC, animated: true)
    }
  }
  
  override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    60
  }
  
  //MARK: - Other methods
  
  @objc func addNote() {
    let ac = UIAlertController(title: "Add Note", message: nil, preferredStyle: .alert)
    
    ac.addTextField { textField in
      textField.autocapitalizationType = .sentences
      textField.placeholder = "Write the title of your note here"
    }
    
    let done = UIAlertAction(title: "Done", style: .default) { [weak self, weak ac] action in
      guard let text = ac?.textFields?.first?.text, !text.isEmpty else { return }
      
      let newNote = Note(title: text, text: "")
      self?.notes.append(newNote)
      Note.saveNotes(notes: self?.notes ?? [])
      self?.tableView.reloadData()
    }
    
    let cancel = UIAlertAction(title: "Cancel", style: .cancel)
    
    ac.addAction(done)
    ac.addAction(cancel)
    present(ac, animated: true)
  }
}

//create a notes data model
//configure a tableview
//add a detailvc with a textview
//push detailvc from tableview
//save the data with userdefaults
//add a activityviewcontroller to detailvc
//add delete and compose tool bar button items to detailvc
//change UI to look like the Notes app

