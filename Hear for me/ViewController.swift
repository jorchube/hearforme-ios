//
//  ViewController.swift
//  Hear for me
//
//  Created by Jordi Chulia on 25/09/14.
//  Copyright (c) 2014 Jordi Chulia. All rights reserved.
//

import UIKit
import SystemConfiguration



class ViewController: UIViewController, settingsDelegate, connectionStatusDemander {

    let settings:Settings = Settings.getSettings()
    
    @IBOutlet weak var prefButton: UIButton!
    @IBOutlet weak var mainText: UITextView!
    
    @IBOutlet weak var hearButton: UIButton!
    @IBOutlet weak var waveView: WaveView!
    
    @IBOutlet weak var languagesPanelView: LanguagesPanelView!
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    
    var textFadeView: UIGradView?
    
    let audioSamplingPeriod = 0.05
    let networkCheckPeriod = 5.0
    
    var speechRec:speechRecognizer = speechRecognizer()
    
    var continueRecognizing = false /* Recognition is over antd the device is back at its normal orientation */
    var wantsAnotherRecognition = false /* Partial pause of the recognition process */
    
    var audioReadTimer: NSTimer?
    
    
    var networkChecker: ConnectionChecker?

    
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

    
    // MARK: - UI
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return settings.theme.statusBarStyle()
    }
    
    func setTextSize() {
        mainText.font = mainText.font.fontWithSize( CGFloat(settings.getFontSize()) )
        setInitialText()
    }
    func setColors() {
    
        mainText.textColor = settings.theme.fgColor()
        
        self.view.backgroundColor = settings.theme.bgColor()
        waveView.backgroundColor = settings.theme.bgColor()
        textFadeView!.setNeedsDisplay()
        activityIndicator.color = settings.theme.fgColor()
        
        languagesPanelView.updateBlurView()
        languagesPanelView.setNeedsDisplay()
        
        
        
                
        /*var blur = UIBlurEffect( style: UIBlurEffectStyle.Dark)
        var blurView = UIVisualEffectView(effect: blur)
        
        blurView.frame = self.view.frame
        
        self.view.addSubview(blurView)*/
        
    }
    
    func updateUI(textChanged textC: Bool, themeChanged themeC: Bool) {
        if textC {setTextSize()}
        if themeC {setColors()}
    }

    
    
    // MARK: - Network check
    
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
        message.textColor = UIColor.lightTextColor()
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
        imageView.alpha = 0.6
        
        
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
    
    
    func receivedNetworkStatus(status: ConnectionChecker.netStatus) {
        if status == ConnectionChecker.netStatus.down {
            activityIndicator.stopAnimating()
            waveView.hidden = true
            hearButton.hidden = true
            
            wantsAnotherRecognition = false
            speechRec.cancelRecognitionShouldBroadcastStatus(false)
            continueRecognizing = false
            
            recognizerStatus = IDLE
            
            networkCheckFailed()
        }
        if status == ConnectionChecker.netStatus.up {
            networkCheckSuccessful()
        }
    }
    
    func periodicNetworkCheck() {
        networkChecker!.check()
    }
 
    
    // MARK: - Setup
    
    func useNewSettings() {
        /*
        Conforms to the settingsDelegate protocol.
        Called from the preferencesViewController.
        */
        settings.saveSettings()
        updateUI(textChanged: true, themeChanged: true)
    }
    
    func initSpeechRec() {
        speechRec.shouldListen =  false
        speechRec.setup(self)
        speechRec.textview = self.mainText
    }
    
    override func supportedInterfaceOrientations() -> Int {
        return Int(UIInterfaceOrientationMask.All.rawValue) /* Xcode 6.1 */
        //return Int( UIInterfaceOrientationMask.All.toRaw() ) /* Xcode 6.0 */
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
    
    func initialSpaces() -> String {
        if settings.getFontSize() / settings._maxFontSize > 0.65 { return "\n\n" }
        if settings.getFontSize() / settings._maxFontSize > 0.50 { return "\n\n\n" }
        if settings.getFontSize() / settings._maxFontSize > 0.40 { return "\n\n\n\n" }
        if settings.getFontSize() / settings._maxFontSize > 0.30 { return "\n\n\n\n\n" }
        return "\n\n\n\n\n\n"
        
    }
    
    func setInitialText() {
        mainText.text = initialSpaces()
        mainText.insertText(NSLocalizedString("TURN_UPSIDE_DOWN", comment: ""))
        //mainText.insertText("HHH HHH HHH HHH HHH HHH HHH HHH HHH HHH HHH HHH HHH HHH HHH HHH HHH HHH HHH HHH HHH HHH HHH HHH HHH HHH HHH HHH HHH HHH HHH HHH HHH HHH HHH HHH HHH HHH")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        networkChecker = ConnectionChecker(demander: self)
        
        textFadeView = UIGradView(frame:CGRect(
            origin: mainText.frame.origin,
            size: CGSize(
                width: self.view.frame.width,
                height: self.view.frame.height - 8 - 72))) /* 8: space until bottombar. 72: height of bottom bar.*/
        /*
            TODO: Although hardcoded in the IB, should not hardcode these values here, in case someday they are changed in the IB
            Should be okay with different screen sizes, anyway.
            I had problems, hence there are those ugly numbers. Sorry future me.
        */

        
        textFadeView?.userInteractionEnabled = false
        textFadeView?.opaque = false
        mainText.delegate = textFadeView!
        mainText.insertSubview(textFadeView!, atIndex: 10)
        
        
        updateUI(textChanged: true, themeChanged: true)
        
        hearButton.hidden = true
        waveView.hidden = true
        activityIndicator.hidesWhenStopped = true
        
        initSpeechRec()
        
      /*
        var layer: CALayer = CALayer()
        layer.frame = CGRectMake(20, 20, 200, 200)
        layer.backgroundColor = UIColor.redColor().CGColor
        self.view.layer.addSublayer(layer)
        */
    }
    
    //MARK: - Recognition
    
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
        
        if recognizerStatus == ERROR { networkChecker?.check() }
    }


    
    func periodicRecognition() {
        NSLog("Starting periodic recognition")
        
        speechRec.setHearingLanguage(settings.language.getHearingCode(),
            translatingSource: settings.language.getTranslatingSourceCode(),
            translatingTarget: settings.language.getTranslatingTargetCode(),
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
    
    func finishedRecognizing()
    {
        NSLog("Finished recognizing one stream")
        if (continueRecognizing) {
            wantsAnotherRecognition = true
        }
        else { wantsAnotherRecognition = false }
    }

    // MARK: - UI events
    
    
    override func didRotateFromInterfaceOrientation(fromInterfaceOrientation: UIInterfaceOrientation) {
        if fromInterfaceOrientation.rawValue == UIInterfaceOrientation.Portrait.rawValue { /* Xcode 6.1 */
            //if fromInterfaceOrientation.toRaw() == UIInterfaceOrientation.Portrait.toRaw() { /* Xcode 6.0 */
            /* was portrait, now upside down */
            NSLog("Orientation from normal to upside down")
            upsideDown = true
            
            mainText.text = initialSpaces()
            prefButton.hidden = true
            hearButton.hidden = true
            waveView.hidden = true
            
            startDoingTheJob()
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
            setInitialText()
        }
    }
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "PrefSegue" {
            let calledVC = segue.destinationViewController as PreferencesViewController
            calledVC.delegate = self
        }
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

    
    // MARK: - Others
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}





