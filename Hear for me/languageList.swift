//
//  languageList.swift
//  Hear for me
//
//  Created by Jordi Chulia on 13/10/14.
//  Copyright (c) 2014 Jordi Chulia. All rights reserved.
//

import Foundation

/*
    ["human readable string", "nuance code", "is translatable"]
*/

struct hearingLang {
    let name:String?
    let code:String?
    let translatable:Bool
}

struct translatingLang {
    let name:String?
    let code:String?
}


let hearingLanguageList:Array<hearingLang> = [
    hearingLang(
        name:NSLocalizedString("ara-EGY", comment: ""),
        code:"ara-EGY",
        translatable:true
    ),
    hearingLang(
        name:NSLocalizedString("ara-SAU", comment: ""),
        code:"ara-SAU",
        translatable:true
    ),
    hearingLang(
        name:NSLocalizedString("ara-XWW", comment: ""),
        code:"ara-XWW",
        translatable:true
    ),
    hearingLang(
        name:NSLocalizedString("ind-IDN", comment: ""),
        code:"ind-IDN",
        translatable:true
    ),
    hearingLang(
        name:NSLocalizedString("yue-CHN", comment: ""),
        code:"yue-CHN",
        translatable:false
    ),
    hearingLang(
        name:NSLocalizedString("cat-ESP", comment: ""),
        code:"cat-ESP",
        translatable:true
    ),
    hearingLang(
        name:NSLocalizedString("hrv-HRV", comment: ""),
        code:"hrv-HRV",
        translatable:true
    ),
    hearingLang(
        name:NSLocalizedString("ces-CZE", comment: ""),
        code:"ces-CZE",
        translatable:true
    ),
    hearingLang(
        name:NSLocalizedString("dan-DNK", comment: ""),
        code:"dan-DNK",
        translatable:true
    ),
    hearingLang(
        name:NSLocalizedString("nld-NLD", comment: ""),
        code:"nld-NLD",
        translatable:true
    ),
    hearingLang(
        name:NSLocalizedString("eng-AUS", comment: ""),
        code:"eng-AUS",
        translatable:true
    ),
    hearingLang(
        name:NSLocalizedString("eng-GBR", comment: ""),
        code:"eng-GBR",
        translatable:true
    ),
    hearingLang(
        name:NSLocalizedString("eng-USA", comment: ""),
        code:"eng-USA",
        translatable:true
    ),
    hearingLang(
        name:NSLocalizedString("eng-IND", comment: ""),
        code:"eng-IND",
        translatable:true
    ),
    hearingLang(
        name:NSLocalizedString("fin-FIN", comment: ""),
        code:"fin-FIN",
        translatable:true
    ),
    hearingLang(
        name:NSLocalizedString("fra-CAN", comment: ""),
        code:"fra-CAN",
        translatable:true
    ),
    hearingLang(
        name:NSLocalizedString("fra-FRA", comment: ""),
        code:"fra-FRA",
        translatable:true
    ),
    hearingLang(
        name:NSLocalizedString("deu-DEU", comment: ""),
        code:"deu-DEU",
        translatable:true
    ),
    hearingLang(
        name:NSLocalizedString("ell-GRC", comment: ""),
        code:"ell-GRC",
        translatable:true
    ),
    hearingLang(
        name:NSLocalizedString("heb-ISR", comment: ""),
        code:"heb-ISR",
        translatable:true
    ),
    hearingLang(
        name:NSLocalizedString("hin-IND", comment: ""),
        code:"hin-IND",
        translatable:true
    ),
    hearingLang(
        name:NSLocalizedString("hun-HUN", comment: ""),
        code:"hun-HUN",
        translatable:true
    ),
    hearingLang(
        name:NSLocalizedString("ita-ITA", comment: ""),
        code:"ita-ITA",
        translatable:true
    ),
    hearingLang(
        name:NSLocalizedString("jpn-JPN", comment: ""),
        code:"jpn-JPN",
        translatable:true
    ),
    hearingLang(
        name:NSLocalizedString("kor-KOR", comment: ""),
        code:"kor-KOR",
        translatable:true
    ),
    hearingLang(
        name:NSLocalizedString("zlm-MYS", comment: ""),
        code:"zlm-MYS",
        translatable:true
    ),
    hearingLang(
        name:NSLocalizedString("cmn-CHN", comment: ""),
        code:"cmn-CHN",
        translatable:true
    ),
    hearingLang(
        name:NSLocalizedString("cmn-TWN", comment: ""),
        code:"cmn-TWN",
        translatable:true
    ),
    hearingLang(
        name:NSLocalizedString("nor-NOR", comment: ""),
        code:"nor-NOR",
        translatable:true
    ),
    hearingLang(
        name:NSLocalizedString("pol-POL", comment: ""),
        code:"pol-POL",
        translatable:true
    ),
    hearingLang(
        name:NSLocalizedString("por-BRA", comment: ""),
        code:"por-BRA",
        translatable:true
    ),
    hearingLang(
        name:NSLocalizedString("por-PRT", comment: ""),
        code:"por-PRT",
        translatable:true
    ),
    hearingLang(
        name:NSLocalizedString("ron-ROU", comment: ""),
        code:"ron-ROU",
        translatable:true
    ),
    hearingLang(
        name:NSLocalizedString("rus-RUS", comment: ""),
        code:"rus-RUS",
        translatable:true
    ),
    hearingLang(
        name:NSLocalizedString("slk-SVK", comment: ""),
        code:"slk-SVK",
        translatable:true
    ),
    hearingLang(
        name:NSLocalizedString("spa-ESP", comment: ""),
        code:"spa-ESP",
        translatable:true
    ),
    hearingLang(
        name:NSLocalizedString("spa-XLA", comment: ""),
        code:"spa-XLA",
        translatable:true
    ),
    hearingLang(
        name:NSLocalizedString("swe-SWE", comment: ""),
        code:"swe-SWE",
        translatable:true
    ),
    hearingLang(
        name:NSLocalizedString("tha-THA", comment: ""),
        code:"tha-THA",
        translatable:true
    ),
    hearingLang(
        name:NSLocalizedString("tur-TUR", comment: ""),
        code:"tur-TUR",
        translatable:true
    ),
    hearingLang(
        name:NSLocalizedString("ukr-UKR", comment: ""),
        code:"ukr-UKR",
        translatable:true
    ),
    hearingLang(
        name:NSLocalizedString("vie-VNM", comment: ""),
        code:"vie-VNM",
        translatable:true
    )
]



