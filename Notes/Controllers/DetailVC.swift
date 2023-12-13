//
//  DetailVC.swift
//  Notes
//
//  Created by Christopher Endress on 12/13/23.
//

import UIKit

class DetailVC: UIViewController {
  @IBOutlet weak var textView: UITextView!
  
  var note: Note?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    navigationController?.navigationBar.prefersLargeTitles = false
    
    if let noteToShow = note {
      self.title = noteToShow.title
    }
  }
}
