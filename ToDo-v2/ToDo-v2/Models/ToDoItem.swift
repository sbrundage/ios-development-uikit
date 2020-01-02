//
//  ToDoItem.swift
//  ToDo-v2
//
//  Created by Stephen Brundage on 12/18/19.
//  Copyright © 2019 Stephen Brundage. All rights reserved.
//

import Foundation
import RealmSwift

class ToDoItem: Object {
    @objc dynamic var title = ""
    @objc dynamic var done = false
    @objc dynamic var dateCreated: Date?
    @objc dynamic var info: String?
    var parentCategory = LinkingObjects(fromType: Category.self, property: "items")
}
