//
//  PreferencesViewController.swift
//  Hear for me
//
//  Created by Jordi Chulia on 26/09/14.
//  Copyright (c) 2014 Jordi Chulia. All rights reserved.
//

import UIKit



class PreferencesViewController: UIViewController, languagePicker {

    @IBOutlet weak var backButton: UIButton!
    
    @IBOutlet weak var themeSwitch: UISegmentedControl!
    
    @IBOutlet weak var fontSlider: UISlider!
    @IBOutlet weak var sizeTextLabel: UILabel!
    
    @IBOutlet weak var smallA: UILabel!
    @IBOutlet weak var bigA: UILabel!
    
    
    @IBOutlet weak var hearFromLabel: UILabel!
    @IBOutlet weak var translateToLabel: UILabel!
    
    @IBOutlet weak var hearFromButton: UIButton!
    @IBOutlet weak var translateToButton: UIButton!
    
    
    let settings:Settings = Settings.getSettings()
    
    var delegate:settingsDelegate?
    
    
    func setColors() {
        sizeTextLabel.textColor = settings.theme.fgColor()
        self.view.backgroundColor = settings.theme.bgColor()
        smallA.textColor = settings.theme.fgColor()
        bigA.textColor = settings.theme.fgColor()
        
        backButton.tintColor = settings.theme.getTintColot()
        fontSlider.tintColor = settings.theme.getTintColot()
        themeSwitch.tintColor = settings.theme.getTintColot()
        
        hearFromButton.tintColor = settings.theme.getTintColot()
        translateToButton.tintColor = settings.theme.getTintColot()
        
        hearFromLabel.textColor = settings.theme.fgColor()
        translateToLabel.textColor = settings.theme.fgColor()
        
        backButton.tintColor = settings.theme.getTintColot()
    }
    
    func updateUI(textChanged textC:Bool, themeChanged themeC: Bool, languageChanged langC: Bool) {
        if langC {
            hearFromButton.setTitle(settings.language.getHearingString(), forState: UIControlState.allZeros)
            hearFromButton.sizeToFit()
            translateToButton.setTitle(settings.language.getTranslatingString(), forState: UIControlState.allZeros)
            translateToButton.sizeToFit()
            
            if !settings.wantsTranslation {
                translateToButton.setTitle(NSLocalizedString("NO_WANT_TRANSLATION", comment: ""), forState:UIControlState.allZeros)
            }
            
            if !settings.language.hearingIsTranslatable() {
                translateToButton.setTitle(NSLocalizedString("NO_TRANSLATION", comment: ""), forState:UIControlState.allZeros)
                if translateToButton.enabled { translateToButton.enabled = false }
            }
            else {
                if !translateToButton.enabled { translateToButton.enabled = true }
            }
        }
        
        if themeC { setColors() }
        
        if settings.getTheme() == Theme.name.lightOnDark {
            themeSwitch.selectedSegmentIndex = 0
        }
        else {themeSwitch.selectedSegmentIndex = 1}
    }
    
    func localize() {
        backButton.setTitle(NSLocalizedString("BACK", comment: ""),
            forState: UIControlState.allZeros)
        
        themeSwitch.setTitle(NSLocalizedString("DARK", comment: ""),
            forSegmentAtIndex: 0)
        themeSwitch.setTitle(NSLocalizedString("LIGHT", comment: ""),
            forSegmentAtIndex: 1)
        
        sizeTextLabel.text = NSLocalizedString("SIZE", comment: "")
        sizeTextLabel.sizeToFit()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fontSlider.minimumValue = settings.getMinFontSize()
        fontSlider.maximumValue = settings.getMaxFontSize()
        fontSlider.value = settings.getFontSize()
        
        localize()
        
        updateUI(textChanged: true, themeChanged: true, languageChanged: true)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue!, sender: AnyObject!) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    

    
    @IBAction func backButtonTouched(sender: AnyObject) {
        if delegate != nil {
            delegate?.useNewSettings()
        }
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func fontSizeChanged(sender: AnyObject) {
        settings.setFontSize(fontSlider.value)
        updateUI(textChanged: true, themeChanged: false, languageChanged: false)
    }
    
    @IBAction func themeChanged(sender: AnyObject) {
        if themeSwitch.selectedSegmentIndex == 0 {
            settings.setTheme(Theme.name.lightOnDark)
        }
        else { settings.setTheme(Theme.name.darkOnLight) }
        self.updateUI(textChanged: false, themeChanged: true, languageChanged: false)
    }

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "fromLanguageSegue" {
            let calledVC = segue.destinationViewController as fromLanguageViewController
            calledVC.languagePickerDelegate = self
        }
        if segue.identifier == "toLanguageSegue" {
            let calledVC = segue.destinationViewController as toLanguageViewController
            calledVC.languagePickerDelegate = self
        }
    }
    
    func setSelectedLanguage() {
        updateUI(textChanged: false, themeChanged: false, languageChanged: true)
    }

}
