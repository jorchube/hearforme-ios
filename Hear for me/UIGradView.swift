//
//  UIGradView.swift
//  Hear for me
//
//  Created by Jordi Chulia on 26/10/14.
//  Copyright (c) 2014 Jordi Chulia. All rights reserved.
//


class UIGradView: UIView, UITextViewDelegate {
    
    let settings:Settings = Settings.getSettings()
    
    override func drawRect(rect: CGRect)
    {
        var context:CGContextRef = UIGraphicsGetCurrentContext()
        
        let colorspace = CGColorSpaceCreateDeviceRGB()
        let components = CGColorGetComponents(settings.theme.bgColor().CGColor)
        
        CGContextSetAlpha(context, 1.0)
        let gradient = CGGradientCreateWithColorComponents(
            CGColorSpaceCreateDeviceRGB(),
            [
                components[0], components[1], components[2], 0, /* Set this alpha to 1 if LanguagesBar gets ditched */
                components[0], components[1], components[2], 0,
                components[0], components[1], components[2], 0,
                components[0], components[1], components[2], 1
            ],
            [0, 0.025, 0.975, 1],
            4)
        
        CGContextDrawLinearGradient(
            context,
            gradient,
            CGPointMake(0, 0),
            CGPointMake(0, rect.height),
            0
        )
    }
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        self.frame.origin = CGPoint(x: 0, y: scrollView.contentOffset.y)
    }
}

