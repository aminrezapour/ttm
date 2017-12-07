//
//  Tweet.swift
//  Twitter07
//
//  Created by Amin Rezapour on 11/15/17.
//  Copyright © 2017 Appfish. All rights reserved.
//

import Foundation

class Tweet {
    
    var text : String
    var time : String
    var user : User
    var image : String?
    
    init(text: String, time: String, user: User){
        self.text = text
        self.user = user
        self.time = time
    }
    
    init(text: String, time: String, user: User, image: String){
        self.text = text
        self.user = user
        self.time = time
        self.image = image
    }
}
