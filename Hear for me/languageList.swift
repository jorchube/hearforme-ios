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
    let code:String? /* Code specified and needed by the recognizer */
    let translatable:Bool
    let translatorCode:String? /* Code specified and needed by the translator */
    var translatorEquivalences: Array<translatingLang>
}

struct translatingLang {
    let name:String?
    let code:String?
    var hearingEquivalences: Array<hearingLang>
}


let hearingLanguageDict:Dictionary<String,hearingLang> = [

    "ara-EGY" : hearingLang(
        name:NSLocalizedString("ara-EGY", comment: ""),
        code:"ara-EGY",
        translatable:true,
        translatorCode:"ar-SA",
        translatorEquivalences:["ar-SA"]
    ),
    "ara-SAU" : hearingLang(
        name:NSLocalizedString("ara-SAU", comment: ""),
        code:"ara-SAU",
        translatable:true,
        translatorCode:"ar-SA",
        translatorEquivalences:["ar-SA"]
    ),
    "ara-XWW" : hearingLang(
        name:NSLocalizedString("ara-XWW", comment: ""),
        code:"ara-XWW",
        translatable:true,
        translatorCode:"ar-SA",
        translatorEquivalences:["ar-SA"]
    ),
    "ind-IDN" : hearingLang(
        name:NSLocalizedString("ind-IDN", comment: ""),
        code:"ind-IDN",
        translatable:true,
        translatorCode:"id-ID",
        translatorEquivalences:["id-ID"]
    ),
    "yue-CHN" : hearingLang(
        name:NSLocalizedString("yue-CHN", comment: ""),
        code:"yue-CHN",
        translatable:false,
        translatorCode:"",
        translatorEquivalences:[]
    ),
    "cat-ESP" : hearingLang(
        name:NSLocalizedString("cat-ESP", comment: ""),
        code:"cat-ESP",
        translatable:true,
        translatorCode:"ca-ES",
        translatorEquivalences:["ca-ES"]
    ),
    "hrv-HRV" : hearingLang(
        name:NSLocalizedString("hrv-HRV", comment: ""),
        code:"hrv-HRV",
        translatable:true,
        translatorCode:"hr-HR",
        translatorEquivalences:["hr-HR"]
    ),
    "ces-CZE" : hearingLang(
        name:NSLocalizedString("ces-CZE", comment: ""),
        code:"ces-CZE",
        translatable:true,
        translatorCode:"cs-CZ",
        translatorEquivalences:["cs-CZ"]
    ),
    "dan-DNK" : hearingLang(
        name:NSLocalizedString("dan-DNK", comment: ""),
        code:"dan-DNK",
        translatable:true,
        translatorCode:"da-DK",
        translatorEquivalences:["da-DK"]
    ),
    "nld-NLD" : hearingLang(
        name:NSLocalizedString("nld-NLD", comment: ""),
        code:"nld-NLD",
        translatable:true,
        translatorCode:"nl-NL",
        translatorEquivalences:["nl-NL"]
    ),
    "eng-AUS" : hearingLang(
        name:NSLocalizedString("eng-AUS", comment: ""),
        code:"eng-AUS",
        translatable:true,
        translatorCode:"en-GB",
        translatorEquivalences:["en-GB"]
    ),
    "eng-GBR" : hearingLang(
        name:NSLocalizedString("eng-GBR", comment: ""),
        code:"eng-GBR",
        translatable:true,
        translatorCode:"en-GB",
        translatorEquivalences:["en-GB"]
    ),
    "eng-USA" : hearingLang(
        name:NSLocalizedString("eng-USA", comment: ""),
        code:"eng-USA",
        translatable:true,
        translatorCode:"en-GB",
        translatorEquivalences:["en-GB"]
    ),
    "eng-IND" : hearingLang(
        name:NSLocalizedString("eng-IND", comment: ""),
        code:"eng-IND",
        translatable:true,
        translatorCode:"en-GB",
        translatorEquivalences:["en-GB"]
    ),
    "fin-FIN" : hearingLang(
        name:NSLocalizedString("fin-FIN", comment: ""),
        code:"fin-FIN",
        translatable:true,
        translatorCode:"fi-FI",
        translatorEquivalences:["fi-FI"]
    ),
    "fra-CAN" : hearingLang(
        name:NSLocalizedString("fra-CAN", comment: ""),
        code:"fra-CAN",
        translatable:true,
        translatorCode:"fr-FR",
        translatorEquivalences:["fr-FR"]
    ),
    "fra-FRA" : hearingLang(
        name:NSLocalizedString("fra-FRA", comment: ""),
        code:"fra-FRA",
        translatable:true,
        translatorCode:"fr-FR",
        translatorEquivalences:["fr-FR"]
    ),
    "deu-DEU" : hearingLang(
        name:NSLocalizedString("deu-DEU", comment: ""),
        code:"deu-DEU",
        translatable:true,
        translatorCode:"de-DE",
        translatorEquivalences:["de-DE"]
    ),
    "ell-GRC" : hearingLang(
        name:NSLocalizedString("ell-GRC", comment: ""),
        code:"ell-GRC",
        translatable:true,
        translatorCode:"el-GR",
        translatorEquivalences:["el-GR"]
    ),
    "heb-ISR" : hearingLang(
        name:NSLocalizedString("heb-ISR", comment: ""),
        code:"heb-ISR",
        translatable:true,
        translatorCode:"he-IL",
        translatorEquivalences:["he-IL"]
    ),
    "hin-IND" : hearingLang(
        name:NSLocalizedString("hin-IND", comment: ""),
        code:"hin-IND",
        translatable:true,
        translatorCode:"hi-IN",
        translatorEquivalences:["hi-IN"]
    ),
    "hun-HUN" : hearingLang(
        name:NSLocalizedString("hun-HUN", comment: ""),
        code:"hun-HUN",
        translatable:true,
        translatorCode:"hu-HU",
        translatorEquivalences:["hu-HU"]
    ),
    "ita-ITA" : hearingLang(
        name:NSLocalizedString("ita-ITA", comment: ""),
        code:"ita-ITA",
        translatable:true,
        translatorCode:"it-IT",
        translatorEquivalences:["it-IT"]
    ),
    "jpn-JPN" : hearingLang(
        name:NSLocalizedString("jpn-JPN", comment: ""),
        code:"jpn-JPN",
        translatable:true,
        translatorCode:"ja-JA",
        translatorEquivalences:["ja-JA"]
    ),
    "kor-KOR" : hearingLang(
        name:NSLocalizedString("kor-KOR", comment: ""),
        code:"kor-KOR",
        translatable:true,
        translatorCode:"ko-KR",
        translatorEquivalences:["ko-KR"]
    ),
    "zlm-MYS" : hearingLang(
        name:NSLocalizedString("zlm-MYS", comment: ""),
        code:"zlm-MYS",
        translatable:true,
        translatorCode:"ms-MY",
        translatorEquivalences:["ms-MY"]
    ),
    "cmn-CHN" : hearingLang(
        name:NSLocalizedString("cmn-CHN", comment: ""),
        code:"cmn-CHN",
        translatable:true,
        translatorCode:"zh-CN",
        translatorEquivalences:["zh-CN"]
    ),
    "cmn-TWN" : hearingLang(
        name:NSLocalizedString("cmn-TWN", comment: ""),
        code:"cmn-TWN",
        translatable:true,
        translatorCode:"zh-TW",
        translatorEquivalences:["zh-TW"]
    ),
    "nor-NOR" : hearingLang(
        name:NSLocalizedString("nor-NOR", comment: ""),
        code:"nor-NOR",
        translatable:true,
        translatorCode:"no-NO",
        translatorEquivalences:["no-NO"]
    ),
    "pol-POL" : hearingLang(
        name:NSLocalizedString("pol-POL", comment: ""),
        code:"pol-POL",
        translatable:true,
        translatorCode:"pl-PL",
        translatorEquivalences:["pl-PL"]
    ),
    "por-BRA" : hearingLang(
        name:NSLocalizedString("por-BRA", comment: ""),
        code:"por-BRA",
        translatable:true,
        translatorCode:"pt-PT",
        translatorEquivalences:["pt-PT"]
    ),
    "por-PRT" : hearingLang(
        name:NSLocalizedString("por-PRT", comment: ""),
        code:"por-PRT",
        translatable:true,
        translatorCode:"pt-PT",
        translatorEquivalences:["pt-PT"]
    ),
    "ron-ROU" : hearingLang(
        name:NSLocalizedString("ron-ROU", comment: ""),
        code:"ron-ROU",
        translatable:true,
        translatorCode:"ro-RO",
        translatorEquivalences:["ro-RO"]
    ),
    "rus-RUS" : hearingLang(
        name:NSLocalizedString("rus-RUS", comment: ""),
        code:"rus-RUS",
        translatable:true,
        translatorCode:"ru-RU",
        translatorEquivalences:["ru-RU"]
    ),
    "slk-SVK" : hearingLang(
        name:NSLocalizedString("slk-SVK", comment: ""),
        code:"slk-SVK",
        translatable:true,
        translatorCode:"sk-SK",
        translatorEquivalences:["sk-SK"]
    ),
    "spa-ESP" : hearingLang(
        name:NSLocalizedString("spa-ESP", comment: ""),
        code:"spa-ESP",
        translatable:true,
        translatorCode:"es-ES",
        translatorEquivalences:["es-ES"]
    ),
    "spa-XLA" : hearingLang(
        name:NSLocalizedString("spa-XLA", comment: ""),
        code:"spa-XLA",
        translatable:true,
        translatorCode:"es-ES",
        translatorEquivalences:["es-ES"]
    ),
    "swe-SWE" : hearingLang(
        name:NSLocalizedString("swe-SWE", comment: ""),
        code:"swe-SWE",
        translatable:true,
        translatorCode:"sv-SE",
        translatorEquivalences:["sv-SE"]
    ),
    "tha-THA" : hearingLang(
        name:NSLocalizedString("tha-THA", comment: ""),
        code:"tha-THA",
        translatable:true,
        translatorCode:"th-TH",
        translatorEquivalences:["th-TH"]
    ),
    "tur-TUR" : hearingLang(
        name:NSLocalizedString("tur-TUR", comment: ""),
        code:"tur-TUR",
        translatable:true,
        translatorCode:"tr-TR",
        translatorEquivalences:["tr-TR"]
    ),
    "ukr-UKR" : hearingLang(
        name:NSLocalizedString("ukr-UKR", comment: ""),
        code:"ukr-UKR",
        translatable:true,
        translatorCode:"uk-UA",
        translatorEquivalences:["uk-UA"]
    ),
    "vie-VNM" : hearingLang(
        name:NSLocalizedString("vie-VNM", comment: ""),
        code:"vie-VNM",
        translatable:true,
        translatorCode:"vi-VN",
        translatorEquivalences:["vi-VN"]
    )
    
]




