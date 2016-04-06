//
//  DataSource.swift
//  Blocstagram
//
//  Created by Kunal Patel on 4/6/16.
//  Copyright © 2016 bootcamp. All rights reserved.
//

import UIKit

class DataSource: NSObject {

    static let sharedInstance = DataSource()
    var mediaItems = [Media]
    
    
    override init() {
        super.init()
        self.addRandomData()
    }
    
    func randomStringOfLength(length : Int) -> String {
        let alphabet  = "abcdefghijklmnopqrstuvwxyz";
        
        var s = ""
        for _ in 0..<length {
            let r = arc4random_uniform(UInt32(alphabet.characters.count))
            let c = (alphabet as NSString).characterAtIndex(Int(r))
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

        var randomSentence = ""
        
        for _ in 0...wordCount {
            randomSentence += "\(randomStringOfLength(Int(arc4random_uniform(12)) + 2))"
        }
        return randomSentence
    }
    
    func randomComment() -> Comment {
        let comment = Comment()
        comment.from = self.randomUser()
        comment.text = self.randomSentence()
        
        return comment
    }
    
    func addRandomData() {
        var randomMediaItems : [Media]
        
        for i in 1...10 {
            let imageName = "\(i).jpg"
            let image : UIImage? = UIImage(imageLiteral: imageName)
            
            if image != nil {
                let media = Media()
                media.user = self.randomUser()
                media.image = image
                media.caption = self.randomSentence()
                
                let commentCount = Int(arc4random_uniform(10)) + 2
                var randomComments : [Comment]
                
                for _ in 0...commentCount {
                    let randomComment = self.randomComment()
                    randomComments.append(randomComment)
                }
                
                media.comments = randomComments
                randomMediaItems.append(media)
            }

        }
        self.mediaItems = randomMediaItems

    }
    
}
