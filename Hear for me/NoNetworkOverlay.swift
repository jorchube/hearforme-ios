//
//  NoNetworkOverlay.swift
//  Hear for me
//
//  Created by Jordi Chulia on 30/10/14.
//  Copyright (c) 2014 Jordi Chulia. All rights reserved.
//

import UIKit

class NoNetworkOverlayView: UIView {

    var initialized : Bool = false
    
    var message: UITextView?
    var imageView: UIButton?
    
    func initialize(frame: CGRect) {
        if initialized { return }
        
        message = UITextView(frame: CGRect(
            x: frame.width * 1/10,
            y: frame.height * 1/10,
            width: frame.width * 8/10,
            height: frame.height * 8/10))
        
        message!.text = NSLocalizedString("NETWORK_ERROR_MESSAGE", comment: "")
        message!.textColor = UIColor.lightTextColor()
        message!.font = message!.font.fontWithSize(16)
        message!.backgroundColor = UIColor.clearColor()
        message!.textAlignment = NSTextAlignment.Center
        message!.editable = false
        
        var image = UIImage(named: "sad_cloud.png")
        
        //let imageView: UIImageView = UIImageView(image: image)
        imageView = UIButton(frame: CGRect(
            x: frame.width * 3/10,
            y: frame.height * 5/10,
            width: frame.width * 4/10,
            height: frame.height * 4/10) )
        imageView!.setImage(image, forState: UIControlState.allZeros)
        imageView!.contentMode = UIViewContentMode.ScaleAspectFit
        imageView!.alpha = 0.6
        
        imageView!.addTarget(self,
            action: "yaaaaaay:",
            forControlEvents: UIControlEvents.TouchDownRepeat)


        var blur = UIBlurEffect( style: UIBlurEffectStyle.Dark)
        var blurView = UIVisualEffectView(effect: blur)
        blurView.frame = frame
        self.addSubview(blurView)
        
        var vibrancy = UIVibrancyEffect(forBlurEffect: blur)
        var vibrancyView = UIVisualEffectView(effect: vibrancy)
        vibrancyView.frame = frame
        blurView.addSubview(vibrancyView)
        
        vibrancyView.addSubview(message!)
        vibrancyView.addSubview(imageView!)
        
        initialized = true
    }
    
    override init() {
        super.init()
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        initialize(frame)
    }

    
    // MARK: - LOL...
    
    
    func smoothShow(object: UIView, duration: NSTimeInterval) {
        if !object.hidden { return }
        
        object.alpha = 0
        object.hidden = false
        UIView.animateWithDuration(duration, animations: {object.alpha = 1})
        object.alpha = 1
    }
    
    func smoothKill(object: UIView, duration: NSTimeInterval) {
        if object.hidden { return }
        
        var image = UIImage(named: "cartoon_rainbow.png")
        (object as UIButton).setImage(image, forState: UIControlState.allZeros)
        
        object.alpha = 1
        //UIView.animateWithDuration(duration, animations: {object.alpha = 0})
        UIView.animateWithDuration(duration,
            animations: {object.alpha = 0},
            completion: {Bool in object.removeFromSuperview()})
        
        respawn()
    }
    
    
    
    func createMiniButton(frame: CGRect/*, point: CGPoint*/) {
        
        let image = UIImage(named: "sad_cloud.png")
        
        let but = UIButton(frame: CGRect(
            x: frame.origin.x,
            y: frame.origin.y,
            width: frame.width,
            height: frame.height) )
        but.setImage(image, forState: UIControlState.allZeros)
        but.contentMode = UIViewContentMode.ScaleAspectFit
        but.alpha = 0.6
        
        but.addTarget(self,
            action: "yaaaaaay:",
            forControlEvents: UIControlEvents.TouchDown)
        
        self.addSubview(but)
        
    }
    
    func randomBetweenNumbers(firstNum: CGFloat, secondNum: CGFloat) -> CGFloat{
        return CGFloat(arc4random()) / CGFloat(UINT32_MAX) * abs(firstNum - secondNum) + min(firstNum, secondNum)
    }
    
    func respawn() {
        let frame: CGRect = UIScreen.mainScreen().bounds

        var side1: CGFloat = randomBetweenNumbers(20.0, secondNum: frame.width/2)
        if side1 < 20 { side1 += 20}
        let position1: CGRect = CGRectMake(
            randomBetweenNumbers(20, secondNum: frame.width - 20),
            randomBetweenNumbers(20, secondNum: frame.height - 20),
            side1,
            side1)
        
        
        var side2: CGFloat = randomBetweenNumbers(20.0, secondNum: frame.width/2)
        if side2 < 20 { side2 += 20}
        let position2: CGRect = CGRectMake(
            randomBetweenNumbers(20, secondNum: frame.width - 20),
            randomBetweenNumbers(20, secondNum: frame.height - 20),
            side2,
            side2)
        
        createMiniButton(position1)

        if randomBetweenNumbers(0, secondNum: 1) >= 0.5  {createMiniButton(position2)}
        
        
    }
    
    
    func kill(object: UIView) {
        
        let frame: CGRect = object.frame
        smoothKill(object, duration: 2)
        //smoothKill(createRainbow(frame), duration: 1)
    }
    
    func yaaaaaay(sender: UIView ) {
        NSLog("yaay")
        
        kill(sender)
        
    }
    
    
}
