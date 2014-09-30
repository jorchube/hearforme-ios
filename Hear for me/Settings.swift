//
//  Settings.swift
//  Hear for me
//
//  Created by Jordi Chulia on 29/09/14.
//  Copyright (c) 2014 Jordi Chulia. All rights reserved.
//

import UIKit

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

class Settings: NSObject {
    
    private let _minFontSize:Double = 16
    private let _maxFontSize:Double = 56
    
    private var _fontSize:Double = 20
    
    var theme:Theme = Theme()
    
    override init() {
        super.init()
        /* Read from settings storage file */
        self.theme.setCurrent(Theme.name.lightOnDark)
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
