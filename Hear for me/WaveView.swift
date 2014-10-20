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
    var xOffset:CGFloat = 0

    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect)
    {
        let zeroY:CGFloat = rect.size.height/2
        let maxX:CGFloat = rect.size.width
        let wavePoints:Array<CGPoint> = [
            CGPointMake(maxX * 0.05 + xOffset, zeroY),
            CGPointMake(maxX * 0.10 + xOffset, zeroY),
            CGPointMake(maxX * 0.15 + xOffset, zeroY),
            CGPointMake(maxX * 0.20 + xOffset, zeroY),
            CGPointMake(maxX * 0.25 + xOffset, zeroY),
            CGPointMake(maxX * 0.30 + xOffset, zeroY),
            CGPointMake(maxX * 0.35 + xOffset, zeroY),
            CGPointMake(maxX * 0.40 + xOffset, zeroY),
            CGPointMake(maxX * 0.45 + xOffset, zeroY),
            CGPointMake(maxX * 0.50 + xOffset, zeroY),
            CGPointMake(maxX * 0.55 + xOffset, zeroY),
            CGPointMake(maxX * 0.60 + xOffset, zeroY),
            CGPointMake(maxX * 0.65 + xOffset, zeroY),
            CGPointMake(maxX * 0.70 + xOffset, zeroY),
            CGPointMake(maxX * 0.75 + xOffset, zeroY),
            CGPointMake(maxX * 0.80 + xOffset, zeroY),
            CGPointMake(maxX * 0.85 + xOffset, zeroY),
            CGPointMake(maxX * 0.90 + xOffset, zeroY),
            CGPointMake(maxX * 0.95 + xOffset, zeroY),
            CGPointMake(maxX, zeroY)
        ]
        let waveControls:Array<CGPoint> = [
            CGPointMake(maxX * 0.025 + xOffset, zeroY + 05 * audioLevel),
            CGPointMake(maxX * 0.075 + xOffset, zeroY - 05 * audioLevel),
            CGPointMake(maxX * 0.125 + xOffset, zeroY + 10 * audioLevel),
            CGPointMake(maxX * 0.175 + xOffset, zeroY - 20 * audioLevel),
            CGPointMake(maxX * 0.225 + xOffset, zeroY + 25 * audioLevel),
            CGPointMake(maxX * 0.275 + xOffset, zeroY - 30 * audioLevel),
            CGPointMake(maxX * 0.325 + xOffset, zeroY + 40 * audioLevel),
            CGPointMake(maxX * 0.375 + xOffset, zeroY - 45 * audioLevel),
            CGPointMake(maxX * 0.425 + xOffset, zeroY + 50 * audioLevel),
            CGPointMake(maxX * 0.475 + xOffset, zeroY - 60 * audioLevel),
            CGPointMake(maxX * 0.525 + xOffset, zeroY + 60 * audioLevel),
            CGPointMake(maxX * 0.575 + xOffset, zeroY - 50 * audioLevel),
            CGPointMake(maxX * 0.625 + xOffset, zeroY + 45 * audioLevel),
            CGPointMake(maxX * 0.675 + xOffset, zeroY - 40 * audioLevel),
            CGPointMake(maxX * 0.725 + xOffset, zeroY + 30 * audioLevel),
            CGPointMake(maxX * 0.775 + xOffset, zeroY - 25 * audioLevel),
            CGPointMake(maxX * 0.825 + xOffset, zeroY + 20 * audioLevel),
            CGPointMake(maxX * 0.875 + xOffset, zeroY - 10 * audioLevel),
            CGPointMake(maxX * 0.925 + xOffset, zeroY + 05 * audioLevel),
            CGPointMake(maxX * 0.975 + xOffset, zeroY - 05 * audioLevel)
        ]
        
        /*xOffset = xOffset + (rect.size.width / CGFloat(wavePoints.count) / 5)
        if xOffset > (rect.size.width / CGFloat(wavePoints.count/2)) { xOffset = 0 }*/
        
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
        audioLevel = level * level * level /* y = x^3 is better looking than y = x for the waves */
    }
}
