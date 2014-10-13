//
//  Translator.swift
//  Hear for me
//
//  Created by Jordi Chulia on 13/10/14.
//  Copyright (c) 2014 Jordi Chulia. All rights reserved.
//

import Foundation

class Translator {

    /*
    GET https://www.googleapis.com/language/translate/v2?key=INSERT-YOUR-KEY&target=de&q=Hello
    */
    
    private let key: String = AIzaSyA8cEH14rqC_uXz6XMxBxxqH8A4YoTvQUY
    
    func translate(target: String, payload:String) -> String {
        var request: NSURLRequest = NSURLRequest(URL: "https://www.googleapis.com/language/translate/v2?key=" + key + "&target=" + target + "&q=" + payload )
        
    }

}