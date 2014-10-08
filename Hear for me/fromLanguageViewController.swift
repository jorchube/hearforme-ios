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
    
    let settings:Settings = Settings.getSettings()
    let blurHeight:CGFloat = 265
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        langPicker.delegate = self
        langPicker.dataSource = self

        var blur = UIBlurEffect( style: UIBlurEffectStyle.ExtraLight)
        var blurView = UIVisualEffectView(effect: blur)
        
        blurView.frame = CGRectMake(0,
            self.view.frame.maxY - blurHeight,
            self.view.frame.width,
            blurHeight)
        
        self.view.addSubview(blurView)
        
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
        settings.language.setHearingFrom(langPicker.selectedRowInComponent(0))
    }
    
    @IBAction func okButtonTouched(sender: AnyObject) {
        updateSettings()
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return settings.language.hearingFrom.count
    }
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String! {
        return settings.language.hearingFrom[row]
    }
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    
    
}
