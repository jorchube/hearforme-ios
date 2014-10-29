//
//  LanguagePanelView.swift
//  Hear for me
//
//  Created by Jordi Chulia on 26/10/14.
//  Copyright (c) 2014 Jordi Chulia. All rights reserved.
//

import UIKit


class BlurView: UIView {

    let settings:Settings = Settings.getSettings()
    
    var blurView: UIVisualEffectView?
    
    func addBlur() {
        
        var blur: UIBlurEffect = UIBlurEffect( style: settings.theme.getBlurEffectStyle())
        
        blurView = UIVisualEffectView(effect: blur)
        blurView!.frame = CGRectMake(0, 0, UIScreen.mainScreen().bounds.width, 64) /* Hardcoded in the storyboard (panel height) */
        /*blurView.frame = CGRectMake(0,
        self.view.frame.maxY - blurHeight,
        self.view.frame.width,
        blurHeight)*/
        self.addSubview(blurView!)
        
        /*
        var vibrancy = UIVibrancyEffect(forBlurEffect: blur)
        var vibrancyView = UIVisualEffectView(effect: vibrancy)
        /*vibrancyView.frame = CGRectMake(0,
        0,
        self.view.frame.width,
        blurHeight)*/
        blurView.addSubview(vibrancyView)
        
        vibrancyView.addSubview(okButton)
        vibrancyView.addSubview(langPicker)
        vibrancyView.addSubview(lineView)
        */
    }

    override init() {
        super.init()
        
        if blurView == nil { self.addBlur() }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        if blurView == nil { self.addBlur() }
    }
   
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        if blurView == nil { self.addBlur() }
    }
    
}


class LanguagesPanelView: UIView {
    
    let settings:Settings = Settings.getSettings()

    var blurView: BlurView?

    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        updateBlurView()
    }
    
    func updateBlurView() {
        let tagNum: Int = 99
        
        blurView = BlurView()
        blurView?.tag = tagNum /* for example */
        
        for v in self.subviews {
            if v.tag != nil && v.tag == tagNum {
                let target = v as UIView
                target.removeFromSuperview()
            }
        }
        
        self.addSubview(blurView!)
    }
    
    override func drawRect(rect: CGRect) {
        var borderLine: CALayer = CALayer() /* no offense */
        borderLine.frame = CGRectMake(0, self.frame.maxY, self.frame.maxX, 1.0)
        borderLine.backgroundColor = settings.theme.getTintColor().CGColor
        self.layer.addSublayer(borderLine)
    }
}













