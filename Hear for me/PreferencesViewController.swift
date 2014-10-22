//
//  PreferencesViewController.swift
//  Hear for me
//
//  Created by Jordi Chulia on 26/09/14.
//  Copyright (c) 2014 Jordi Chulia. All rights reserved.
//

import UIKit



class PreferencesViewController: UIViewController, languagesDelegate {

    @IBOutlet weak var backButton: UIButton!
    
    @IBOutlet weak var themeSwitch: UISegmentedControl!
    
    @IBOutlet weak var fontSlider: UISlider!
    @IBOutlet weak var previewText: UITextView!
    @IBOutlet weak var sizeTextLabel: UILabel!
    @IBOutlet weak var languageSettingsButton: UIButton!
    
    @IBOutlet weak var smallA: UILabel!
    @IBOutlet weak var bigA: UILabel!
    
    
    let settings:Settings = Settings.getSettings()
    
    var delegate:settingsDelegate?
    
    
    
    func setTextSize() {
        previewText.font = previewText.font.fontWithSize( CGFloat(settings.getFontSize()))
    }
    func setColors() {
        previewText.textColor = settings.theme.fgColor()
        sizeTextLabel.textColor = settings.theme.fgColor()
        self.view.backgroundColor = settings.theme.bgColor()
        smallA.textColor = settings.theme.fgColor()
        bigA.textColor = settings.theme.fgColor()
        
        backButton.tintColor = settings.theme.getTintColot()
        fontSlider.tintColor = settings.theme.getTintColot()
        themeSwitch.tintColor = settings.theme.getTintColot()
        languageSettingsButton.tintColor = settings.theme.getTintColot()
    }
    
    func updateUI(textChanged textC:Bool, themeChanged themeC: Bool) {
        if textC {
            setTextSize()
            //previewText.sizeToFit()
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
        
        previewText.text = NSLocalizedString("PREVIEW", comment: "")
        languageSettingsButton.setTitle(NSLocalizedString("LANG_SETTINGS", comment: ""),
            forState: UIControlState.allZeros)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fontSlider.minimumValue = settings.getMinFontSize()
        fontSlider.maximumValue = settings.getMaxFontSize()
        fontSlider.value = settings.getFontSize()
        
        localize()
        
        updateUI(textChanged: true, themeChanged: true)
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
        updateUI(textChanged: true, themeChanged: false)
    }
    
    @IBAction func themeChanged(sender: AnyObject) {
        if themeSwitch.selectedSegmentIndex == 0 {
            settings.setTheme(Theme.name.lightOnDark)
        }
        else { settings.setTheme(Theme.name.darkOnLight) }
        self.updateUI(textChanged: false, themeChanged: true)
    }

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "LangSegue" {
            let calledVC = segue.destinationViewController as languagesViewController
            calledVC.delegate = self
        }
    }
    
    func setLanguagePreferences() {
        return
    }

}
