//
//  ViewController.swift
//  Hear for me
//
//  Created by Jordi Chulia on 25/09/14.
//  Copyright (c) 2014 Jordi Chulia. All rights reserved.
//

import UIKit
import SystemConfiguration



class ViewController: UIViewController, settingsDelegate, connectionStatusDemander, languagePicker {

    let settings:Settings = Settings.getSettings()
    
    @IBOutlet weak var prefButton: UIButton!
    @IBOutlet weak var mainText: UITextView!
    
    @IBOutlet weak var hearButton: UIButton!
    @IBOutlet weak var waveView: WaveView!
    
    @IBOutlet weak var languagesPanelView: LanguagesPanelView!
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    @IBOutlet weak var fromLanguageButton: UIButton!
    @IBOutlet weak var toLanguageButton: UIButton!
    @IBOutlet weak var switchLanguageButton: UIArrowButton!
    
    
    var textFadeView: UIGradView?
    
    var switchLanguageAnimationView: UIView?
    var languageSwitchConflict: Bool = false
    
    let audioSamplingPeriod = 0.05
    let networkCheckPeriod = 5.0
    
    let showHideAnimationtime = 0.75
    
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
        
        fromLanguageButton.tintColor = settings.theme.getTintColor()
        toLanguageButton.tintColor = settings.theme.getTintColor()
        
