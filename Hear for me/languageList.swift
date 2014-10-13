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


let hearingLanguageList = [
    [NSLocalizedString("ara-EGY", comment: ""), "ara-EGY", true],
    [NSLocalizedString("ara-SAU", comment: ""), "ara-SAU", true],
    [NSLocalizedString("ara-XWW", comment: ""), "ara-XWW", true],
    [NSLocalizedString("ind-IDN", comment: ""), "ind-IDN", true],
    [NSLocalizedString("yue-CHN", comment: ""), "yue-CHN", false],
    [NSLocalizedString("cat-ESP", comment: ""), "cat-ESP", true],
    [NSLocalizedString("hrv-HRV", comment: ""), "hrv-HRV", true],
    [NSLocalizedString("ces-CZE", comment: ""), "ces-CZE", true],
    [NSLocalizedString("dan-DNK", comment: ""), "dan-DNK", true],
    [NSLocalizedString("nld-NLD", comment: ""), "nld-NLD", true],
    [NSLocalizedString("eng-AUS", comment: ""), "eng-AUS", true],
    [NSLocalizedString("eng-GBR", comment: ""), "eng-GBR", true],
    [NSLocalizedString("eng-USA", comment: ""), "eng-USA", true],
    [NSLocalizedString("eng-IND", comment: ""), "eng-IND", true],
    [NSLocalizedString("fin-FIN", comment: ""), "fin-FIN", true],
    [NSLocalizedString("fra-CAN", comment: ""), "fra-CAN", true],
    [NSLocalizedString("fra-FRA", comment: ""), "fra-FRA", true],
    [NSLocalizedString("deu-DEU", comment: ""), "deu-DEU", true],
    [NSLocalizedString("ell-GRC", comment: ""), "ell-GRC", true],
    [NSLocalizedString("heb-ISR", comment: ""), "heb-ISR", true],
    [NSLocalizedString("hin-IND", comment: ""), "hin-IND", true],
    [NSLocalizedString("hun-HUN", comment: ""), "hun-HUN", true],
    [NSLocalizedString("ita-ITA", comment: ""), "ita-ITA", true],
    [NSLocalizedString("jpn-JPN", comment: ""), "jpn-JPN", true],
    [NSLocalizedString("kor-KOR", comment: ""), "kor-KOR", true],
    [NSLocalizedString("zlm-MYS", comment: ""), "zlm-MYS", true],
    [NSLocalizedString("cmn-CHN", comment: ""), "cmn-CHN", true],
    [NSLocalizedString("cmn-TWN", comment: ""), "cmn-TWN", true],
    [NSLocalizedString("nor-NOR", comment: ""), "nor-NOR", true],
    [NSLocalizedString("pol-POL", comment: ""), "pol-POL", true],
    [NSLocalizedString("por-BRA", comment: ""), "por-BRA", true],
    [NSLocalizedString("por-PRT", comment: ""), "por-PRT", true],
    [NSLocalizedString("ron-ROU", comment: ""), "ron-ROU", true],
    [NSLocalizedString("rus-RUS", comment: ""), "rus-RUS", true],
    [NSLocalizedString("slk-SVK", comment: ""), "slk-SVK", true],
    [NSLocalizedString("spa-ESP", comment: ""), "spa-ESP", true],
    [NSLocalizedString("spa-XLA", comment: ""), "spa-XLA", true],
    [NSLocalizedString("swe-SWE", comment: ""), "swe-SWE", true],
    [NSLocalizedString("tha-THA", comment: ""), "tha-THA", true],
    [NSLocalizedString("tur-TUR", comment: ""), "tur-TUR", true],
    [NSLocalizedString("ukr-UKR", comment: ""), "ukr-UKR", true],
    [NSLocalizedString("vie-VNM", comment: ""), "vie-VNM", true]
]



/*
    ["human readable string", "google code"]
*/


