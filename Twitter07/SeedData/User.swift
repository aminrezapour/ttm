//
//  User.swift
//  Twitter07
//
//  Created by Amin Rezapour on 11/15/17.
//  Copyright © 2017 Appfish. All rights reserved.
//

import Foundation

class User {
    
    var name : String
    var photo : String
    var listOfTweets : [Tweet]?
    var featured : Bool = false
    
    init(name: String, photo: String) {
        self.name = name
        self.photo = photo
    }
    
}
