//
//  WaveView.swift
//  Hear for me
//
//  Created by Jordi Chulia on 17/10/14.
//  Copyright (c) 2014 Jordi Chulia. All rights reserved.
//

import UIKit

class WaveView: UIView {
    
    let settings:Settings = Settings.getSettings()
    
    var audioLevel:CGFloat = 0

    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect)
    {
        let zeroY:CGFloat = rect.size.height/2
        let maxX:CGFloat = rect.size.width
        let wavePoints:Array<CGPoint> = [
            CGPointMake(maxX * 0.05, zeroY),
            CGPointMake(maxX * 0.10, zeroY),
            CGPointMake(maxX * 0.15, zeroY),
            CGPointMake(maxX * 0.20, zeroY),
            CGPointMake(maxX * 0.25, zeroY),
            CGPointMake(maxX * 0.30, zeroY),
            CGPointMake(maxX * 0.35, zeroY),
            CGPointMake(maxX * 0.40, zeroY),
            CGPointMake(maxX * 0.45, zeroY),
            CGPointMake(maxX * 0.50, zeroY),
            CGPointMake(maxX * 0.55, zeroY),
            CGPointMake(maxX * 0.60, zeroY),
            CGPointMake(maxX * 0.65, zeroY),
            CGPointMake(maxX * 0.70, zeroY),
            CGPointMake(maxX * 0.75, zeroY),
            CGPointMake(maxX * 0.80, zeroY),
            CGPointMake(maxX * 0.85, zeroY),
            CGPointMake(maxX * 0.90, zeroY),
            CGPointMake(maxX * 0.95, zeroY),
            CGPointMake(maxX, zeroY)
        ]
        let waveControls:Array<CGPoint> = [
            CGPointMake(maxX * 0.025, zeroY + 05 * audioLevel),
            CGPointMake(maxX * 0.075, zeroY - 05 * audioLevel),
            CGPointMake(maxX * 0.125, zeroY + 10 * audioLevel),
            CGPointMake(maxX * 0.175, zeroY - 20 * audioLevel),
            CGPointMake(maxX * 0.225, zeroY + 25 * audioLevel),
            CGPointMake(maxX * 0.275, zeroY - 30 * audioLevel),
            CGPointMake(maxX * 0.325, zeroY + 40 * audioLevel),
            CGPointMake(maxX * 0.375, zeroY - 45 * audioLevel),
            CGPointMake(maxX * 0.425, zeroY + 50 * audioLevel),
            CGPointMake(maxX * 0.475, zeroY - 60 * audioLevel),
            CGPointMake(maxX * 0.525, zeroY + 60 * audioLevel),
            CGPointMake(maxX * 0.575, zeroY - 50 * audioLevel),
            CGPointMake(maxX * 0.625, zeroY + 45 * audioLevel),
            CGPointMake(maxX * 0.675, zeroY - 40 * audioLevel),
            CGPointMake(maxX * 0.725, zeroY + 30 * audioLevel),
            CGPointMake(maxX * 0.775, zeroY - 25 * audioLevel),
            CGPointMake(maxX * 0.825, zeroY + 20 * audioLevel),
            CGPointMake(maxX * 0.875, zeroY - 10 * audioLevel),
            CGPointMake(maxX * 0.925, zeroY + 05 * audioLevel),
            CGPointMake(maxX * 0.975, zeroY - 05 * audioLevel)
        ]
        
        var context:CGContextRef = UIGraphicsGetCurrentContext()
        var wave = UIBezierPath()
        
        wave.moveToPoint(CGPointMake(0, zeroY))
        
        for i in 0..<wavePoints.count {
            wave.addQuadCurveToPoint(wavePoints[i], controlPoint: waveControls[i])
        }
        
        CGContextSetStrokeColorWithColor( context, settings.theme.waveColor().CGColor )
    
        //wave.stroke()
        
        CGContextAddPath(context, wave.CGPath)
        CGContextStrokePath(context)
        
        //CGContextFlush(context)
        
    }
    
    func setAudioLevel (level: CGFloat)
    {
        audioLevel = level
    }
}