/*
    ["human readable string", "google code"]
*/


let translatingLanguageList:Array<translatingLang> = [
    translatingLang(
        name:NSLocalizedString("af", comment: ""),
        code:"af"
    ),
    translatingLang(
        name:NSLocalizedString("sq", comment: ""),
        code:"sq"
    ),
    translatingLang(
        name:NSLocalizedString("ar", comment: ""),
        code:"ar"
    ),
    translatingLang(
        name:NSLocalizedString("az", comment: ""),
        code:"az"
    ),
    translatingLang(
        name:NSLocalizedString("eu", comment: ""),
        code:"eu"
    ),
    translatingLang(
        name:NSLocalizedString("bn", comment: ""),
        code:"bn"
    ),
    translatingLang(
        name:NSLocalizedString("be", comment: ""),
        code:"be"
    ),
    translatingLang(
        name:NSLocalizedString("bg", comment: ""),
        code:"bg"
    ),
    translatingLang(
        name:NSLocalizedString("ca", comment: ""),
        code:"ca"
    ),
    translatingLang(
        name:NSLocalizedString("zh-CN", comment: ""),
        code:"zh-CN"
    ),
    translatingLang(
        name:NSLocalizedString("zh-TW", comment: ""),
        code:"zh-TW"
    ),
    translatingLang(
        name:NSLocalizedString("hr", comment: ""),
        code:"hr"
    ),
    translatingLang(
        name:NSLocalizedString("cs", comment: ""),
        code:"cs"
    ),
    translatingLang(
        name:NSLocalizedString("da", comment: ""),
        code:"da"
    ),
    translatingLang(
        name:NSLocalizedString("nl", comment: ""),
        code:"nl"
    ),
    translatingLang(
        name:NSLocalizedString("en", comment: ""),
        code:"en"
    ),
    translatingLang(
        name:NSLocalizedString("eo", comment: ""),
        code:"eo"
    ),
    translatingLang(
        name:NSLocalizedString("et", comment: ""),
        code:"et"
    ),
    translatingLang(
        name:NSLocalizedString("tl", comment: ""),
        code:"tl"
    ),
    translatingLang(
        name:NSLocalizedString("fi", comment: ""),
        code:"fi"
    ),
    translatingLang(
        name:NSLocalizedString("fr", comment: ""),
        code:"fr"
    ),
    translatingLang(
        name:NSLocalizedString("gl", comment: ""),
        code:"gl"
    ),
    translatingLang(
        name:NSLocalizedString("ka", comment: ""),
        code:"ka"
    ),
    translatingLang(
        name:NSLocalizedString("de", comment: ""),
        code:"de"
    ),
    translatingLang(
        name:NSLocalizedString("el", comment: ""),
        code:"el"
    ),
    translatingLang(
        name:NSLocalizedString("gu", comment: ""),
        code:"gu"
    ),
    translatingLang(
        name:NSLocalizedString("ht", comment: ""),
        code:"ht"
    ),
    translatingLang(
        name:NSLocalizedString("iw", comment: ""),
        code:"iw"
    ),
    translatingLang(
        name:NSLocalizedString("hi", comment: ""),
        code:"hi"
    ),
    translatingLang(
        name:NSLocalizedString("hu", comment: ""),
        code:"hu"
    ),
    translatingLang(
        name:NSLocalizedString("is", comment: ""),
        code:"is"
    ),
    translatingLang(
        name:NSLocalizedString("id", comment: ""),
        code:"id"
    ),
    translatingLang(
        name:NSLocalizedString("ga", comment: ""),
        code:"ga"
    ),
    translatingLang(
        name:NSLocalizedString("it", comment: ""),
        code:"it"
    ),
    translatingLang(
        name:NSLocalizedString("ja", comment: ""),
        code:"ja"
    ),
    translatingLang(
        name:NSLocalizedString("kn", comment: ""),
        code:"kn"
    ),
    translatingLang(
        name:NSLocalizedString("ko", comment: ""),
        code:"ko"
    ),
    translatingLang(
        name:NSLocalizedString("la", comment: ""),
        code:"la"
    ),
    translatingLang(
        name:NSLocalizedString("lv", comment: ""),
        code:"lv"
    ),
    translatingLang(
        name:NSLocalizedString("lt", comment: ""),
        code:"lt"
    ),
    translatingLang(
        name:NSLocalizedString("mk", comment: ""),
        code:"mk"
    ),
    translatingLang(
        name:NSLocalizedString("ms", comment: ""),
        code:"ms"
    ),
    translatingLang(
        name:NSLocalizedString("mt", comment: ""),
        code:"mt"
    ),
    translatingLang(
        name:NSLocalizedString("no", comment: ""),
        code:"no"
    ),
    translatingLang(
        name:NSLocalizedString("fa", comment: ""),
        code:"fa"
    ),
    translatingLang(
        name:NSLocalizedString("pl", comment: ""),
        code:"pl"
    ),
    translatingLang(
        name:NSLocalizedString("pt", comment: ""),
        code:"pt"
    ),
    translatingLang(
        name:NSLocalizedString("ro", comment: ""),
        code:"ro"
    ),
    translatingLang(
        name:NSLocalizedString("ru", comment: ""),
        code:"ru"
    ),
    translatingLang(
        name:NSLocalizedString("sr", comment: ""),
        code:"sr"
    ),
    translatingLang(
        name:NSLocalizedString("sk", comment: ""),
        code:"sk"
    ),
    translatingLang(
        name:NSLocalizedString("sl", comment: ""),
        code:"sl"
    ),
    translatingLang(
        name:NSLocalizedString("es", comment: ""),
        code:"es"
    ),
    translatingLang(
        name:NSLocalizedString("sw", comment: ""),
        code:"sw"
    ),
    translatingLang(
        name:NSLocalizedString("sv", comment: ""),
        code:"sv"
    ),
    translatingLang(
        name:NSLocalizedString("ta", comment: ""),
        code:"ta"
    ),
    translatingLang(
        name:NSLocalizedString("te", comment: ""),
        code:"te"
    ),
    translatingLang(
        name:NSLocalizedString("th", comment: ""),
        code:"th"
    ),
    translatingLang(
        name:NSLocalizedString("tr", comment: ""),
        code:"tr"
    ),
    translatingLang(
        name:NSLocalizedString("uk", comment: ""),
        code:"uk"
    ),
    translatingLang(
        name:NSLocalizedString("ur", comment: ""),
        code:"ur"
    ),
    translatingLang(
        name:NSLocalizedString("vi", comment: ""),
        code:"vi"
    ),
    translatingLang(
        name:NSLocalizedString("cy", comment: ""),
        code:"cy"
    ),
    translatingLang(
        name:NSLocalizedString("yi", comment: ""),
        code:"yi"
    )
]

