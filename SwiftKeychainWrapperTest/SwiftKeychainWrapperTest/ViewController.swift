//
//  ViewController.swift
//  SwiftKeychainWrapperTest
//
//  Created by Jon Olivet on 11/10/17.
//  Copyright © 2017 Jon Olivet. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
  
  @IBOutlet weak var passwordTextField: UITextField!
  @IBOutlet weak var retrievedPasswordLabel: UILabel!
  
  override func viewDidLoad() {
    super.viewDidLoad()
  }
  
  // MARK: - Actions
  @IBAction func savePasswordButtonTapped(_ sender: UIButton) {
    if let password = passwordTextField.text, password != "" {
      let saveSuccessful: Bool = KeychainWrapper.standard.set(password, forKey: "userPassword")
      print("Save was successful: \(saveSuccessful)")
      self.view.endEditing(true)
    } else {
      print("Enter password")
    }
  }
  
  @IBAction func retrievePasswordButtonTapped(_ sender: UIButton) {
    if let retrievedPassword = KeychainWrapper.standard.string(forKey: "userPassword") {
      retrievedPasswordLabel.text = retrievedPassword
    } else {
      retrievedPasswordLabel.text = "No password set yet."
    }
  }
  
  @IBAction func deletePasswordButtonTapped(_ sender: UIButton) {
    let removeSuccessful: Bool = KeychainWrapper.standard.removeObject(forKey: "userPassword")
    if removeSuccessful {
      print("remove was successful: \(removeSuccessful)")
      retrievedPasswordLabel.text = "Password Deleted"
    }
  }
  
}
