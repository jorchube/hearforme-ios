//
//  WaveView.swift
//  Hear for me
//
//  Created by Jordi Chulia on 17/10/14.
//  Copyright (c) 2014 Jordi Chulia. All rights reserved.
//

import UIKit

class WaveView: UIView {

    
    let settings:Settings = Settings()
  
    
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect)
    {
        NSLog("redrawn")
        
        let context:CGContextRef = UIGraphicsGetCurrentContext() // TODO: try to put this outside the function
        
        var wave = CGPathCreateMutable()
        
        CGContextSetFillColorWithColor(context, UIColor.redColor().CGColor )
        CGContextSetStrokeColorWithColor( context, settings.theme.fgColor().CGColor )

        CGContextAddEllipseInRect(context, CGRect(x: 0, y: 0, width: rect.size.height/2, height: rect.size.width/2))
        
        
        CGContextFlush(context)
        
    }
    
    

}
