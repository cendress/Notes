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
    
    navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "plus"), style: .plain, target: self, action: #selector(addNote))
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
  
  //MARK: - Tableview delegate methods
  
  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    tableView.deselectRow(at: indexPath, animated: true)
    //push detailVC
  }
  
  override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    60
  }
  
  //MARK: - Other methods
  
  @objc func addNote() {
    let ac = UIAlertController(title: "Add Note", message: nil, preferredStyle: .alert)
    
    ac.addTextField { textField in
      textField.autocapitalizationType = .sentences
    }
    
    let done = UIAlertAction(title: "Done", style: .default) { [weak self, weak ac] action in
      guard let text = ac?.textFields?.first?.text else { return }
      
      let newNote = Note(title: text, text: "")
      self?.notes.append(newNote)
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

