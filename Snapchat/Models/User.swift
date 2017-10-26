//
//  User.swift
//  Snapchat
//
//  Created by Matheus Lima on 25/10/17.
//  Copyright © 2017 Matheus Lima. All rights reserved.
//

import Foundation

class User {
    
    var email: String
    var nome: String
    var uid: String
    
    init(email: String, nome: String, uid: String) {
        self.email = email
        self.nome = nome
        self.uid = uid
    }
}
