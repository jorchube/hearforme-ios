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
    let networkCheckPeriod = 5.0
    
    var speechRec:speechRecognizer = speechRecognizer()
    
    var continueRecognizing = false /* Recognition is over antd the device is back at its normal orientation */
    var wantsAnotherRecognition = false /* Partial pause of the recognition process */
    
    var audioReadTimer: NSTimer?
    
    let networkCheckURL1: String = "http://www.google.com"
    let networkCheckURL2: String = "http://www.amazon.co.uk"
    
    /*
        Having a dedicated status variable instead of using the one from the recognizer object,
        because at the time the recognizer sets the status some things should happen,
        such as setting the visual elements in place,
        and that should happen before the status is seen as the new one by the view controller itself
    */
    var recognizerStatus:integer_t = IDLE
    
    var networkAvailable:Bool = true
    var networkUnreachableOverlay:UIView?
    var networkCheckTimer: NSTimer?
    
    var upsideDown:Bool = false
    
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
        speechRec.shouldListen =  false
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
            height: frame.height * 8/10))
        
        message.text = NSLocalizedString("NETWORK_ERROR_MESSAGE", comment: "")
        message.textColor = UIColor.lightGrayColor()
        message.font = message.font.fontWithSize(16)
        message.backgroundColor = UIColor.clearColor()
        message.textAlignment = NSTextAlignment.Center
        message.editable = false
        
        var image = UIImage(named: "sad_cloud.png")
        
        let imageView: UIImageView = UIImageView(image: image)
        imageView.frame = CGRect(
            x: frame.width * 3/10,
            y: frame.height * 5/10,
            width: frame.width * 4/10,
            height: frame.height * 4/10)
        imageView.contentMode = UIViewContentMode.ScaleAspectFit
        imageView.alpha = 0.8
        
        var blur = UIBlurEffect( style: UIBlurEffectStyle.Dark)
        var blurView = UIVisualEffectView(effect: blur)
        blurView.frame = frame
        networkUnreachableOverlay!.addSubview(blurView)
        
        var vibrancy = UIVibrancyEffect(forBlurEffect: blur)
        var vibrancyView = UIVisualEffectView(effect: vibrancy)
        vibrancyView.frame = frame
        blurView.addSubview(vibrancyView)
        
        vibrancyView.addSubview(message)
        vibrancyView.addSubview(imageView)
        
        
        networkUnreachableOverlay!.alpha = 0
        self.view.addSubview(networkUnreachableOverlay!)
        
        UIView.animateWithDuration(0.5, animations: {self.networkUnreachableOverlay!.alpha = 1})
    }
    
    
    
    func showNoNetworkAlert() {
        let alert: UIAlertController = UIAlertController(
            title: NSLocalizedString("NETWORK_ERROR_TITLE", comment: ""),
            message: NSLocalizedString("NETWORK_ERROR_MESSAGE", comment: ""),
            preferredStyle: UIAlertControllerStyle.Alert)
        
        alert.addAction(UIAlertAction(
            title: NSLocalizedString("NETWORK_ERROR_APP_SETTINGS_BUTTON", comment: ""),
            style: UIAlertActionStyle.Default,
            handler: { (alert:UIAlertAction!) in
                UIApplication.sharedApplication().openURL(
                    NSURL(string: UIApplicationOpenSettingsURLString)! )
                self.transitionToNetworkUnreachableOverlay() }) )
        
        alert.addAction(UIAlertAction(
            title: NSLocalizedString("NETWORK_ERROR_OK_BUTTON", comment: ""),
            style: UIAlertActionStyle.Default,
            handler: { (alert:UIAlertAction!) in self.transitionToNetworkUnreachableOverlay() }) )
        
        self.presentViewController(alert, animated: true, completion: nil)
    }
    
    
    func networkCheckSuccessful() {
        if networkAvailable == false {
            NSLog("Restoring service")
            networkAvailable = true
            if upsideDown { startDoingTheJob() /* ...again */}
        }
        if networkUnreachableOverlay != nil {
            networkUnreachableOverlay!.alpha = 1
            //UIView.animateWithDuration(0.5, animations: {self.networkUnreachableOverlay!.alpha = 0})
            UIView.animateWithDuration(0.5,
                animations: {
                    self.networkUnreachableOverlay!.alpha = 0
                },
                completion: { Bool in
                    self.networkUnreachableOverlay!.removeFromSuperview()
                    self.networkUnreachableOverlay = nil} )
        }
    }
    
    func networkCheckFailed() {
        if networkAvailable { showNoNetworkAlert() }
        networkAvailable = false
        stopDoingTheJob()
    }
    
    func checkNetworkWithURLFromString(str_url: String ) -> Bool {
        let URLForNetworkCheck:CFURLRef = NSURL(string: networkCheckURL1)!
        var diagnostic:Unmanaged<CFNetDiagnostic> = CFNetDiagnosticCreateWithURL(
            kCFAllocatorDefault,
            URLForNetworkCheck)
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
        return status.hashValue == CFNetDiagnosticStatusValues.ConnectionUp.rawValue.hashValue
    }
    
    func checkNetworkConnection() -> Bool {
        /*
            Sets 'networkAvailable' to true or false, and also returns its value.
            Triggers relevant actions regarding network availability.
        */

        if checkNetworkWithURLFromString(networkCheckURL1) {
            NSLog("Network status Ok")
            networkCheckSuccessful()
        }
        else {
            /* Double check */
            if checkNetworkWithURLFromString(networkCheckURL2) {
                networkCheckSuccessful()
            }
            else {
                NSLog("Network failed")
                networkCheckFailed()
            }
        }
        
        return networkAvailable
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        /*checkNetworkConnection()*/
        if networkCheckTimer == nil {
            networkCheckTimer = NSTimer.scheduledTimerWithTimeInterval(
                networkCheckPeriod,
                target: self,
                selector: Selector("periodicNetworkCheck"),
                userInfo: nil,
                repeats: true)
        }
        
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
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return settings.theme.statusBarStyle()
    }
    
    
    func setRecognizerStatusInMainVC(status:integer_t)
    {
        NSLog("Recognizer status: %d", status)
        
        if !continueRecognizing {
            recognizerStatus = IDLE
            return
        }
        switch status {
            case IDLE:
                activityIndicator.stopAnimating()
                hearButton.hidden = false
                waveView.hidden = true
            case HEARING:
                activityIndicator.stopAnimating()
                hearButton.hidden = true
                waveView.hidden = false
            case PROCESSING:
                fallthrough
            case RESTARTING:
                fallthrough
            case SETUP:
                fallthrough
            case PREPARING:
                activityIndicator.startAnimating()
                waveView.hidden = true
                hearButton.hidden = true
            case ERROR:
                activityIndicator.startAnimating()
                hearButton.hidden = true
                waveView.hidden = true
            default:
                activityIndicator.stopAnimating()
                waveView.hidden = true
                hearButton.hidden = false
        }
        recognizerStatus = status
        
        if recognizerStatus == ERROR { checkNetworkConnection() }
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
        
        while(continueRecognizing && networkAvailable) {
            if( (recognizerStatus == IDLE || recognizerStatus == RESTARTING) && wantsAnotherRecognition) {
                speechRec.startRecognition()
            }
        }
        NSLog("End periodic recognition")
    }
    

    func periodicAudioVolumeFeedback() {
        if (recognizerStatus == HEARING){
            waveView.setAudioLevel( CGFloat(speechRec.getAudioLevel()) )
            waveView.setNeedsDisplay()
        }
    }
    
    func periodicNetworkCheck() {
        if  !checkNetworkConnection() {
            activityIndicator.stopAnimating()
            waveView.hidden = true
            hearButton.hidden = true
            
            wantsAnotherRecognition = false
            speechRec.cancelRecognitionShouldBroadcastStatus(false)
            continueRecognizing = false
            
            recognizerStatus = IDLE
        }
    }
    
    func startDoingTheJob() {
        activityIndicator.startAnimating()
        //initSpeechRec()
        
        continueRecognizing = true
        wantsAnotherRecognition = true
        
        let recogThread = NSThread(target: self, selector: "periodicRecognition", object: nil)
        recogThread.start()
        
        if audioReadTimer == nil {
            audioReadTimer = NSTimer.scheduledTimerWithTimeInterval(
                audioSamplingPeriod,
                target: self,
                selector: Selector("periodicAudioVolumeFeedback"),
                userInfo: nil,
                repeats: true)
        }

        if networkCheckTimer == nil {
            networkCheckTimer = NSTimer.scheduledTimerWithTimeInterval(
                networkCheckPeriod,
                target: self,
                selector: Selector("periodicNetworkCheck"),
                userInfo: nil,
                repeats: true)
        }
    }
    
    func stopDoingTheJob() {
        continueRecognizing = false
        speechRec.cancelRecognitionShouldBroadcastStatus(true)
        //speechRec.destroyRecognizer()
        
        audioReadTimer?.invalidate()
        audioReadTimer = nil
    }
    
    override func didRotateFromInterfaceOrientation(fromInterfaceOrientation: UIInterfaceOrientation) {
        if fromInterfaceOrientation.rawValue == UIInterfaceOrientation.Portrait.rawValue { /* Xcode 6.1 */
        //if fromInterfaceOrientation.toRaw() == UIInterfaceOrientation.Portrait.toRaw() { /* Xcode 6.0 */
            /* was portrait, now upside down */
            NSLog("Orientation from normal to upside down")
            upsideDown = true
            
            mainText.text = ""
            prefButton.hidden = true
            hearButton.hidden = true
            waveView.hidden = true
            
            if checkNetworkConnection() {
                startDoingTheJob()
            }
        }
        else {
            /* back to normal */
            NSLog("Orientation again normal")
            upsideDown = false
            
            prefButton.hidden = false
            hearButton.hidden = true
            waveView.hidden = true
            activityIndicator.stopAnimating()
            
            /*networkCheckTimer?.invalidate()
            networkCheckTimer = nil*/
            
            stopDoingTheJob()
            mainText.text = NSLocalizedString("TURN_UPSIDE_DOWN", comment: "")
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
            speechRec.stopRecognitionShouldBroadcastStatus(true)
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








