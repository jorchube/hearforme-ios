//
//  fromLanguageViewController.swift
//  Hear for me
//
//  Created by Jordi Chulia on 08/10/14.
//  Copyright (c) 2014 Jordi Chulia. All rights reserved.
//

import UIKit


class fromLanguageViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {

    @IBOutlet weak var okButton: UIButton!
    @IBOutlet weak var langPicker: UIPickerView!
    
    var languagePickerDelegate:languagePicker?
    
    let settings:Settings = Settings.getSettings()
    let blurHeight:CGFloat = 265 /* TODO : Fix this shit */
    
    
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return settings.theme.statusBarStyle()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        langPicker.delegate = self
        langPicker.dataSource = self

        okButton.tintColor = settings.theme.getTintColorForBlur()
        
        let lineView: LineView = LineView(frame: UIScreen.mainScreen().bounds)
        lineView.opaque = false
        
        var blur: UIBlurEffect = UIBlurEffect( style: settings.theme.getLanguagePickerBlurEffectStyle())
        
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
        vibrancyView.addSubview(lineView)
        
        langPicker.selectRow(settings.language.hearingIndex, inComponent: 0, animated: false)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func updateSettings() {
        settings.language.setHearing(
            settings.language.hearingList[langPicker.selectedRowInComponent(0)],
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
        return settings.language.hearingList.count
    }
    /*func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String! {
        return settings.language.hearingList[row].name
    }*/
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    @IBAction func swipeDown(sender: UISwipeGestureRecognizer) {
        okButtonTouched(self)
    }
    
    @IBAction func tapGesture(sender: UITapGestureRecognizer) {
        okButtonTouched(self)
    }
}
