//
//  DataSource.swift
//  Blocstagram
//
//  Created by Kunal Patel on 4/6/16.
//  Copyright © 2016 bootcamp. All rights reserved.
//

import UIKit

class DataSource {

    static let sharedInstance = DataSource()
    var mediaItems = [Media]()
    
    
    init() {
        self.addRandomData()
    }
    
    
    func delete(indexToDelete : Int) {
        self.mediaItems.removeAtIndex(indexToDelete)
    }
    
    func randomStringOfLength(length : Int) -> String {
        let alphabet  = Array("abcdefghijklmnopqrstuvwxyz".characters);
        
        var s = ""
        for _ in 0..<length {
            let r = Int(arc4random_uniform(UInt32(alphabet.count)))
            let c = alphabet[r]
            s += "\(c)"
        }
        return s
    }
    
    func randomUser() -> User {
        
        let user = User()
        user.userName = randomStringOfLength(Int(arc4random_uniform(10)) + 2)
        user.fullName = "\(randomStringOfLength(Int(arc4random_uniform(7)) + 2)) \(randomStringOfLength(Int(arc4random_uniform(12)) + 2))"
        
        return user;
        
    }
    
    func randomSentence() -> String {
        let wordCount = arc4random_uniform(20) + 2;

        let randomSentence = (0...wordCount).map({_ in
          randomStringOfLength(Int(arc4random_uniform(12)) + 2)
        }).joinWithSeparator("")
    
        return randomSentence
    }
    
    func randomComment() -> Comment {
        let comment = Comment()
        comment.from = self.randomUser()
        comment.text = self.randomSentence()
        
        return comment
    }
    
    func addRandomData() {
        var randomMediaItems : [Media] = []

        let images = (1...10).map({"\($0).jpg"}).map({UIImage(named: $0)}).filter({$0 != nil}).map({$0!})
        
        for image in images {
            let media = Media(image: image)
            media.user = self.randomUser()
            media.caption = self.randomSentence()
                
            let commentCount = Int(arc4random_uniform(10)) + 2
            let randomComments = (0...commentCount).map({_ in self.randomComment()})
            
                
            media.comments = randomComments
            randomMediaItems.append(media)
        }
        self.mediaItems = randomMediaItems
    }
    
}
