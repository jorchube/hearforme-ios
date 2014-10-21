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

    let settings:Settings = Settings.getSettings()
    
    @IBOutlet weak var prefButton: UIButton!
    @IBOutlet weak var mainText: UITextView!
    
    @IBOutlet weak var hearButton: UIButton!
    @IBOutlet weak var waveView: WaveView!
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    let audioSamplingPeriod = 0.05
    
    var speechRec:speechRecognizer = speechRecognizer()
    
    var continueRecognizing = false /* Recognition is over antd the device is back at its normal orientation */
    var wantsAnotherRecognition = false /* Partial pause of the recognition process */
    
    var audioReadTimer: NSTimer?
    
    
    var networkAvailable:Bool = true
    var networkUnreachableOverlay:UIView?
    var networkCheckTimer:NSTimer?
    
    func setTextSize() {
        mainText.font = mainText.font.fontWithSize( CGFloat(settings.getFontSize()) )
    }
    func setColors() {
        mainText.textColor = settings.theme.fgColor()
        self.view.backgroundColor = settings.theme.bgColor()
        waveView.backgroundColor = settings.theme.bgColor()
        activityIndicator.color = settings.theme.fgColor()
        
        /*var blur = UIBlurEffect( style: UIBlurEffectStyle.Dark)
        var blurView = UIVisualEffectView(effect: blur)
        
        blurView.frame = self.view.frame
        
        self.view.addSubview(blurView)*/
        
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
    
    func transitionToNetworkUnreachableOverlay()
    {
        let frame: CGRect = UIScreen.mainScreen().bounds
        networkUnreachableOverlay = UIView(frame: frame)
        let message: UITextView = UITextView(frame: CGRect(
            x: frame.width * 1/10,
            y: frame.height * 1/10,
            width: frame.width * 8/10,
            height: frame.height * 8/10)
        )
        
        message.text = NSLocalizedString("NETWORK_ERROR_MESSAGE", comment: "")
        message.textColor = UIColor.lightGrayColor()
        message.font = message.font.fontWithSize(18)
        message.backgroundColor = UIColor.clearColor()
        message.textAlignment = NSTextAlignment.Center
        message.editable = false
        
        var blur = UIBlurEffect( style: UIBlurEffectStyle.Dark)
        var blurView = UIVisualEffectView(effect: blur)
        blurView.frame = frame
        networkUnreachableOverlay!.addSubview(blurView)
        
        var vibrancy = UIVibrancyEffect(forBlurEffect: blur)
        var vibrancyView = UIVisualEffectView(effect: vibrancy)
        vibrancyView.frame = frame
        blurView.addSubview(vibrancyView)
        
        vibrancyView.addSubview(message)
        
        
        networkUnreachableOverlay!.alpha = 0
        self.view.addSubview(networkUnreachableOverlay!)
        
        UIView.animateWithDuration(0.5, animations: {self.networkUnreachableOverlay!.alpha = 1})
        
        
        networkCheckTimer = NSTimer.scheduledTimerWithTimeInterval(
            5,
            target: self,
            selector: Selector("checkNetworkConnection"),
            userInfo: nil,
            repeats: true
        )
    }
    
    
    
    func showNoNetworkAlert() {
        let alert: UIAlertController = UIAlertController(
            title: NSLocalizedString("NETWORK_ERROR_TITLE", comment: ""),
            message: NSLocalizedString("NETWORK_ERROR_MESSAGE", comment: ""),
            preferredStyle: UIAlertControllerStyle.Alert
        )
        
        let aaa = UIApplicationOpenSettingsURLString
        
        alert.addAction(UIAlertAction(
            title: NSLocalizedString("NETWORK_ERROR_APP_SETTINGS_BUTTON", comment: ""),
            style: UIAlertActionStyle.Default,
            handler: { (alert:UIAlertAction!) in
                UIApplication.sharedApplication().openURL(
                    NSURL(string: UIApplicationOpenSettingsURLString)! )
                self.transitionToNetworkUnreachableOverlay()  }
            )
        )
        
        alert.addAction(UIAlertAction(
            title: NSLocalizedString("NETWORK_ERROR_OK_BUTTON", comment: ""),
            style: UIAlertActionStyle.Default,
            handler: { (alert:UIAlertAction!) in self.transitionToNetworkUnreachableOverlay()  }
            )
        )
        
        self.presentViewController(alert, animated: true, completion: nil)
    }
    
    func checkNetworkConnection() {
        let URLForNetworkCheck:CFURLRef = NSURL(string: "http://www.google.com")!
        
        //let URLForNetworkCheck:CFString = CFStringCreateWithCString(kCFAllocatorDefault, "http://www.google.com" , CFStringEncodings.UTF7)
        
        var diagnostic:Unmanaged<CFNetDiagnostic> = CFNetDiagnosticCreateWithURL(
            kCFAllocatorDefault,
            URLForNetworkCheck
        )
        
        //let status:CFNetDiagnosticStatus = CFNetDiagnosticDiagnoseProblemInteractively(diagnostic.takeUnretainedValue())
        let status:CFNetDiagnosticStatus = CFNetDiagnosticCopyNetworkStatusPassively(diagnostic.takeUnretainedValue(), nil)
        

        /*
            I know, all this shitty rawValue and hashValue dance is ugly,
            but I've not found the supposed correct way (tm).
            Obj-C examples do what here is done, but without the raw-hash thingy,
            which seems the only way in Swift. And since Swift is new there is no
            wild code to hunt...
        
            (I coould have left ..ConnectionUp.rawValue,
            but at least using hashValue in both sides seems more... I don't know, symmetric?)
        
            Future me, are you mad at past you?
        
        */
        if status.hashValue == CFNetDiagnosticStatusValues.ConnectionUp.rawValue.hashValue {
            NSLog("Network status Ok")
            networkAvailable = true
            if networkCheckTimer != nil {
                networkCheckTimer!.invalidate()
                networkCheckTimer = nil
                networkUnreachableOverlay!.removeFromSuperview()
                networkUnreachableOverlay = nil
            }
        }
        else {
            NSLog("Network error: %@", status.description)
            if networkAvailable { showNoNetworkAlert() }
            networkAvailable = false
        }
        
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        checkNetworkConnection()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view, typically from a nib.
        updateUI(textChanged: true, themeChanged: true)
        //let target = UIScreen.mainScreen().bounds
        //mainText.frame = CGRectMake(target.minX, target.minY, target.width, target.height-400)
    
        mainText.text = NSLocalizedString("TURN_UPSIDE_DOWN", comment: "")
        
        hearButton.hidden = true
        waveView.hidden = true
        activityIndicator.hidesWhenStopped = true
        
        initSpeechRec()
    }
    
    func setRecognizerStatus(status:integer_t)
    {
        
        if !continueRecognizing { return }
        
        switch status {
        case IDLE:
            activityIndicator.stopAnimating()
            hearButton.hidden = false
        case HEARING:
            activityIndicator.stopAnimating()
            waveView.hidden = false
            hearButton.hidden = true
        case PROCESSING:
            fallthrough
        case PREPARING:
            activityIndicator.startAnimating()
            waveView.hidden = true
            hearButton.hidden = true
        default:
            activityIndicator.stopAnimating()
            waveView.hidden = true
            hearButton.hidden = false
        }
    }

    
    override func supportedInterfaceOrientations() -> Int {
        return Int(UIInterfaceOrientationMask.All.rawValue) /* Xcode 6.1 */
        //return Int( UIInterfaceOrientationMask.All.toRaw() ) /* Xcode 6.0 */
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
    

    func periodicAudioVolumeFeedback() {
        if (speechRec.status == HEARING){
            waveView.setAudioLevel( CGFloat(speechRec.getAudioLevel()) )
            waveView.setNeedsDisplay()
        }
    }
    
    override func didRotateFromInterfaceOrientation(fromInterfaceOrientation: UIInterfaceOrientation) {
        if fromInterfaceOrientation.rawValue == UIInterfaceOrientation.Portrait.rawValue { /* Xcode 6.1 */
        //if fromInterfaceOrientation.toRaw() == UIInterfaceOrientation.Portrait.toRaw() { /* Xcode 6.0 */
            /* was portrait, now upside down */
            NSLog("Orientation from normal to upside down")
            mainText.text = ""
            continueRecognizing = true
            wantsAnotherRecognition = true
            prefButton.hidden = true
            
            /* TODO : hearButton and waveView need to play nicely yet */
            hearButton.hidden = true
            waveView.hidden = true
            activityIndicator.startAnimating()
            
            let recogThread = NSThread(target: self, selector: "periodicRecognition", object: nil)
            recogThread.start()
            audioReadTimer = NSTimer.scheduledTimerWithTimeInterval(audioSamplingPeriod,
                target: self,
                selector: Selector("periodicAudioVolumeFeedback"),
                userInfo: nil,
                repeats: true)
        }
        else {
            /* back to normal */
            prefButton.hidden = false
            hearButton.hidden = true
            waveView.hidden = true
            activityIndicator.stopAnimating()
            
            continueRecognizing = false
            speechRec.cancelRecognition()
            
            audioReadTimer?.invalidate()
            
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
        if !wantsAnotherRecognition {
            //activityIndicator.stopAnimating()
            speechRec.stopRecognition()
            hearButton.hidden = true
            waveView.hidden = true
        }
        else {
            hearButton.hidden = true
            activityIndicator.startAnimating()
        }
    }
    
    @IBAction func wavePressed(sender: UITapGestureRecognizer) {
            hearButtonPressed(self)
    }
    
}