let translatingLanguageDict: Dictionary<String, translatingLang> = [

    "af-ZA" : translatingLang(
        name: NSLocalizedString("af-ZA", comment:""),
        code:"af-ZA",
        hearingEquivalences:[]
    ),
    "sq-AL" : translatingLang(
        name: NSLocalizedString("sq-AL", comment:""),
        code:"sq-AL",
        hearingEquivalences:[]
    ),
    "am-ET" : translatingLang(
        name: NSLocalizedString("am-ET", comment:""),
        code:"am-ET",
        hearingEquivalences:[]
    ),
    "ar-SA" : translatingLang(
        name: NSLocalizedString("ar-SA", comment:""),
        code:"ar-SA",
        hearingEquivalences:["ara-EGY", "ara-SAU", "ara-XWW"]
    ),
    "hy-AM" : translatingLang(
        name: NSLocalizedString("hy-AM", comment:""),
        code:"hy-AM",
        hearingEquivalences:[]
    ),
    "az-AZ" : translatingLang(
        name: NSLocalizedString("az-AZ", comment:""),
        code:"az-AZ",
        hearingEquivalences:[]
    ),
    "bjs-BB" : translatingLang(
        name: NSLocalizedString("bjs-BB", comment:""),
        code:"bjs-BB",
        hearingEquivalences:[]
    ),
    "rm-RO" : translatingLang(
        name: NSLocalizedString("rm-RO", comment:""),
        code:"rm-RO",
        hearingEquivalences:[]
    ),
    "eu-ES" : translatingLang(
        name: NSLocalizedString("eu-ES", comment:""),
        code:"eu-ES",
        hearingEquivalences:[]
    ),
    "bem-ZM" : translatingLang(
        name: NSLocalizedString("bem-ZM", comment:""),
        code:"bem-ZM",
        hearingEquivalences:[]
    ),
    "bn-IN" : translatingLang(
        name: NSLocalizedString("bn-IN", comment:""),
        code:"bn-IN",
        hearingEquivalences:[]
    ),
    "be-BY" : translatingLang(
        name: NSLocalizedString("be-BY", comment:""),
        code:"be-BY",
        hearingEquivalences:[]
    ),
    "bi-VU" : translatingLang(
        name: NSLocalizedString("bi-VU", comment:""),
        code:"bi-VU",
        hearingEquivalences:[]
    ),
    "bs-BA" : translatingLang(
        name: NSLocalizedString("bs-BA", comment:""),
        code:"bs-BA",
        hearingEquivalences:[]
    ),
    "br-FR" : translatingLang(
        name: NSLocalizedString("br-FR", comment:""),
        code:"br-FR",
        hearingEquivalences:[]
    ),
    "bg-BG" : translatingLang(
        name: NSLocalizedString("bg-BG", comment:""),
        code:"bg-BG",
        hearingEquivalences:[]
    ),
    "my-MM" : translatingLang(
        name: NSLocalizedString("my-MM", comment:""),
        code:"my-MM",
        hearingEquivalences:[]
    ),
    "ca-ES" : translatingLang(
        name: NSLocalizedString("ca-ES", comment:""),
        code:"ca-ES",
        hearingEquivalences:["cat-ESP"]
    ),
    "cb-PH" : translatingLang(
        name: NSLocalizedString("cb-PH", comment:""),
        code:"cb-PH",
        hearingEquivalences:[]
    ),
    "ch-GU" : translatingLang(
        name: NSLocalizedString("ch-GU", comment:""),
        code:"ch-GU",
        hearingEquivalences:[]
    ),
    "zh-CN" : translatingLang(
        name: NSLocalizedString("zh-CN", comment:""),
        code:"zh-CN",
        hearingEquivalences:["cmn-CHN"]
    ),
    "zh-TW" : translatingLang(
        name: NSLocalizedString("zh-TW", comment:""),
        code:"zh-TW",
        hearingEquivalences:["cmn-TWN"]
    ),
    "zdj-KM" : translatingLang(
        name: NSLocalizedString("zdj-KM", comment:""),
        code:"zdj-KM",
        hearingEquivalences:[]
    ),
    "cop-EG" : translatingLang(
        name: NSLocalizedString("cop-EG", comment:""),
        code:"cop-EG",
        hearingEquivalences:[]
    ),
    "hr-HR" : translatingLang(
        name: NSLocalizedString("hr-HR", comment:""),
        code:"hr-HR",
        hearingEquivalences:["hrv-HRV"]
    ),
    "cs-CZ" : translatingLang(
        name: NSLocalizedString("cs-CZ", comment:""),
        code:"cs-CZ",
        hearingEquivalences:["ces-CZE"]
    ),
    "da-DK" : translatingLang(
        name: NSLocalizedString("da-DK", comment:""),
        code:"da-DK",
        hearingEquivalences:["dan-DNK"]
    ),
    "nl-NL" : translatingLang(
        name: NSLocalizedString("nl-NL", comment:""),
        code:"nl-NL",
        hearingEquivalences:["nld-NLD"]
    ),
    "dz-BT" : translatingLang(
        name: NSLocalizedString("dz-BT", comment:""),
        code:"dz-BT",
        hearingEquivalences:[]
    ),
    "en-GB" : translatingLang(
        name: NSLocalizedString("en-GB", comment:""),
        code:"en-GB",
        hearingEquivalences:["eng-AUS", "eng-GBR", "eng-USA", "eng-IND"]
    ),
    "eo-EU" : translatingLang(
        name: NSLocalizedString("eo-EU", comment:""),
        code:"eo-EU",
        hearingEquivalences:[]
    ),
    "et-EE" : translatingLang(
        name: NSLocalizedString("et-EE", comment:""),
        code:"et-EE",
        hearingEquivalences:[]
    ),
    "fn-FNG" : translatingLang(
        name: NSLocalizedString("fn-FNG", comment:""),
        code:"fn-FNG",
        hearingEquivalences:[]
    ),
    "fo-FO" : translatingLang(
        name: NSLocalizedString("fo-FO", comment:""),
        code:"fo-FO",
        hearingEquivalences:[]
    ),
    "fi-FI" : translatingLang(
        name: NSLocalizedString("fi-FI", comment:""),
        code:"fi-FI",
        hearingEquivalences:["fin-FIN"]
    ),
    "fr-FR" : translatingLang(
        name: NSLocalizedString("fr-FR", comment:""),
        code:"fr-FR",
        hearingEquivalences:["fra-CAN", "fra-FRA"]
    ),
    "gl-ES" : translatingLang(
        name: NSLocalizedString("gl-ES", comment:""),
        code:"gl-ES",
        hearingEquivalences:[]
    ),
    "ka-GE" : translatingLang(
        name: NSLocalizedString("ka-GE", comment:""),
        code:"ka-GE",
        hearingEquivalences:[]
    ),
    "de-DE" : translatingLang(
        name: NSLocalizedString("de-DE", comment:""),
        code:"de-DE",
        hearingEquivalences:["deu-DEU"]
    ),
    "el-GR" : translatingLang(
        name: NSLocalizedString("el-GR", comment:""),
        code:"el-GR",
        hearingEquivalences:["ell-GRC"]
    ),
    "grc-GR" : translatingLang(
        name: NSLocalizedString("grc-GR", comment:""),
        code:"grc-GR",
        hearingEquivalences:["ell-GRC"]
    ),
    "gu-IN" : translatingLang(
        name: NSLocalizedString("gu-IN", comment:""),
        code:"gu-IN",
        hearingEquivalences:[]
    ),
    "ha-NE" : translatingLang(
        name: NSLocalizedString("ha-NE", comment:""),
        code:"ha-NE",
        hearingEquivalences:[]
    ),
    "haw-US" : translatingLang(
        name: NSLocalizedString("haw-US", comment:""),
        code:"haw-US",
        hearingEquivalences:[]
    ),
    "he-IL" : translatingLang(
        name: NSLocalizedString("he-IL", comment:""),
        code:"he-IL",
        hearingEquivalences:["heb-ISR"]
    ),
    "hi-IN" : translatingLang(
        name: NSLocalizedString("hi-IN", comment:""),
        code:"hi-IN",
        hearingEquivalences:["hin-IND"]
    ),
    "hu-HU" : translatingLang(
        name: NSLocalizedString("hu-HU", comment:""),
        code:"hu-HU",
        hearingEquivalences:["hun-HUN"]
    ),
    "is-IS" : translatingLang(
        name: NSLocalizedString("is-IS", comment:""),
        code:"is-IS",
        hearingEquivalences:[]
    ),
    "id-ID" : translatingLang(
        name: NSLocalizedString("id-ID", comment:""),
        code:"id-ID",
        hearingEquivalences:["ind-IND"]
    ),
    "kl-GL" : translatingLang(
        name: NSLocalizedString("kl-GL", comment:""),
        code:"kl-GL",
        hearingEquivalences:[]
    ),
    "ga-IE" : translatingLang(
        name: NSLocalizedString("ga-IE", comment:""),
        code:"ga-IE",
        hearingEquivalences:[]
    ),
    "it-IT" : translatingLang(
        name: NSLocalizedString("it-IT", comment:""),
        code:"it-IT",
        hearingEquivalences:["ita-ITA"]
    ),
    "ja-JA" : translatingLang(
        name: NSLocalizedString("ja-JA", comment:""),
        code:"ja-JA",
        hearingEquivalences:["jpn-JPN"]
    ),
    "jw-ID" : translatingLang(
        name: NSLocalizedString("jw-ID", comment:""),
        code:"jw-ID",
        hearingEquivalences:[]
    ),
    "kea-CV" : translatingLang(
        name: NSLocalizedString("kea-CV", comment:""),
        code:"kea-CV",
        hearingEquivalences:[]
    ),
    "kab-DZ" : translatingLang(
        name: NSLocalizedString("kab-DZ", comment:""),
        code:"kab-DZ",
        hearingEquivalences:[]
    ),
    "ka-IN" : translatingLang(
        name: NSLocalizedString("ka-IN", comment:""),
        code:"ka-IN",
        hearingEquivalences:[]
    ),
    "kk-KZ" : translatingLang(
        name: NSLocalizedString("kk-KZ", comment:""),
        code:"kk-KZ",
        hearingEquivalences:[]
    ),
    "km-KM" : translatingLang(
        name: NSLocalizedString("km-KM", comment:""),
        code:"km-KM",
        hearingEquivalences:[]
    ),
    "rw-RW" : translatingLang(
        name: NSLocalizedString("rw-RW", comment:""),
        code:"rw-RW",
        hearingEquivalences:[]
    ),
    "rn-RN" : translatingLang(
        name: NSLocalizedString("rn-RN", comment:""),
        code:"rn-RN",
        hearingEquivalences:[]
    ),
    "ko-KR" : translatingLang(
        name: NSLocalizedString("ko-KR", comment:""),
        code:"ko-KR",
        hearingEquivalences:["kor-KOR"]
    ),
    "ku-TR" : translatingLang(
        name: NSLocalizedString("ku-TR", comment:""),
        code:"ku-TR",
        hearingEquivalences:[]
    ),
    "ky-KG" : translatingLang(
        name: NSLocalizedString("ky-KG", comment:""),
        code:"ky-KG",
        hearingEquivalences:[]
    ),
    "lo-LA" : translatingLang(
        name: NSLocalizedString("lo-LA", comment:""),
        code:"lo-LA",
        hearingEquivalences:[]
    ),
    "la-VA" : translatingLang(
        name: NSLocalizedString("la-VA", comment:""),
        code:"la-VA",
        hearingEquivalences:[]
    ),
    "lv-LV" : translatingLang(
        name: NSLocalizedString("lv-LV", comment:""),
        code:"lv-LV",
        hearingEquivalences:[]
    ),
    "lt-LT" : translatingLang(
        name: NSLocalizedString("lt-LT", comment:""),
        code:"lt-LT",
        hearingEquivalences:[]
    ),
    "lb-LU" : translatingLang(
        name: NSLocalizedString("lb-LU", comment:""),
        code:"lb-LU",
        hearingEquivalences:[]
    ),
    "mk-MK" : translatingLang(
        name: NSLocalizedString("mk-MK", comment:""),
        code:"mk-MK",
        hearingEquivalences:[]
    ),
    "mg-MG" : translatingLang(
        name: NSLocalizedString("mg-MG", comment:""),
        code:"mg-MG",
        hearingEquivalences:[]
    ),
    "ms-MY" : translatingLang(
        name: NSLocalizedString("ms-MY", comment:""),
        code:"ms-MY",
        hearingEquivalences:["zlm-MYS"]
    ),
    "dv-MV" : translatingLang(
        name: NSLocalizedString("dv-MV", comment:""),
        code:"dv-MV",
        hearingEquivalences:[]
    ),
    "mt-MT" : translatingLang(
        name: NSLocalizedString("mt-MT", comment:""),
        code:"mt-MT",
        hearingEquivalences:[]
    ),
    "gv-IM" : translatingLang(
        name: NSLocalizedString("gv-IM", comment:""),
        code:"gv-IM",
        hearingEquivalences:[]
    ),
    "mi-NZ" : translatingLang(
        name: NSLocalizedString("mi-NZ", comment:""),
        code:"mi-NZ",
        hearingEquivalences:[]
    ),
    "mh-MH" : translatingLang(
        name: NSLocalizedString("mh-MH", comment:""),
        code:"mh-MH",
        hearingEquivalences:[]
    ),
    "men-SL" : translatingLang(
        name: NSLocalizedString("men-SL", comment:""),
        code:"men-SL",
        hearingEquivalences:[]
    ),
    "mn-MN" : translatingLang(
        name: NSLocalizedString("mn-MN", comment:""),
        code:"mn-MN",
        hearingEquivalences:[]
    ),
    "mfe-MU" : translatingLang(
        name: NSLocalizedString("mfe-MU", comment:""),
        code:"mfe-MU",
        hearingEquivalences:[]
    ),
    "ne-NP" : translatingLang(
        name: NSLocalizedString("ne-NP", comment:""),
        code:"ne-NP",
        hearingEquivalences:[]
    ),
    "niu-NU" : translatingLang(
        name: NSLocalizedString("niu-NU", comment:""),
        code:"niu-NU",
        hearingEquivalences:[]
    ),
    "no-NO" : translatingLang(
        name: NSLocalizedString("no-NO", comment:""),
        code:"no-NO",
        hearingEquivalences:["nor-NOR"]
    ),
    "ny-MW" : translatingLang(
        name: NSLocalizedString("ny-MW", comment:""),
        code:"ny-MW",
        hearingEquivalences:[]
    ),
    "ur-PK" : translatingLang(
        name: NSLocalizedString("ur-PK", comment:""),
        code:"ur-PK",
        hearingEquivalences:[]
    ),
    "pau-PW" : translatingLang(
        name: NSLocalizedString("pau-PW", comment:""),
        code:"pau-PW",
        hearingEquivalences:[]
    ),
    "pa-IN" : translatingLang(
        name: NSLocalizedString("pa-IN", comment:""),
        code:"pa-IN",
        hearingEquivalences:[]
    ),
    "pap-PAP" : translatingLang(
        name: NSLocalizedString("pap-PAP", comment:""),
        code:"pap-PAP",
        hearingEquivalences:[]
    ),
    "ps-PK" : translatingLang(
        name: NSLocalizedString("ps-PK", comment:""),
        code:"ps-PK",
        hearingEquivalences:[]
    ),
    "fa-IR" : translatingLang(
        name: NSLocalizedString("fa-IR", comment:""),
        code:"fa-IR",
        hearingEquivalences:[]
    ),
    "pis-SB" : translatingLang(
        name: NSLocalizedString("pis-SB", comment:""),
        code:"pis-SB",
        hearingEquivalences:[]
    ),
    "pl-PL" : translatingLang(
        name: NSLocalizedString("pl-PL", comment:""),
        code:"pl-PL",
        hearingEquivalences:["pol-POL"]
    ),
    "pt-PT" : translatingLang(
        name: NSLocalizedString("pt-PT", comment:""),
        code:"pt-PT",
        hearingEquivalences:["por-BRA", "por-PRT"]
    ),
    "pot-US" : translatingLang(
        name: NSLocalizedString("pot-US", comment:""),
        code:"pot-US",
        hearingEquivalences:[]
    ),
    "qu-PE" : translatingLang(
        name: NSLocalizedString("qu-PE", comment:""),
        code:"qu-PE",
        hearingEquivalences:[]
    ),
    "ro-RO" : translatingLang(
        name: NSLocalizedString("ro-RO", comment:""),
        code:"ro-RO",
        hearingEquivalences:["ron-ROU"]
    ),
    "ru-RU" : translatingLang(
        name: NSLocalizedString("ru-RU", comment:""),
        code:"ru-RU",
        hearingEquivalences:["rus-RUS"]
    ),
    "sm-WS" : translatingLang(
        name: NSLocalizedString("sm-WS", comment:""),
        code:"sm-WS",
        hearingEquivalences:[]
    ),
    "sg-CF" : translatingLang(
        name: NSLocalizedString("sg-CF", comment:""),
        code:"sg-CF",
        hearingEquivalences:[]
    ),
    "gd-GB" : translatingLang(
        name: NSLocalizedString("gd-GB", comment:""),
        code:"gd-GB",
        hearingEquivalences:[]
    ),
    "sr-RS" : translatingLang(
        name: NSLocalizedString("sr-RS", comment:""),
        code:"sr-RS",
        hearingEquivalences:[]
    ),
    "sn-ZW" : translatingLang(
        name: NSLocalizedString("sn-ZW", comment:""),
        code:"sn-ZW",
        hearingEquivalences:[]
    ),
    "si-LK" : translatingLang(
        name: NSLocalizedString("si-LK", comment:""),
        code:"si-LK",
        hearingEquivalences:[]
    ),
    "sk-SK" : translatingLang(
        name: NSLocalizedString("sk-SK", comment:""),
        code:"sk-SK",
        hearingEquivalences:["slk-SVK"]
    ),
    "sl-SI" : translatingLang(
        name: NSLocalizedString("sl-SI", comment:""),
        code:"sl-SI",
        hearingEquivalences:[]
    ),
    "so-SO" : translatingLang(
        name: NSLocalizedString("so-SO", comment:""),
        code:"so-SO",
        hearingEquivalences:[]
    ),
    "st-LS" : translatingLang(
        name: NSLocalizedString("st-LS", comment:""),
        code:"st-LS",
        hearingEquivalences:[]
    ),
    "es-ES" : translatingLang(
        name: NSLocalizedString("es-ES", comment:""),
        code:"es-ES",
        hearingEquivalences:["spa-ESP", "spa-XLA"]
    ),
    "srn-SR" : translatingLang(
        name: NSLocalizedString("srn-SR", comment:""),
        code:"srn-SR",
        hearingEquivalences:[]
    ),
    "sw-SZ" : translatingLang(
        name: NSLocalizedString("sw-SZ", comment:""),
        code:"sw-SZ",
        hearingEquivalences:[]
    ),
    "sv-SE" : translatingLang(
        name: NSLocalizedString("sv-SE", comment:""),
        code:"sv-SE",
        hearingEquivalences:["swe-SWE"]
    ),
    "de-CH" : translatingLang(
        name: NSLocalizedString("de-CH", comment:""),
        code:"de-CH",
        hearingEquivalences:[]
    ),
    "syc-TR" : translatingLang(
        name: NSLocalizedString("syc-TR", comment:""),
        code:"syc-TR",
        hearingEquivalences:[]
    ),
    "tl-PH" : translatingLang(
        name: NSLocalizedString("tl-PH", comment:""),
        code:"tl-PH",
        hearingEquivalences:[]
    ),
    "tg-TJ" : translatingLang(
        name: NSLocalizedString("tg-TJ", comment:""),
        code:"tg-TJ",
        hearingEquivalences:[]
    ),
    "tmh-DZ" : translatingLang(
        name: NSLocalizedString("tmh-DZ", comment:""),
        code:"tmh-DZ",
        hearingEquivalences:[]
    ),
    "ta-LK" : translatingLang(
        name: NSLocalizedString("ta-LK", comment:""),
        code:"ta-LK",
        hearingEquivalences:[]
    ),
    "te-IN" : translatingLang(
        name: NSLocalizedString("te-IN", comment:""),
        code:"te-IN",
        hearingEquivalences:[]
    ),
    "tet-TL" : translatingLang(
        name: NSLocalizedString("tet-TL", comment:""),
        code:"tet-TL",
        hearingEquivalences:[]
    ),
    "th-TH" : translatingLang(
        name: NSLocalizedString("th-TH", comment:""),
        code:"th-TH",
        hearingEquivalences:["tha-THA"]
    ),
    "bo-CN" : translatingLang(
        name: NSLocalizedString("bo-CN", comment:""),
        code:"bo-CN",
        hearingEquivalences:[]
    ),
    "ti-TI" : translatingLang(
        name: NSLocalizedString("ti-TI", comment:""),
        code:"ti-TI",
        hearingEquivalences:[]
    ),
    "tpi-PG" : translatingLang(
        name: NSLocalizedString("tpi-PG", comment:""),
        code:"tpi-PG",
        hearingEquivalences:[]
    ),
    "tkl-TK" : translatingLang(
        name: NSLocalizedString("tkl-TK", comment:""),
        code:"tkl-TK",
        hearingEquivalences:[]
    ),
    "to-TO" : translatingLang(
        name: NSLocalizedString("to-TO", comment:""),
        code:"to-TO",
        hearingEquivalences:[]
    ),
    "tn-BW" : translatingLang(
        name: NSLocalizedString("tn-BW", comment:""),
        code:"tn-BW",
        hearingEquivalences:[]
    ),
    "tr-TR" : translatingLang(
        name: NSLocalizedString("tr-TR", comment:""),
        code:"tr-TR",
        hearingEquivalences:["tur-TUR"]
    ),
    "tk-TM" : translatingLang(
        name: NSLocalizedString("tk-TM", comment:""),
        code:"tk-TM",
        hearingEquivalences:[]
    ),
    "tvl-TV" : translatingLang(
        name: NSLocalizedString("tvl-TV", comment:""),
        code:"tvl-TV",
        hearingEquivalences:[]
    ),
    "uk-UA" : translatingLang(
        name: NSLocalizedString("uk-UA", comment:""),
        code:"uk-UA",
        hearingEquivalences:["ukr-UKR"]
    ),
    "ppk-ID" : translatingLang(
        name: NSLocalizedString("ppk-ID", comment:""),
        code:"ppk-ID",
        hearingEquivalences:[]
    ),
    "uz-UZ" : translatingLang(
        name: NSLocalizedString("uz-UZ", comment:""),
        code:"uz-UZ",
        hearingEquivalences:[]
    ),
    "vi-VN" : translatingLang(
        name: NSLocalizedString("vi-VN", comment:""),
        code:"vi-VN",
        hearingEquivalences:["vie-VNM"]
    ),
    "wls-WF" : translatingLang(
        name: NSLocalizedString("wls-WF", comment:""),
        code:"wls-WF",
        hearingEquivalences:[]
    ),
    "cy-GB" : translatingLang(
        name: NSLocalizedString("cy-GB", comment:""),
        code:"cy-GB",
        hearingEquivalences:[]
    ),
    "wo-SN" : translatingLang(
        name: NSLocalizedString("wo-SN", comment:""),
        code:"wo-SN",
        hearingEquivalences:[]
    ),
    "xh-ZA" : translatingLang(
        name: NSLocalizedString("xh-ZA", comment:""),
        code:"xh-ZA",
        hearingEquivalences:[]
    ),
    "yi-YD" : translatingLang(
        name: NSLocalizedString("yi-YD", comment:""),
        code:"yi-YD",
        hearingEquivalences:[]
    ),
    "zu-ZU" : translatingLang(
        name: NSLocalizedString("zu-ZU", comment:""),
        code:"zu-ZU",
        hearingEquivalences:[])

]

