//
//  languagesViewController.swift
//  Hear for me
//
//  Created by Jordi Chulia on 07/10/14.
//  Copyright (c) 2014 Jordi Chulia. All rights reserved.
//

import UIKit


class languagesViewController: UIViewController, languagePicker {

    @IBOutlet weak var backButton: UIButton!
    
    var delegate:languagesDelegate?
    
    let settings:Settings = Settings.getSettings()
    
    @IBOutlet weak var fromButton: UIButton!
    @IBOutlet weak var toButton: UIButton!
    @IBOutlet weak var translateSwitch: UISwitch!
    
    func loadSettings() {
        self.view.backgroundColor = settings.theme.bgColor()
    }
    
    func updateUI() {
        fromButton.setTitle(settings.language.getHearingString(), forState: UIControlState.allZeros)
        fromButton.sizeToFit()
        toButton.setTitle(settings.language.getTranslatingString(), forState: UIControlState.allZeros)
        toButton.sizeToFit()
        toButton.enabled = translateSwitch.on
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        loadSettings()
        updateUI()
        
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

    @IBAction func backButtonTouched(sender: AnyObject) {
        self.dismissViewControllerAnimated(1, completion: nil)
    }
    
    @IBAction func translateSwitchChanged(sender: AnyObject) {
        updateUI()
    }
    
    func setSelectedLanguage() {
        updateUI()
    }

}
