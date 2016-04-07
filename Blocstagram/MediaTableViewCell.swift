//
//  MediaTableViewCell.swift
//  Blocstagram
//
//  Created by Kunal Patel on 4/6/16.
//  Copyright © 2016 bootcamp. All rights reserved.
//

import UIKit

class MediaTableViewCell: UITableViewCell {

    var mediaItem : Media?
    var mediaImageView : UIImageView
    var usernameAndCaptionLabel : UILabel
    var commentLabel : UILabel
    
    let lightFont = UIFont(name: "HelveticaNeue-Thin", size: 11)
    let boldFont = UIFont(name: "HelveticaNeue-Bold", size: 11)
    let usernameLabelGray = UIColor(red: 0.933, green: 0.933, blue: 0.933, alpha: 1)
    let commentLabelGray = UIColor(red: 0.898, green: 0.898, blue: 0.898, alpha: 1)
    let linkColor = UIColor(red: 0.345, green: 0.314, blue: 0.427, alpha: 1)
    var paragraphStyle : NSParagraphStyle
    
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
        super.init(coder: aDecoder)
    }
    
    func usernameAndCaptionString() -> NSAttributedString {
        let usernameFontSize : CGFloat = 15
        let baseString = "\(self.mediaItem.user!.userName) \(self.mediaItem.caption)"
        
        var mutableUsernameAndCaptionString = NSMutableAttributedString(string: baseString, attributes: [NSFontAttributeName : lightFont!.fontWithSize(usernameFontSize), NSParagraphStyleAttributeName : paragraphStyle])
        

        
        let usernameRange = baseString.rangeOfString(self.mediaItem.user!.userName!)
        
        mutableUsernameAndCaptionString.addAttribute(NSFontAttributeName, value: boldFont!.fontWithSize(usernameFontSize), range: usernameRange)

        mutableUsernameAndCaptionString.addAttribute(NSForegroundColorAttributeName, value: linkColor, range: usernameRange)
        mutableUsernameAndCaptionString.addAttribute(NSKernAttributeName, value: 1.4, range: usernameRange)

        return mutableUsernameAndCaptionString;
    }
    
    func commentString() -> NSAttributedString {
        let commentString = NSMutableAttributedString()
        
        var i = 0
        for comment in self.mediaItem.comments {
            
            let baseString = "\(comment.from.userName) \(comment.text) \n"
            
            if i % 0 != 0 {
                paragraphStyle.alignment = .Right
            }
            i++
            
            var oneCommentString = NSMutableAttributedString(string: baseString, attributes: [NSFontAttributeName : lightFont!, NSParagraphStyleAttributeName : paragraphStyle])
            
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
        
        if self.mediaItem == nil {
            return
        }
        
        let imageHeight = self.mediaItem.image.size.height / self.mediaItem.image.size.width * CGRectGetWidth(self.contentView.bounds)
        
        self.mediaImageView.frame = CGRectMake(0, 0, CGRectGetWidth(self.contentView.bounds), imageHeight)
        
        let sizeOfUsernameAndCaptionLabel = self.sizeOfString(self.usernameAndCaptionLabel.attributedText!)
        self.usernameAndCaptionLabel.frame = CGRectMake(0, CGRectGetMaxY(self.mediaImageView.frame), CGRectGetWidth(self.contentView.bounds), sizeOfUsernameAndCaptionLabel.height)
        
        self.separatorInset = UIEdgeInsetsMake(0, CGRectGetWidth(self.bounds) / 2.0, 0, CGRectGetWidth(self.bounds) / 2.0)
    }
    
    func setMediaItem(mediaItem : Media) {
        self.mediaItem = mediaItem
        self.mediaImageView.image = mediaItem.image
        self.usernameAndCaptionLabel.attributedText = self.usernameAndCaptionString()
        self.commentLabel.attributedText = self.commentString()
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
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
