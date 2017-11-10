//
//  DetailViewController.swift
//  KeychainTouchMeIn
//
//  Created by Jon Olivet on 11/9/17.
//  Copyright © 2017 Jon Olivet. All rights reserved.
//

import UIKit
import CoreData

class DetailViewController: UIViewController, UITextViewDelegate {
  
  @IBOutlet weak var detailTextView: UITextView!
  
  var note: Note?
  
  // MARK: - Life cycle
  override func viewDidLoad() {
    super.viewDidLoad()
    configureView()
  }
  
  // MARK: - Actions
  func configureView() {
    guard let note = note else {
      return
    }
    detailTextView?.text = note.noteText
  }
}

// MARK: - UITextFieldDelegate
extension DetailViewController: UITextFieldDelegate {
  
  func textViewDidEndEditing( _ textView: UITextView) {
    guard let note = note else { return }
  
    note.noteText = detailTextView.text
    
    do {
      try note.managedObjectContext?.save()
    } catch {
      print("nothing saved.")
    }
  }
  
}
