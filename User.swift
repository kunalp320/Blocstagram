//
//  User.swift
//  Blocstagram
//
//  Created by Kunal Patel on 4/6/16.
//  Copyright © 2016 bootcamp. All rights reserved.
//

import UIKit

class User: NSObject {
    
    var idNumber : String
    var userName : String
    var fullName : String
    var profilePictureURL : NSURL
    var profilePicture : UIImage?
    
    override init() {
        super.init()
    }

}
