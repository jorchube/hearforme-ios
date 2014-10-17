//
//  ViewController.swift
//  Hear for me
//
//  Created by Jordi Chulia on 25/09/14.
//  Copyright (c) 2014 Jordi Chulia. All rights reserved.
//

import UIKit
import SystemConfiguration



class ViewController: UIViewController, settingsDelegate {

    @IBOutlet weak var prefButton: UIButton!
    @IBOutlet weak var mainText: UITextView!
    @IBOutlet weak var hearButton: UIButton!
    
    let settings:Settings = Settings.getSettings()
    
    var speechRec:speechRecognizer = speechRecognizer()
    
    var continueRecognizing = false /* Recognition is over antd the device is back at its normal orientation */
    var wantsAnotherRecognition = false /* Partial pause of the recognition process */
    
    
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
        hearButton.hidden = true
        initSpeechRec()
    }
    
    override func supportedInterfaceOrientations() -> Int {
        // return Int(UIInterfaceOrientationMask.All.rawValue) /* Xcode 6.1 */
        return Int( UIInterfaceOrientationMask.All.toRaw() ) /* Xcode 6.0 */
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
        
        speechRec.setHearingLanguage(settings.language.getHearingValue(),
            translatingLanguage: settings.language.getTranslatingValue(),
            wantsTranslation: settings.wantsTranslation.boolValue)
        
        while(continueRecognizing) {
            if(speechRec.status == IDLE && wantsAnotherRecognition == true) {
                speechRec.startRecognitionLanguage()
            }
        }
        NSLog("End periodic recognition")
    }
    
    
    override func didRotateFromInterfaceOrientation(fromInterfaceOrientation: UIInterfaceOrientation) {
        //if fromInterfaceOrientation.rawValue == UIInterfaceOrientation.Portrait.rawValue { /* Xcode 6.1 */
        if fromInterfaceOrientation.toRaw() == UIInterfaceOrientation.Portrait.toRaw() { /* Xcode 6.0 */
            /* was portrait, now upside down */
            NSLog("Orientation from normal to upside down")
            mainText.text = ""
            continueRecognizing = true
            wantsAnotherRecognition = true
            prefButton.hidden = true
            hearButton.hidden = false
            
            let thread = NSThread(target: self, selector: "periodicRecognition", object: nil)
            thread.start()
        }
        else {
            /* back to normal */
            prefButton.hidden = false
            hearButton.hidden = true
            
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
        settings.saveSettings()
        updateUI(textChanged: true, themeChanged: true)
    }
    
    @IBAction func hearButtonPressed(sender: AnyObject) {
        wantsAnotherRecognition = !wantsAnotherRecognition
    }
}








