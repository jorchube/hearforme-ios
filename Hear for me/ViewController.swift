//
//  ViewController.swift
//  Hear for me
//
//  Created by Jordi Chulia on 25/09/14.
//  Copyright (c) 2014 Jordi Chulia. All rights reserved.
//

import UIKit

class ViewController: UIViewController, settingsDelegate {

    @IBOutlet weak var prefButton: UIButton!
    @IBOutlet weak var mainText: UITextView!
    
    let settings:Settings = Settings.getSettings()
    
    var speechRec:speechRecognizer = speechRecognizer()
    
    var continueRecognizing = false
    var wantsAnotherRecognition = false
    
    func setTextSize() {
        mainText.font = mainText.font.fontWithSize( CGFloat(settings.getFontSize()) )
    }
    func setColors() {
        mainText.textColor = settings.theme.fgColor()
        self.view.backgroundColor = settings.theme.bgColor()
    }
    
    func updateUI(textChanged textC: Bool, themeChanged themeC: Bool) {
        if textC {setTextSize()}
        if themeC {setColors()}
    }
    
    func initSpeechRec() {
        speechRec.shouldListen =  0
        speechRec.setup(self)
        speechRec.textview = self.mainText
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view, typically from a nib.
        updateUI(textChanged: true, themeChanged: true)
        //let target = UIScreen.mainScreen().bounds
        //mainText.frame = CGRectMake(target.minX, target.minY, target.width, target.height-400)
    
        mainText.text = NSLocalizedString("TURN_UPSIDE_DOWN", comment: "")
        initSpeechRec()
    }
    
    override func supportedInterfaceOrientations() -> Int {
        return Int(UIInterfaceOrientationMask.All.rawValue)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "PrefSegue" {
            let calledVC = segue.destinationViewController as PreferencesViewController
            calledVC.delegate = self
        }
        
    }
    
    func periodicRecognition() {
        NSLog("Starting periodic recognition")
        while(continueRecognizing) {
            if(speechRec.status == IDLE && wantsAnotherRecognition == true) {
                speechRec.startRecognition()
            }
        }
        NSLog("End periodic recognition")
    }
    
    
    override func didRotateFromInterfaceOrientation(fromInterfaceOrientation: UIInterfaceOrientation) {
        if fromInterfaceOrientation.rawValue == UIInterfaceOrientation.Portrait.rawValue {
            /* was portrait, now upside down */
            NSLog("Orientation from normal to upside down")
            mainText.text = ""
            continueRecognizing = true
            wantsAnotherRecognition = true
            prefButton.hidden = true
            
            let thread = NSThread(target: self, selector: "periodicRecognition", object: nil)
            thread.start()
        }
        else {
            /* back to normal */
            prefButton.hidden = false
            
            continueRecognizing = false
            speechRec.cancelRecognition()
            mainText.text = NSLocalizedString("TURN_UPSIDE_DOWN", comment: "")
            //mainText.sizeToFit()
            NSLog("Orientation again normal")
        }
    }
    
    
    func finishedRecognizing()
    {
        NSLog("Finished recognizing one stream")
        if (continueRecognizing) {
            wantsAnotherRecognition = true
        }
        else { wantsAnotherRecognition = false }
    }
    
    func useNewSettings() {
        /*
            Conforms to the settingsDelegate protocol.
            Called from the preferencesViewController.
        */
        updateUI(textChanged: true, themeChanged: true)
    }

    
    
}
