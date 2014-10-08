//
//  languagesViewController.swift
//  Hear for me
//
//  Created by Jordi Chulia on 07/10/14.
//  Copyright (c) 2014 Jordi Chulia. All rights reserved.
//

import UIKit

protocol languagesDelegate {
    func setLanguagePreferences()
}

class languagesViewController: UIViewController {

    @IBOutlet weak var backButton: UIButton!
    
    var delegate:languagesDelegate?
    
    let settings:Settings = Settings.getSettings()
    
    
    func loadSettings() {
        self.view.backgroundColor = settings.theme.bgColor()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        loadSettings()
        
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
         /*   let calledVC = segue.destinationViewController as languagesViewController
            calledVC.delegate = self*/
                    NSLog("segue")
        }
    }

    @IBAction func backButtonTouched(sender: AnyObject) {
        self.dismissViewControllerAnimated(1, completion: nil)
    }
    

}