        languagesPanelView.updateBlurView()
        languagesPanelView.setNeedsDisplay()
        
        
        
                
        /*var blur = UIBlurEffect( style: UIBlurEffectStyle.Dark)
        var blurView = UIVisualEffectView(effect: blur)
        
        blurView.frame = self.view.frame
        
        self.view.addSubview(blurView)*/
        
    }
    
    /*func updateUI(textChanged textC: Bool, themeChanged themeC: Bool) {
        if textC {setTextSize()}
        if themeC {setColors()}
    }*/

    
    func smoothShow(object: UIView) {
        if !object.hidden { return }
        
        object.alpha = 0
        object.hidden = false
        UIView.animateWithDuration(showHideAnimationtime, animations: {object.alpha = 1})
        object.alpha = 1
    }
    
    func smoothHide(object: UIView) {
        if object.hidden { return }
        
        object.alpha = 1
        UIView.animateWithDuration(showHideAnimationtime, animations: {object.alpha = 0})
        object.hidden = true
        object.alpha = 1
    }
    
    func smoothShow(objects: [UIView]) {
        for o in objects {
            smoothShow(o)
        }
    }
    
    func smoothHide(objects: [UIView]) {
        for o in objects {
            smoothHide(o)
        }
    }
    
    func activityHint(show: Bool) {
        if show {
            activityIndicator.alpha = 0
            activityIndicator.startAnimating()
            UIView.animateWithDuration(showHideAnimationtime, animations: {self.activityIndicator.alpha = 1})
            activityIndicator.alpha = 1
        }
        else {
            activityIndicator.alpha = 1
            UIView.animateWithDuration(showHideAnimationtime, animations: {self.activityIndicator.alpha = 0})
            activityIndicator.stopAnimating()
            activityIndicator.alpha = 1
        }
    }
    
    func updateUI(textChanged textC:Bool, themeChanged themeC: Bool, languageChanged langC: Bool)
    {
        
        /*
        
        About this zPosition++ mess:
        
        This is necessary as the blur panel effect view is destroyed and recreated
        each time the view is loaded, because it seems impossible to simply change the
        blur style, and this is required in order to switch themes.
        
        */
        switchLanguageButton.layer.zPosition++
        fromLanguageButton.layer.zPosition++
        toLanguageButton.layer.zPosition++
        
        switchLanguageButton.setNeedsDisplay()
        
        
        if langC {
            fromLanguageButton.setTitle(settings.language.getHearingString(), forState: UIControlState.allZeros)
            fromLanguageButton.sizeToFit()
            toLanguageButton.setTitle(settings.language.getTranslatingString(), forState: UIControlState.allZeros)
            toLanguageButton.sizeToFit()
            
            if !settings.wantsTranslation || !settings.language.hearingIsTranslatable() {
                //toLanguageButton.hidden = true
                //switchLanguageButton.hidden = true
                smoothHide([toLanguageButton, switchLanguageButton])
                
                fromLanguageButton.layer.position = CGPointMake(languagesPanelView.frame.midX, fromLanguageButton.layer.position.y)
                
            }
            else {
                //toLanguageButton.hidden = false
                //switchLanguageButton.hidden = false
                smoothShow([toLanguageButton, switchLanguageButton])
            }
        }
        
        if themeC { setColors() }
        if textC {setTextSize()}
        
        //fromLanguageButton.hidden = false
        smoothShow(fromLanguageButton)
        
    }
    
    override func animationDidStop(anim: CAAnimation!, finished flag: Bool) {
        if !languageSwitchConflict {
            //fromLanguageButton.hidden = false
            //toLanguageButton.hidden = false
            smoothShow([fromLanguageButton, toLanguageButton])
            
            updateUI(textChanged: false, themeChanged: false, languageChanged: true)
        }
        
        if switchLanguageAnimationView != nil {
            switchLanguageAnimationView?.removeFromSuperview()
        }
    }
    
    func switchLanguagesAnimation() {
        if switchLanguageAnimationView != nil {
            switchLanguageAnimationView?.removeFromSuperview()
        }
        switchLanguageAnimationView = UIView(frame: languagesPanelView.frame)
        
        let duration: CFTimeInterval = 0.75
        
        var ltor : CATextLayer = CATextLayer()
        ltor.frame = fromLanguageButton.titleLabel!.bounds
        ltor.string = fromLanguageButton.titleLabel!.text
        ltor.font = fromLanguageButton!.titleLabel?.font
        ltor.fontSize = 15.0
        ltor.foregroundColor = settings.theme.getTintColor().CGColor
        ltor.position = fromLanguageButton.layer.position
        
        var rtol : CATextLayer = CATextLayer()
        rtol.frame = toLanguageButton.titleLabel!.bounds
        rtol.string = toLanguageButton.titleLabel!.text
        rtol.font = toLanguageButton!.titleLabel?.font
        rtol.fontSize = 15.0
        rtol.foregroundColor = settings.theme.getTintColor().CGColor
        rtol.position = toLanguageButton.layer.position
        
        switchLanguageAnimationView!.layer.addSublayer(ltor)
        switchLanguageAnimationView!.layer.addSublayer(rtol)
        
        self.view.addSubview(switchLanguageAnimationView!)
        
        let rpos: CGPoint = rtol.position
        let lpos: CGPoint = ltor.position
        
        var ltorPos : CABasicAnimation = CABasicAnimation(keyPath: "position")
        ltorPos.delegate = self
        ltorPos.removedOnCompletion = false
        ltorPos.duration = duration
        ltorPos.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        ltorPos.fromValue = nil
        ltorPos.byValue = nil
        ltorPos.toValue = NSValue(CGPoint: rpos)
        
        var rtolPos : CABasicAnimation = CABasicAnimation(keyPath: "position")
        rtolPos.removedOnCompletion = false
        rtolPos.duration = duration
        rtolPos.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        rtolPos.fromValue = nil
        rtolPos.byValue = nil
        rtolPos.toValue = NSValue(CGPoint: lpos)
        
        
        //fromLanguageButton.hidden = true
        //toLanguageButton.hidden = true
        smoothHide([fromLanguageButton, toLanguageButton])
        
        ltor.addAnimation(ltorPos, forKey: "position")
        rtol.addAnimation(rtolPos, forKey: "position")
        
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
            //activityIndicator.stopAnimating()
            activityHint(false)
            //waveView.hidden = true
            //hearButton.hidden = true
            smoothHide([waveView, hearButton])
            
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
        updateUI(textChanged: true, themeChanged: true, languageChanged: true)
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
        
        updateUI(textChanged: false, themeChanged: false, languageChanged: true)
        
        
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
        
        
        updateUI(textChanged: true, themeChanged: true, languageChanged: true)
        
        hearButton.hidden = true
        waveView.hidden = true
        activityIndicator.hidesWhenStopped = true
        
        initSpeechRec()
        
        fromLanguageButton.hidden = true
        toLanguageButton.hidden = true
        switchLanguageButton.hidden = true
        
        
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
                //activityIndicator.stopAnimating()
                activityHint(false)
                //hearButton.hidden = false
                smoothShow(hearButton)
                //waveView.hidden = true
                smoothHide(waveView)
            case HEARING:
                //activityIndicator.stopAnimating()
                activityHint(false)
                //hearButton.hidden = true
                smoothHide(hearButton)
                //waveView.hidden = false
                smoothShow(waveView)
            case PROCESSING:
                fallthrough
            case RESTARTING:
                fallthrough
            case SETUP:
                fallthrough
            case PREPARING:
                //activityIndicator.startAnimating()
                activityHint(true)
                //waveView.hidden = true
                //hearButton.hidden = true
                smoothHide([waveView, hearButton])
            case ERROR:
                //activityIndicator.startAnimating()
                activityHint(true)
                //hearButton.hidden = true
                //waveView.hidden = true
                smoothHide([waveView, hearButton])
            default:
                //activityIndicator.stopAnimating()
                activityHint(false)
                //waveView.hidden = true
                smoothHide(waveView)
                //hearButton.hidden = false
                smoothShow(hearButton)
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
        if !upsideDown { return }
        
        //hearButton.hidden = true
        smoothHide(hearButton)
        //activityIndicator.startAnimating()
        activityHint(true)
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
            //prefButton.hidden = true
            //hearButton.hidden = true
            //waveView.hidden = true
            
            smoothHide([hearButton, prefButton, waveView])
            
            startDoingTheJob()
        }
        else {
            /* back to normal */
            NSLog("Orientation again normal")
            upsideDown = false
            
            //prefButton.hidden = false
            smoothShow(prefButton)
            //hearButton.hidden = true
            //waveView.hidden = true
            smoothHide([hearButton, waveView])
            
            //activityIndicator.stopAnimating()
            activityHint(false)
            
            /*networkCheckTimer?.invalidate()
            networkCheckTimer = nil*/
            
            stopDoingTheJob()
            setInitialText()
        }
    }
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        stopDoingTheJob()
        if segue.identifier == "PrefSegue" {
            let calledVC = segue.destinationViewController as PreferencesViewController
            calledVC.delegate = self
        }
        if segue.identifier == "mainFromLanguageSegue" {
            let calledVC = segue.destinationViewController as fromLanguageViewController
            calledVC.languagePickerDelegate = self
        }
        if segue.identifier == "mainToLanguageSegue" {
            let calledVC = segue.destinationViewController as toLanguageViewController
            calledVC.languagePickerDelegate = self
        }
    }
    
    @IBAction func hearButtonPressed(sender: AnyObject) {
        wantsAnotherRecognition = !wantsAnotherRecognition
        if !wantsAnotherRecognition {
            //activityIndicator.stopAnimating()
            speechRec.stopRecognitionShouldBroadcastStatus(true)
            //hearButton.hidden = true
            //waveView.hidden = true
            smoothHide([hearButton, waveView])
        }
        else {
            //hearButton.hidden = true
            smoothHide(hearButton)
            //activityIndicator.startAnimating()
            activityHint(true)
        }
    }
    
    
    func showHearingLanguageSwitchConflicSelectorForTranslatingLanguage(TL:translatingLang) {
        
        let alert: UIAlertController = UIAlertController(
            title: NSLocalizedString("HEARING_CONFLICT_TITLE", comment: ""),
            message: NSLocalizedString("HEARING_CONFLICT_TEXT", comment: ""),
            preferredStyle: UIAlertControllerStyle.ActionSheet)
        
        let codes: [String] = TL.hearingEquivalences
        
        for i in codes {
            alert.addAction(UIAlertAction(
                title: NSLocalizedString(i, comment: ""),
                style: UIAlertActionStyle.Default,
                handler: { (alert:UIAlertAction!) in
                    
                    self.settings.language.setHearing(
                        hearingLanguageDict[i]!,
                        index: self.settings.language.indexOfHearingLanguageWithCode(i))
                    self.updateUI(textChanged: false, themeChanged: false, languageChanged: true)
                    self.fromLanguageButton.hidden = false
                    self.toLanguageButton.hidden = false
                    self.languageSwitchConflict = false
                    self.startDoingTheJob()
                    
            }) )
        }
        
        self.presentViewController(alert, animated: true, completion: nil)
    }

    
    @IBAction func switchLanguageButtonPressed(sender: AnyObject) {
        NSLog("Switching source-target languages")
        stopDoingTheJob()
        
        switchLanguagesAnimation()
        
        let HL: hearingLang = settings.language.getHearingLang()
        let TL: translatingLang = settings.language.getTranslatingLang()
        
        if HL.translatorEquivalences.count > 1 {
            /* Nothing to do for now */
        }
        else if HL.translatorEquivalences.count == 1 {
            let code: String = HL.translatorEquivalences[0]
            settings.language.setTranslating(
                translatingLanguageDict[code]!,
                index: settings.language.indexOfTranslatingLanguageWithCode(code))
        }
        
        if TL.hearingEquivalences.count > 1 {
            languageSwitchConflict = true
            showHearingLanguageSwitchConflicSelectorForTranslatingLanguage(TL)
        }
        else if TL.hearingEquivalences.count == 1 {
            let code: String = TL.hearingEquivalences[0]
            settings.language.setHearing(
                hearingLanguageDict[code]!,
                index: settings.language.indexOfHearingLanguageWithCode(code))
        }
        
        if !languageSwitchConflict {
            //updateUI(textChanged: false, themeChanged: false, languageChanged: true)
            startDoingTheJob()
        }
    }
    
    @IBAction func wavePressed(sender: UITapGestureRecognizer) {
            hearButtonPressed(self)
    }

    // MARK: - LangaugePicker protocol
    
    func setSelectedLanguage() {
        updateUI(textChanged: false, themeChanged: false, languageChanged: true)
        startDoingTheJob()
    }
    
    // MARK: - Others
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}





