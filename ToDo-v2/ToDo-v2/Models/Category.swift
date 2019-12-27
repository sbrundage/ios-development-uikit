//
//  Category.swift
//  ToDo-v2
//
//  Created by Stephen Brundage on 12/18/19.
//  Copyright © 2019 Stephen Brundage. All rights reserved.
//

import Foundation
import RealmSwift

class Category: Object {
    @objc dynamic var name = ""
    let items = List<ToDoItem>()
}
