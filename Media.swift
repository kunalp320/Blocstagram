//
//  Media.swift
//  Blocstagram
//
//  Created by Kunal Patel on 4/6/16.
//  Copyright © 2016 bootcamp. All rights reserved.
//

import UIKit

class Media {
    
    var idNumber : String?
    var user : User?
    var mediaURL : NSURL?
    let image : UIImage
    var caption : String?
    var comments : [Comment]?
    
    init(image : UIImage) {
        self.image = image
    }
    
}