let translatingLanguageList = [
    [NSLocalizedString("af", comment: ""), "af"],
    [NSLocalizedString("sq", comment: ""), "sq"],
    [NSLocalizedString("ar", comment: ""), "ar"],
    [NSLocalizedString("az", comment: ""), "az"],
    [NSLocalizedString("eu", comment: ""), "eu"],
    [NSLocalizedString("bn", comment: ""), "bn"],
    [NSLocalizedString("be", comment: ""), "be"],
    [NSLocalizedString("bg", comment: ""), "bg"],
    [NSLocalizedString("ca", comment: ""), "ca"],
    [NSLocalizedString("zh-CN", comment: ""), "zh-CN"],
    [NSLocalizedString("zh-TW", comment: ""), "zh-TW"],
    [NSLocalizedString("hr", comment: ""), "hr"],
    [NSLocalizedString("cs", comment: ""), "cs"],
    [NSLocalizedString("da", comment: ""), "da"],
    [NSLocalizedString("nl", comment: ""), "nl"],
    [NSLocalizedString("en", comment: ""), "en"],
    [NSLocalizedString("eo", comment: ""), "eo"],
    [NSLocalizedString("et", comment: ""), "et"],
    [NSLocalizedString("tl", comment: ""), "tl"],
    [NSLocalizedString("fi", comment: ""), "fi"],
    [NSLocalizedString("fr", comment: ""), "fr"],
    [NSLocalizedString("gl", comment: ""), "gl"],
    [NSLocalizedString("ka", comment: ""), "ka"],
    [NSLocalizedString("de", comment: ""), "de"],
    [NSLocalizedString("el", comment: ""), "el"],
    [NSLocalizedString("gu", comment: ""), "gu"],
    [NSLocalizedString("ht", comment: ""), "ht"],
    [NSLocalizedString("iw", comment: ""), "iw"],
    [NSLocalizedString("hi", comment: ""), "hi"],
    [NSLocalizedString("hu", comment: ""), "hu"],
    [NSLocalizedString("is", comment: ""), "is"],
    [NSLocalizedString("id", comment: ""), "id"],
    [NSLocalizedString("ga", comment: ""), "ga"],
    [NSLocalizedString("it", comment: ""), "it"],
    [NSLocalizedString("ja", comment: ""), "ja"],
    [NSLocalizedString("kn", comment: ""), "kn"],
    [NSLocalizedString("ko", comment: ""), "ko"],
    [NSLocalizedString("la", comment: ""), "la"],
    [NSLocalizedString("lv", comment: ""), "lv"],
    [NSLocalizedString("lt", comment: ""), "lt"],
    [NSLocalizedString("mk", comment: ""), "mk"],
    [NSLocalizedString("ms", comment: ""), "ms"],
    [NSLocalizedString("mt", comment: ""), "mt"],
    [NSLocalizedString("no", comment: ""), "no"],
    [NSLocalizedString("fa", comment: ""), "fa"],
    [NSLocalizedString("pl", comment: ""), "pl"],
    [NSLocalizedString("pt", comment: ""), "pt"],
    [NSLocalizedString("ro", comment: ""), "ro"],
    [NSLocalizedString("ru", comment: ""), "ru"],
    [NSLocalizedString("sr", comment: ""), "sr"],
    [NSLocalizedString("sk", comment: ""), "sk"],
    [NSLocalizedString("sl", comment: ""), "sl"],
    [NSLocalizedString("es", comment: ""), "es"],
    [NSLocalizedString("sw", comment: ""), "sw"],
    [NSLocalizedString("sv", comment: ""), "sv"],
    [NSLocalizedString("ta", comment: ""), "ta"],
    [NSLocalizedString("te", comment: ""), "te"],
    [NSLocalizedString("th", comment: ""), "th"],
    [NSLocalizedString("tr", comment: ""), "tr"],
    [NSLocalizedString("uk", comment: ""), "uk"],
    [NSLocalizedString("ur", comment: ""), "ur"],
    [NSLocalizedString("vi", comment: ""), "vi"],
    [NSLocalizedString("cy", comment: ""), "cy"],
    [NSLocalizedString("yi", comment: ""), "yi"]
]

