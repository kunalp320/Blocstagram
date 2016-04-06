//
//  Comment.swift
//  Blocstagram
//
//  Created by Kunal Patel on 4/6/16.
//  Copyright © 2016 bootcamp. All rights reserved.
//

class Comment: NSObject {
    
    var idNumber : String
    var from : User
    var text : String

    override init() {
        super.init()
    }
    
}
