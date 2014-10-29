//
//  UIArrowButton.swift
//  Hear for me
//
//  Created by Jordi Chulia on 29/10/14.
//  Copyright (c) 2014 Jordi Chulia. All rights reserved.
//

import UIKit

class UIArrowButton: UIButton {

    let settings:Settings = Settings.getSettings()
    
    override init() {
        super.init()
        
        self.setTitle(nil, forState: UIControlState.allZeros)
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        self.setTitle(nil, forState: UIControlState.allZeros)
    }
    
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        
        let totalLength: CGFloat = 20
        let headWidth: CGFloat = 6
        let headLength: CGFloat = 5
        
        let context: CGContextRef = UIGraphicsGetCurrentContext()
        let orig: CGPoint = CGPointMake(rect.midX - totalLength/2, rect.midY)
        
        /* -10 because the total length is 20*/
        
        //let orig: CGPoint = CGPointMake(0, 0)
        
        var path: CGMutablePathRef = CGPathCreateMutable()
        CGPathMoveToPoint(path, nil, orig.x, orig.y)
        CGPathAddLineToPoint(path, nil,
            orig.x + totalLength,
            orig.y)
        CGPathAddLineToPoint(path, nil,
            orig.x + totalLength - headLength,
            orig.y + headWidth/2)
        CGPathAddLineToPoint(path, nil,
            orig.x + totalLength - headLength,
            orig.y - headWidth/2)
        CGPathAddLineToPoint(path, nil,
            orig.x + totalLength,
            orig.y)
        
        CGContextSetLineWidth(context, 2)
        CGContextSetLineJoin(context, kCGLineJoinRound)
        CGContextSetFillColorWithColor(context,
            settings.theme.getTintColor().CGColor)
        CGContextSetStrokeColorWithColor(context,
            settings.theme.getTintColor().CGColor)
        
        CGContextAddPath(context, path)
        CGContextDrawPath(context, kCGPathFillStroke)
        
    }
    

}
