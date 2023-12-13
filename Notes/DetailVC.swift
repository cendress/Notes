//
//  DetailVC.swift
//  Notes
//
//  Created by Christopher Endress on 12/13/23.
//

import UIKit

class DetailVC: UIViewController {
  var note: Note?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    if let noteToShow = note {
      navigationController?.title = noteToShow.title
    }
  }
  
}
