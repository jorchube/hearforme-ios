//
//  LanguagePanelView.swift
//  Hear for me
//
//  Created by Jordi Chulia on 26/10/14.
//  Copyright (c) 2014 Jordi Chulia. All rights reserved.
//

import UIKit

class LanguagesPanelView: UIVisualEffectView {
    
    let settings:Settings = Settings.getSettings()
    
    override func drawRect(rect: CGRect) {
/*        var context:CGContextRef = UIGraphicsGetCurrentContext()
        CGContextSetStrokeColorWithColor( context, UIColor.blueColor().CGColor)
        
        var line: UIBezierPath = UIBezierPath()
        line.moveToPoint(CGPointMake(0, self.frame.maxY))
        line.addQuadCurveToPoint(CGPointMake(self.frame.maxX, self.frame.maxY),
            controlPoint: CGPointMake(self.frame.midX, self.frame.maxY))
        
        line.lineWidth = 10.0
        line.stroke()*/

        var layer: CALayer = CALayer()
        layer.frame = CGRectMake(0, self.frame.maxY, self.frame.maxX, 1.5)
        layer.backgroundColor = settings.theme.getTintColor().CGColor
        self.layer.addSublayer(layer)
    }

}
