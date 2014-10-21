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
    
    var xOffset:CGFloat = 0
    
    var audioLevel:CGFloat = 0

    
    func createWaveInRect(rect:CGRect) -> UIBezierPath
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
        var waveControls:Array<CGPoint> = [
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
        
        var wave:UIBezierPath = UIBezierPath()
        wave.moveToPoint(CGPointMake(0, zeroY))
        
        for i in 0..<wavePoints.count {
            wave.addQuadCurveToPoint(wavePoints[i], controlPoint: waveControls[i])
        }
        
        return wave
    }
    
    
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect)
    {
        var context:CGContextRef = UIGraphicsGetCurrentContext()
        CGContextSetStrokeColorWithColor( context, settings.theme.waveColor().CGColor)
        
        CGContextAddPath(context, createWaveInRect(rect).CGPath)
        CGContextDrawPath(context, kCGPathStroke)
        
        audioLevel = audioLevel/1.5
        CGContextSetAlpha(context, 0.5)
        CGContextAddPath(context, createWaveInRect(rect).CGPath)
        CGContextDrawPath(context, kCGPathStroke)
        
        audioLevel = audioLevel/2
        CGContextSetAlpha(context, 0.25)
        CGContextAddPath(context, createWaveInRect(rect).CGPath)
        CGContextDrawPath(context, kCGPathStroke)
        
        audioLevel = audioLevel/3
        CGContextSetAlpha(context, 0.1)
        CGContextAddPath(context, createWaveInRect(rect).CGPath)
        CGContextDrawPath(context, kCGPathStroke)
        
        let colorspace = CGColorSpaceCreateDeviceRGB()        
        let components = CGColorGetComponents(settings.theme.bgColor().CGColor)
        
        CGContextSetAlpha(context, 1.0)
        let gradient = CGGradientCreateWithColorComponents(
            CGColorSpaceCreateDeviceRGB(),
            [
                components[0], components[1], components[2], 1,
                components[0], components[1], components[2], 0,
                components[0], components[1], components[2], 0,
                components[0], components[1], components[2], 1
            ],
            [0, 0.2, 0.8, 1],
            4)
        
       CGContextDrawLinearGradient(
            context,
            gradient,
            CGPointMake(0, 0),
            CGPointMake(rect.width, 0),
            0
        )
    }
    
    func setAudioLevel (level: CGFloat)
    {
        /* y = 2x^4 is a nice fit */
        audioLevel = 2*(level * level * level * level)
    }
}




