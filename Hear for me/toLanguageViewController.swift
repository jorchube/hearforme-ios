//
//  toLanguageViewController.swift
//  Hear for me
//
//  Created by Jordi Chulia on 13/10/14.
//  Copyright (c) 2014 Jordi Chulia. All rights reserved.
//

import UIKit


class toLanguageViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {

    @IBOutlet weak var okButton: UIButton!
    @IBOutlet weak var langPicker: UIPickerView!
    @IBOutlet weak var translationLabel: UILabel!
    @IBOutlet weak var translationSwitch: UISwitch!
    
    let settings:Settings = Settings.getSettings()
    let blurHeight:CGFloat = 315 /* TODO : Fix this shit */
    
    var languagePickerDelegate:languagePicker?
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return settings.theme.statusBarStyle()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        langPicker.delegate = self
        langPicker.dataSource = self
        
        okButton.tintColor = settings.theme.getTintColorForBlur()
        translationSwitch.tintColor = settings.theme.getTintColorForBlur()
        translationSwitch.onTintColor = settings.theme.getTintColorForBlur()
        
        if !settings.language.hearingIsTranslatable() {
            translationSwitch.on = false
            translationSwitch.enabled = false
        }
        else {
            translationSwitch.enabled = true
            translationSwitch.on = settings.wantsTranslation
        }
        
        if settings.theme.current == Theme.name.lightOnDark {
            translationLabel.textColor = UIColor.darkTextColor()
        }
        else {
            translationLabel.textColor = UIColor.lightTextColor()
        }
        
        let lineView: LineView = LineView(frame: UIScreen.mainScreen().bounds)
        lineView.opaque = false
        
        var blur:UIBlurEffect
        if settings.theme.current == Theme.name.lightOnDark {
            blur = UIBlurEffect( style: UIBlurEffectStyle.ExtraLight)
            
        }
        else { blur = UIBlurEffect( style: UIBlurEffectStyle.Dark) }
        
        //var blur = UIBlurEffect( style: UIBlurEffectStyle.ExtraLight)
        var blurView = UIVisualEffectView(effect: blur)
        blurView.frame = CGRectMake(0,
            self.view.frame.maxY - blurHeight,
            self.view.frame.width,
            blurHeight)
        self.view.addSubview(blurView)
        
        var vibrancy = UIVibrancyEffect(forBlurEffect: blur)
        var vibrancyView = UIVisualEffectView(effect: vibrancy)
        vibrancyView.frame = CGRectMake(0,
            0,
            self.view.frame.width,
            blurHeight)
        blurView.addSubview(vibrancyView)
        
        vibrancyView.addSubview(okButton)
        vibrancyView.addSubview(langPicker)
        vibrancyView.addSubview(translationSwitch)
        vibrancyView.addSubview(translationLabel)
        vibrancyView.addSubview(lineView)
        
        
        langPicker.selectRow(settings.language.translatingIndex, inComponent: 0, animated: false)
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
    
    func updateSettings() {
        settings.language.setTranslating(
            settings.language.translatingList[langPicker.selectedRowInComponent(0)],
            index: langPicker.selectedRowInComponent(0))
    }
    
    @IBAction func okButtonTouched(sender: AnyObject) {
        updateSettings()
        languagePickerDelegate?.setSelectedLanguage()
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func pickerView(pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        var attrs: NSDictionary
        if settings.theme.current == Theme.name.lightOnDark {
            attrs = [ NSForegroundColorAttributeName: UIColor.darkTextColor()]
        }
        else {
            attrs = [ NSForegroundColorAttributeName: UIColor.lightTextColor()]
        }
        return NSAttributedString(string: settings.language.hearingList[row].name!, attributes: attrs)
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return settings.language.translatingList.count
    }
    /*func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String! {
        return settings.language.translatingList[row].name
    }*/
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    @IBAction func translationSwitchChanged(sender: AnyObject) {
        settings.wantsTranslation = translationSwitch.on
    }
    
    @IBAction func swipeRight(sender: UISwipeGestureRecognizer) {
        okButtonTouched(self)
    }

    @IBAction func tapGesture(sender: UITapGestureRecognizer) {
        okButtonTouched(self)
    }
}


