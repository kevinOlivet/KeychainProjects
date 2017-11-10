//
//  ViewController.swift
//  KeychainLocksmith
//
//  Created by Jon Olivet on 11/10/17.
//  Copyright © 2017 Jon Olivet. All rights reserved.
//

import UIKit
import Locksmith

class ViewController: UIViewController {
  
  @IBOutlet weak var userAccountLabel: UILabel!
  @IBOutlet weak var keyLabel: UILabel!
  @IBOutlet weak var valueLabel: UILabel!
  @IBOutlet weak var statusLabel: UILabel!
  
  override func viewDidLoad() {
    super.viewDidLoad()
  }
  
  // MARK: - Actions
  @IBAction func saveToKeychainTapped(_ sender: UIButton) {
    do {
      try Locksmith.saveData(data: ["password" : "fsdfsdfds"], forUserAccount: "userAccount")
      userAccountLabel.text = "UserAccount:  userAccount"
      keyLabel.text = "Key:  password"
      valueLabel.text = "Value:  fsdfsdfds"
      statusLabel.text = "Status:  Data successfully saved"
    } catch {
      configureFail(statusMessage: "Status: Error: \(error)")
      print(error)
    }
  }
  
  @IBAction func retrieveFromKeychainTapped(_ sender: UIButton) {
    if let dictionary = Locksmith.loadDataForUserAccount(userAccount: "userAccount") {
      userAccountLabel.text = "UserAccount:  userAccount"
      keyLabel.text = "Key:  \(dictionary.keys.first!)"
      valueLabel.text = "Value:  \(dictionary.values.first!)"
      statusLabel.text = "Status:  Data successfully retrieved"
      print(dictionary)
    } else {
      configureFail(statusMessage: "Status: Nothing saved")
    }
  }
  
  @IBAction func updateToKeychainTapped(_ sender: UIButton) {
    do {
      try Locksmith.updateData(data: ["password" : "esereav"], forUserAccount: "userAccount")
      userAccountLabel.text = "UserAccount:  userAccount"
      keyLabel.text = "Key:  password"
      valueLabel.text = "Value:  esereav"
      statusLabel.text = "Status:  Data successfully updated"
    } catch  {
      statusLabel.text = "Status:  Couldn't update data"
      print(error)
    }
  }
  
  @IBAction func deleteFromKeychainTapped(_ sender: UIButton) {
    do {
      try Locksmith.deleteDataForUserAccount(userAccount: "userAccount")
      userAccountLabel.text = "UserAccount:"
      keyLabel.text = "Key:"
      valueLabel.text = "Value:"
      statusLabel.text = "Status:  Data successfully deleted"
    } catch {
      statusLabel.text = "Status:  Couldn't delete data"
      print(error)
    }
  }
  
  func configureFail(statusMessage: String) {
    userAccountLabel.text = "UserAccount:"
    keyLabel.text = "Key: "
    valueLabel.text = "Value: "
    statusLabel.text = statusMessage
  }
  
}
