//
//  UserModel.swift
//  InstagramClone
//
//  Created by Stephen Brundage on 7/13/20.
//  Copyright © 2020 Stephen Brundage. All rights reserved.
//

import Foundation
import UIKit

struct User {
    var name: String
    var profileImage: UIImage
}

class UsersModel {
    var users: [User] = [User]()
    
    init() {
        createUsers()
    }
    
    private func createUsers() {
        let user1 = User(name: "Steve Brundage", profileImage: UIImage(named: "user1")!)
        let user2 = User(name: "Allie Angulo", profileImage: UIImage(named: "user2")!)
        
        users.append(user1)
        users.append(user2)
    }
}
