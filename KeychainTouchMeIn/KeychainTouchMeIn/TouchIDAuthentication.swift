//
//  TouchIDAuthentication.swift
//  KeychainTouchMeIn
//
//  Created by Jon Olivet on 11/9/17.
//  Copyright © 2017 Jon Olivet. All rights reserved.
//

import LocalAuthentication

class TouchIDAuth {
  
  let context = LAContext()
  
  func canEvaluatePolicy() -> Bool {
    return context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: nil)
  }
  
  func authenticateUser(completion: @escaping (String?) -> Void) {
    guard canEvaluatePolicy() else {
      completion("Touch ID not available")
      return
    }
    context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: "Logging in with Touch ID") { (success, evaluateError) in
      if success {
        DispatchQueue.main.async {
          // User authenticated successfully, take appropriate action
          completion(nil)
        }
      } else {
        let message: String
        
        switch evaluateError {
        case LAError.authenticationFailed?:
          message = "There was a problem verifying your identity."
        case LAError.userCancel?:
          message = "You pressed cancel."
        case LAError.userFallback?:
          message = "You pressed password."
        case LAError.touchIDNotAvailable?:
          message = "The device isn’t Touch ID-compatible."
        default:
          message = "Touch ID may not be configured"
        }
        completion(message)
      }
    }
  }
  
}
