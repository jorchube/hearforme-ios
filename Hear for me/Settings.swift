//
//  Settings.swift
//  Hear for me
//
//  Created by Jordi Chulia on 29/09/14.
//  Copyright (c) 2014 Jordi Chulia. All rights reserved.
//

import Foundation

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
    
    func bgColor() -> UIColor {
        if self.current == Theme.name.lightOnDark {
            return UIColor(red: 4/255.0, green: 43/255.0, blue: 53/255.0, alpha: 1)
        }
        return UIColor(red: 255/255.0, green: 252/255.0, blue: 235/255.0, alpha: 1)
    }
}


struct hearingLang {
    let name:String
    let code:String
    let translatable:Bool
}

struct translatingLang {
    let name:String
    let code:String
}

public struct Languages{
    
    /*
        [   name: "human readable string",
            code: "nuance code",
            translatable: "is translatable"
        ]
    */
    var hearingList:Array<hearingLang> = []
    
    
    /*
        [
            name: "human readable string",
            code: "google code"
        ]
    */
    var translatingList:Array<translatingLang> = []
    
    var hearingSelection: Int = 0
    var translatingSelection: Int = 0
    
    mutating func setHearing(index: Int) {
        if index >= 0 && index < self.hearingList.count {
            self.hearingSelection = index
        }
    }
    mutating func setTranslating(index: Int) {
        if index >= 0 && index < self.translatingList.count {
            self.translatingSelection = index
        }
    }
    func getHearingValue() -> String{
        return self.hearingList[self.hearingSelection].code
    }
    func getTranslatingValue() -> String{
        return self.translatingList[self.translatingSelection].code
    }
    func getHearingString() -> String{
        return self.hearingList[self.hearingSelection].name
    }
    func getTranslatingString() -> String{
        return self.translatingList[self.translatingSelection].name
    }
    func hearingIsTranslatable() -> Bool {
        return self.hearingList[hearingSelection].translatable
    }
}


@objc(Settings)
class Settings: NSObject {
    
    private let _minFontSize:Double = 16
    private let _maxFontSize:Double = 56
    
    private var _fontSize:Double = 20
    
    var theme:Theme = Theme()
    
    var language: Languages = Languages()
    
    @objc(wantsTranslation)
    var wantsTranslation:Bool = false
    
    override init() {
        super.init()
        /* Read from settings storage file */
        self.theme.setCurrent(Theme.name.darkOnLight)
        
        for l in hearingLanguageList {
            self.language.hearingList.append( hearingLang(name: l[0] as NSString, code: l[1] as NSString, translatable: l[2] as Bool) )
        }
        self.language.hearingList.sort { $0.name < $1.name }
        
        for l in translatingLanguageList {
            self.language.translatingList.append( translatingLang(name: l[0] as NSString, code: l[1] as NSString) )
        }
        self.language.translatingList.sort { $0.name < $1.name }
    }
    
    class func getSettings() -> Settings {
        return _settings
    }
    
    func getTheme() -> Theme.name{ return theme.getCurrent() }
    func setTheme(newTheme: Theme.name) { theme.setCurrent(newTheme) }
    
    func getMinFontSize() -> Double {return _minFontSize}
    func getMaxFontSize() -> Double {return _maxFontSize}
    func getFontSize() -> Double {return _fontSize}
    func setFontSize(newSize: Double) {
        if newSize < _minFontSize || newSize > _maxFontSize { return }
        _fontSize = newSize
    }

}
