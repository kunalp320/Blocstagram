//
//  Media.swift
//  Blocstagram
//
//  Created by Kunal Patel on 4/6/16.
//  Copyright © 2016 bootcamp. All rights reserved.
//

import UIKit

class Media: NSObject {
    
    var idNumber : String
    var user : User
    var mediaURL : NSURL
    var image : UIImage?
    var caption : String
    var comments = []
    
    override init() {
        super.init()
    }
    
}
