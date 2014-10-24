//
//  Protocols.swift
//  Hear for me
//
//  Created by Jordi Chulia on 13/10/14.
//  Copyright (c) 2014 Jordi Chulia. All rights reserved.
//

protocol settingsDelegate {
    func useNewSettings()
}

protocol languagePicker {
    func setSelectedLanguage()
}

protocol connectionStatusDemander {
    func receivedNetworkStatus(status: ConnectionChecker.netStatus)
}