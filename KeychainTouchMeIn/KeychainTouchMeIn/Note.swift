//
//  Note.swift
//  KeychainTouchMeIn
//
//  Created by Jon Olivet on 11/9/17.
//  Copyright © 2017 Jon Olivet. All rights reserved.
//

import Foundation
import CoreData

class Note: NSManagedObject {
  
  @NSManaged var noteText: String
  @NSManaged var date: Date
  
}
