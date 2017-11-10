//
//  LoginViewController.swift
//  KeychainTouchMeIn
//
//  Created by Jon Olivet on 11/9/17.
//  Copyright © 2017 Jon Olivet. All rights reserved.
//

import UIKit
import CoreData

// Keychain Configuration
struct KeychainConfiguration{
  static let serviceName = "TouchMeIn"
  static let accessGroup: String? = nil
}

class LoginViewController: UIViewController {
  
  let touchMe = TouchIDAuth()
  var managedObjectContext: NSManagedObjectContext?
  var passwordItems: [KeychainPasswordItem] = []
  let createLoginButtonTag = 0
  let loginButtonTag = 1
  
  @IBOutlet weak var loginButton: UIButton!
  @IBOutlet weak var usernameTextField: UITextField!
  @IBOutlet weak var passwordTextField: UITextField!
  @IBOutlet weak var createInfoLabel: UILabel!
  @IBOutlet weak var touchIDButton: UIButton!
  
  // MARK: - Life cycle
  override func viewDidLoad() {
    super.viewDidLoad()
    
    let hasLogin = UserDefaults.standard.bool(forKey: "hasLoginKey")
    
    if hasLogin {
      loginButton.setTitle("Login", for: .normal)
      loginButton.tag = loginButtonTag
      createInfoLabel.isHidden = true
    } else {
      loginButton.setTitle("Create", for: .normal)
      loginButton.tag = createLoginButtonTag
      createInfoLabel.isHidden = false
    }
    
    if let storedUsername = UserDefaults.standard.value(forKey: "username") as? String {
      usernameTextField.text = storedUsername
    }
    
    touchIDButton.isHidden = !touchMe.canEvaluatePolicy()
  }
  
  // MARK: - Action for checking username/password
  @IBAction func loginAction(_ sender: AnyObject) {
    // Check that text has been entered into both the username and password fields.
    guard let newAccountName = usernameTextField.text, let newPassword = passwordTextField.text, !newAccountName.isEmpty && !newPassword.isEmpty else {
      let alertView = UIAlertController(title: "Login Problem", message: "Wrong username or password", preferredStyle: .alert)
      let okAction = UIAlertAction(title: "Foiled Again!", style: .default, handler: nil)
      alertView.addAction(okAction)
      present(alertView, animated: true, completion: nil)
      return
    }
    
    usernameTextField.resignFirstResponder()
    passwordTextField.resignFirstResponder()
    
    if sender.tag == createLoginButtonTag {
      let hasLoginKey = UserDefaults.standard.bool(forKey: "hasLoginKey")
      if !hasLoginKey {
        UserDefaults.standard.setValue(usernameTextField.text, forKey: "username")
      }
      
      do {
        // This is a new account, create a new keychain item with the account name
        let passwordItem = KeychainPasswordItem(service: KeychainConfiguration.serviceName, account: newAccountName, accessGroup: KeychainConfiguration.accessGroup)
        
        // Save the password for the new item.
        try passwordItem.savePassword(newPassword)
      } catch {
        fatalError("Error updating keychain - \(error)")
      }
      
      UserDefaults.standard.set(true, forKey: "hasLoginKey")
      loginButton.tag = loginButtonTag
      
      performSegue(withIdentifier: "dismissLogin", sender: self)
    } else if sender.tag == loginButtonTag {
      if checkLogin(username: usernameTextField.text!, password: passwordTextField.text!) {
        performSegue(withIdentifier: "dismissLogin", sender: self)
      } else {
        let alertView = UIAlertController(title: "Login Problem", message: "Wrong username or password.", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Foiled Again", style: .default, handler: nil)
        alertView.addAction(okAction)
        present(alertView, animated: true, completion: nil)
      }
    }
  }
  
  @IBAction func touchIDLoginAction(_ sender: UIButton) {
    
    touchMe.authenticateUser() { (message) in
      if let message = message {
        // if the completion is not nil show an alert
        let alertView = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Darn!", style: .default)
        alertView.addAction(okAction)
        self.present(alertView, animated: true)
      } else {
        self.performSegue(withIdentifier: "dismissLogin", sender: self)
      }
    }
  }
  
  func checkLogin(username: String, password: String) -> Bool {
    guard username == UserDefaults.standard.value(forKey: "username") as? String else {
      return false
    }
    
    do {
      let passwordItem = KeychainPasswordItem(service: KeychainConfiguration.serviceName, account: username, accessGroup: KeychainConfiguration.accessGroup)
      let keychainPassword = try passwordItem.readPassword()
      return password == keychainPassword
    } catch {
      fatalError("Error reading password from keychain - \(error)")
    }
    return false
  }
  
}
