//
//  Settings.swift
//  Hear for me
//
//  Created by Jordi Chulia on 29/09/14.
//  Copyright (c) 2014 Jordi Chulia. All rights reserved.
//

import Foundation



protocol settingsDelegate {
    func useNewSettings()
}

private let _settings = {Settings()}()


public struct Theme{
    enum name { case darkOnLight; case lightOnDark }
    var current:Theme.name = Theme.name.lightOnDark
    
    func getCurrent() -> Theme.name { return self.current}
    mutating func setCurrent(newTheme: Theme.name) { self.current = newTheme}
    
    func fgColor() -> UIColor {
        if self.current == Theme.name.lightOnDark {
            return UIColor.lightGrayColor()
        }
        return UIColor.darkGrayColor()
    }
    
    func getTintColor() -> UIColor {
        if self.current == Theme.name.lightOnDark {
            return UIColor(red: 135/255.0, green: 130/255.0, blue: 196/255.0, alpha: 1)
        }
        return UIColor(red: 206/255.0, green: 134/255.0, blue: 49/255.0, alpha: 1)
    }
    
    func getTintColorForBlur() -> UIColor {
        /* As the blur view inverses the colorscheme, the bgColor is a good fit as tintColor */
        return self.bgColor()
    }
    
    func bgColor() -> UIColor {
        if self.current == Theme.name.lightOnDark {
            return UIColor(red: 4/255.0, green: 43/255.0, blue: 53/255.0, alpha: 1)
        }
        return UIColor(red: 255/255.0, green: 252/255.0, blue: 235/255.0, alpha: 1)
    }
    
    func statusBarStyle() -> UIStatusBarStyle {
        if self.current == Theme.name.lightOnDark {
            return UIStatusBarStyle.LightContent
        }
        return UIStatusBarStyle.Default
    }
    
    func waveColor() -> UIColor {
        if self.current == Theme.name.lightOnDark {
            return UIColor(red: 131/255.0, green: 127/255.0, blue: 166/255.0, alpha: 1)
        }
        return UIColor(red: 206/255.0, green: 134/255.0, blue: 49/255.0, alpha: 1)
    }
    
    func getLanguagePickerBlurEffectStyle() -> UIBlurEffectStyle {
        if self.current == Theme.name.lightOnDark {
            return UIBlurEffectStyle.ExtraLight
            
        }
        return UIBlurEffectStyle.Dark
    }
    
    func getBlurEffectStyle() -> UIBlurEffectStyle {
        if self.current == Theme.name.lightOnDark {
            return UIBlurEffectStyle.Dark
            
        }
        return UIBlurEffectStyle.ExtraLight
    }
    
}


public struct Languages{
    
    /*
    struct hearingLang {
    let name:String?
    let code:String?
    let translatable:Bool
    let translatorCode:String?
    var translatorEquivalences: Array<translatingLang>
    }
    
    struct translatingLang {
    let name:String?
    let code:String?
    var hearingEquivalences: Array<hearingLang>
    }
    */
    
    var hearingList:Array<hearingLang>
    var translatingList:Array<translatingLang>
    
    var hearingSelection: hearingLang
    var hearingIndex: Int
    
    var translatingSelection: translatingLang
    var translatingIndex: Int
    
    mutating func setHearing(lang: hearingLang, index: Int) {
        if lang.name == nil || lang.name == "" || lang.code == nil || lang.code == "" {
            self.hearingSelection = hearingList[0]
            self.hearingIndex = 0
        }
        else { self.hearingSelection = lang; self.hearingIndex = index }
    }
    mutating func setTranslating(lang: translatingLang, index: Int) {
        if lang.name == nil || lang.name == "" || lang.code == nil || lang.code == "" {
            self.translatingSelection = translatingList[0]
            self.translatingIndex = 0
        }
        else { self.translatingSelection = lang; self.translatingIndex = index }
    }
    func getHearingLang() -> hearingLang{
        return hearingSelection
    }
    func getTranslatingLang() -> translatingLang{
        return translatingSelection
    }
    func getHearingCode() -> String{
        return self.hearingSelection.code!
    }
    func getTranslatingSourceCode() -> String{
        return self.hearingSelection.translatorCode!
    }
    func getTranslatingTargetCode() -> String {
        return self.translatingSelection.code!
    }
    func getHearingString() -> String{
        return self.hearingSelection.name!
    }
    func getTranslatingString() -> String{
        return self.translatingSelection.name!
    }
    func hearingIsTranslatable() -> Bool {
        return self.hearingSelection.translatable
    }
}

struct PreferenceKeys {
    let theme:String = "theme" /* Theme.name */
    let wantsTranslation:String = "translate" /* Bool */
    let hearingLangCode :String = "hearingLangCode" /* String */
    //let hearingLangName :String = "hearingLangName" /* String */
    //let hearingLangTranslatable :String = "hearingLangTranslatable" /* Bool */
    let hearingIndex: String = "hearingIndex" /* Int */
    let translatingLangCode :String = "translatingLangCode" /* String */
    //let translatingLangName :String = "translatingLangName" /* String */
    let translatingIndex: String = "translatingIndex" /* Int */
    let fontSize:String = "fontSize" /* Double */
}


