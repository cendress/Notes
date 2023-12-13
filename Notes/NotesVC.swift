//
//  ViewController.swift
//  Notes
//
//  Created by Christopher Endress on 12/13/23.
//

import UIKit

class NotesVC: UITableViewController {
  let notes: [Note] = []
  
  override func viewDidLoad() {
    super.viewDidLoad()
 
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
}

//create a notes data model
//configure a tableview
//add a detailvc with a textview
//push detailvc from tableview
//save the data with userdefaults
//add a activityviewcontroller to detailvc
//add delete and compose tool bar button items to detailvc
//change UI to look like the Notes app

