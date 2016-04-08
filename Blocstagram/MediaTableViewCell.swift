//
//  MediaTableViewCell.swift
//  Blocstagram
//
//  Created by Kunal Patel on 4/6/16.
//  Copyright © 2016 bootcamp. All rights reserved.
//

import UIKit


private let lightFont = UIFont(name: "HelveticaNeue-Thin", size: 11)
private let boldFont = UIFont(name: "HelveticaNeue-Bold", size: 11)
private let usernameLabelGray = UIColor(red: 0.933, green: 0.933, blue: 0.933, alpha: 1)
private let commentLabelGray = UIColor(red: 0.898, green: 0.898, blue: 0.898, alpha: 1)
private let linkColor = UIColor(red: 0.345, green: 0.314, blue: 0.427, alpha: 1)

class MediaTableViewCell: UITableViewCell {


    var mediaImageView : UIImageView
    var usernameAndCaptionLabel : UILabel
    var commentLabel : UILabel
    
    var mediaItem : Media? {
        didSet {
            self.mediaImageView.image = mediaItem?.image ?? nil
            self.usernameAndCaptionLabel.attributedText = self.usernameAndCaptionString()
            self.commentLabel.attributedText = self.commentString()
        }
    }
    
    var isOrange : Bool = false {
        didSet {
            updateLabel()
        }
    }
    
    func updateLabel() {
        
    }
    
    var paragraphStyle : NSMutableParagraphStyle
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {

        self.mediaImageView = UIImageView()
        
        self.usernameAndCaptionLabel = UILabel()
        self.usernameAndCaptionLabel.numberOfLines = 0
        self.usernameAndCaptionLabel.backgroundColor = usernameLabelGray
        
        self.commentLabel = UILabel()
        self.commentLabel.numberOfLines = 0 
        self.commentLabel.backgroundColor = commentLabelGray

        let mutableParagraphStyle = NSMutableParagraphStyle()
        mutableParagraphStyle.headIndent = 20.0
        mutableParagraphStyle.firstLineHeadIndent = 20.0
        mutableParagraphStyle.tailIndent = -20.0
        mutableParagraphStyle.paragraphSpacingBefore = 5
        
        paragraphStyle = mutableParagraphStyle
        
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.contentView.addSubview(self.mediaImageView)
        self.contentView.addSubview(self.usernameAndCaptionLabel)
        self.contentView.addSubview(self.commentLabel)

    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func usernameAndCaptionString() -> NSAttributedString {
        
        guard let mediaItem = self.mediaItem, caption = mediaItem.caption, username = mediaItem.user?.userName else {
            return NSAttributedString(string: "")
        }
        
        let usernameFontSize : CGFloat = 15
        
        let baseString = "\(username) \(caption)" as NSString
        
        let mutableUsernameAndCaptionString = NSMutableAttributedString(string: baseString as String, attributes: [NSFontAttributeName : lightFont!.fontWithSize(usernameFontSize), NSParagraphStyleAttributeName : paragraphStyle])
        
        
        let usernameRange = baseString.rangeOfString(username)
        
        mutableUsernameAndCaptionString.addAttribute(NSFontAttributeName, value: boldFont!.fontWithSize(usernameFontSize), range:usernameRange)

        mutableUsernameAndCaptionString.addAttribute(NSForegroundColorAttributeName, value: linkColor, range: usernameRange)
        mutableUsernameAndCaptionString.addAttribute(NSKernAttributeName, value: 1.4, range: usernameRange)

        return mutableUsernameAndCaptionString;
    }
    
    func commentString() -> NSAttributedString {
        let commentString = NSMutableAttributedString()
        
        guard let comments = self.mediaItem?.comments else {
            return NSAttributedString(string: "")
        }
        
        var i = 0
        for comment in comments {
            
            let baseString = "\(comment.from.userName) \(comment.text) \n" as NSString
            
            if i % 2 != 0 {
                paragraphStyle.alignment = .Right
            }
            i += 1
            
            let oneCommentString = NSMutableAttributedString(string: baseString as String, attributes: [NSFontAttributeName : lightFont!, NSParagraphStyleAttributeName : paragraphStyle])
            
            let usernameRange = baseString.rangeOfString(comment.from.userName!)
            oneCommentString.addAttribute(NSAttachmentAttributeName, value: boldFont!, range: usernameRange)
            oneCommentString.addAttribute(NSForegroundColorAttributeName, value: linkColor, range: usernameRange)
            
            commentString.appendAttributedString(oneCommentString)
        }
        return commentString
    }


    func sizeOfString(string : NSAttributedString) -> CGSize {
        let maxSize = CGSizeMake(CGRectGetWidth(self.contentView.bounds) - 40, 0.0)
        var sizeRect = string.boundingRectWithSize(maxSize, options: NSStringDrawingOptions.UsesLineFragmentOrigin, context: nil)
        
        sizeRect.size.height += 20
        sizeRect = CGRectIntegral(sizeRect)
        return sizeRect.size
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        guard let mediaItem = self.mediaItem else {
            return
        }
        
        let imageHeight = mediaItem.image.size.height / mediaItem.image.size.width * CGRectGetWidth(self.contentView.bounds)
        
        self.mediaImageView.frame = CGRectMake(0, 0, CGRectGetWidth(self.contentView.bounds), imageHeight)
        
        let sizeOfUsernameAndCaptionLabel = self.sizeOfString(self.usernameAndCaptionLabel.attributedText!)
        self.usernameAndCaptionLabel.frame = CGRectMake(0, CGRectGetMaxY(self.mediaImageView.frame), CGRectGetWidth(self.contentView.bounds), sizeOfUsernameAndCaptionLabel.height)
        
       // self.separatorInset = UIEdgeInsetsMake(0, CGRectGetWidth(self.bounds) / 2.0, 0, CGRectGetWidth(self.bounds) / 2.0)
    }
    
    class func heightForMediaItem(mediaItem : Media, width : CGFloat) -> CGFloat {
        //Make a cell
        let layoutCell = MediaTableViewCell(style: .Default, reuseIdentifier: "layoutCell")
        
        //Give is max height
        layoutCell.frame = CGRectMake(0, 0, width, CGFloat.max)
        layoutCell.mediaItem = mediaItem
        //layout the cell
        layoutCell.layoutSubviews()
        
        //Return the height of the last item (comment label)
        return CGRectGetMaxY(layoutCell.commentLabel.frame)
        
    }
    
}
