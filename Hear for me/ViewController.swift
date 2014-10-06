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
    
    let speechRec:speechRecognizer = speechRecognizer()
    
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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view, typically from a nib.
        updateUI(textChanged: true, themeChanged: true)
        
        mainText.text = "Turn your phone upside down to start listening"
        
        speechRec.shouldListen =  0
        speechRec.textview = self.mainText
        speechRec.setup()
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
    
    func continueRecognizing() {
        if speechRec.shouldListen == 1 {
            NSLog("Should continue recognizing")
            speechRec.recognizeNow(self)
        }
    }
    
    override func didRotateFromInterfaceOrientation(fromInterfaceOrientation: UIInterfaceOrientation) {
        if fromInterfaceOrientation.rawValue == UIInterfaceOrientation.Portrait.rawValue {
            /* was portrait, now upside down */
            NSLog("Orientation from normal to upside down")
            speechRec.shouldListen = 1
            mainText.text = ""
            speechRec.recognizeNow(self)
        }
        else {
            /* back to normal */
            speechRec.shouldListen = 0;
            mainText.text = "Turn your phone upside down to start listening"
            NSLog("Orientation again normal")
        }
    }
    
    func useNewSettings() {
        /*
            Conforms to the settingsDelegate protocol.
            Called from the preferencesViewController.
        */
        updateUI(textChanged: true, themeChanged: true)
    }

    
    
}
