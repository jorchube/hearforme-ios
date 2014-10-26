//
//  LineView.swift
//  Hear for me
//
//  Created by Jordi Chulia on 26/10/14.
//  Copyright (c) 2014 Jordi Chulia. All rights reserved.
//

import UIKit


class LineView: UIView {
    
    
    let settings:Settings = Settings.getSettings()
    
    override func drawRect(rect: CGRect) {
        var context:CGContextRef = UIGraphicsGetCurrentContext()
        CGContextSetStrokeColorWithColor( context, settings.theme.getTintColor().CGColor)
        
        var line: UIBezierPath = UIBezierPath()
        line.moveToPoint(CGPointMake(0, 0))
        line.addQuadCurveToPoint(CGPointMake(self.frame.maxX, 0),
            controlPoint: CGPointMake(self.frame.midX, 0))
        
        line.lineWidth = 1.0
        line.stroke()
    }
}