@objc(Settings)
class Settings: NSObject {

    let prefKeys:PreferenceKeys = PreferenceKeys()
    
    let _minFontSize:Float = 12
    let _maxFontSize:Float = 40
    
    private var _fontSize:Float = 20
    
    var theme:Theme = Theme()
    
    var language: Languages = Languages(
        hearingList: hearingLanguageDict.values.array,
        translatingList: translatingLanguageDict.values.array,
        hearingSelection: hearingLanguageDict.values.array[0],
        hearingIndex: 0,
        translatingSelection: translatingLanguageDict.values.array[0],
        translatingIndex: 0)
    
    @objc(wantsTranslation)
    var wantsTranslation:Bool = false
    
    
    func loadSettings() {
        var _defaults: NSUserDefaults = NSUserDefaults.standardUserDefaults()

        NSLog("load font size")
        if (_defaults.floatForKey(prefKeys.fontSize) == 0) { self._fontSize = 20 }
        else { self._fontSize = _defaults.floatForKey(prefKeys.fontSize) }
        NSLog("load wants translation")
        self.wantsTranslation = _defaults.boolForKey(prefKeys.wantsTranslation)
        NSLog("load theme")
        self.theme.setCurrent( _defaults.integerForKey(prefKeys.theme) == 0 ? Theme.name.darkOnLight : Theme.name.lightOnDark )
        
        NSLog("load hearing lang")
        let hCode: String? = _defaults.stringForKey(prefKeys.hearingLangCode)
        if hCode == nil {
            self.language.setHearing( language.hearingList[0], index: 0 )
        }
        else {
            self.language.setHearing( hearingLanguageDict[hCode!]!, index: _defaults.integerForKey(prefKeys.hearingIndex) )
        }

        
        /*self.language.setHearing(hearingLang(
            name: _defaults.stringForKey(prefKeys.hearingLangName),
            code: _defaults.stringForKey(prefKeys.hearingLangCode),
            translatable: _defaults.boolForKey(prefKeys.hearingLangTranslatable)),
            index: _defaults.integerForKey(prefKeys.hearingIndex)
        )*/
        //self.language.hearingIndex = _defaults.integerForKey(prefKeys.hearingIndex)
        
        NSLog("load translating lang")
        let tCode: String? = _defaults.stringForKey(prefKeys.translatingLangCode)
        if tCode == nil {
            self.language.setTranslating( language.translatingList[0], index: 0 )
        }
        else {
            self.language.setTranslating( translatingLanguageDict[tCode!]!, index: _defaults.integerForKey(prefKeys.translatingIndex) )
        }
        
        /*self.language.setTranslating(translatingLang(
            name: _defaults.stringForKey(prefKeys.translatingLangName),
            code: _defaults.stringForKey(prefKeys.translatingLangCode)),
            index: _defaults.integerForKey(prefKeys.translatingIndex)
        )*/
        //self.language.translatingIndex = _defaults.integerForKey(prefKeys.translatingIndex)

    }
    
    override init() {
        super.init()
        
        language.hearingList.sort { $0.name < $1.name }
        language.translatingList.sort { $0.name < $1.name }
        
        loadSettings()
    }
    
    class func getSettings() -> Settings {
        return _settings
    }
    
    func saveSettings() {
        var _defaults:NSUserDefaults = NSUserDefaults.standardUserDefaults()
        
        _defaults.setFloat(self._fontSize,
            forKey: prefKeys.fontSize)
        
        _defaults.setBool(self.wantsTranslation,
            forKey: prefKeys.wantsTranslation)
        
        _defaults.setObject(language.getHearingLang().code,
            forKey: prefKeys.hearingLangCode)
        
        _defaults.setInteger(language.hearingIndex,
            forKey: prefKeys.hearingIndex)
        
        _defaults.setObject(language.getTranslatingLang().code,
            forKey: prefKeys.translatingLangCode)
        
        _defaults.setInteger(language.translatingIndex,
            forKey: prefKeys.translatingIndex)
        
        _defaults.setInteger( (self.theme.getCurrent() == Theme.name.darkOnLight ? 0:1),
            forKey: prefKeys.theme)
        
        
    }
    
    func getTheme() -> Theme.name{ return theme.getCurrent() }
    func setTheme(newTheme: Theme.name) { theme.setCurrent(newTheme) }
    
    func getMinFontSize() -> Float {return _minFontSize}
    func getMaxFontSize() -> Float {return _maxFontSize}
    func getFontSize() -> Float {return _fontSize}
    func setFontSize(newSize: Float) {
        if newSize < _minFontSize || newSize > _maxFontSize { return }
        _fontSize = newSize
    }

}
