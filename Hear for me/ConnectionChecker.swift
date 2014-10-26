//
//  ConnectionChecker.swift
//  Hear for me
//
//  Created by Jordi Chulia on 24/10/14.
//  Copyright (c) 2014 Jordi Chulia. All rights reserved.
//

import UIKit

protocol connectionStatusDemander {
    func receivedNetworkStatus(status: ConnectionChecker.netStatus)
}

class ConnectionChecker: NSObject {
   
    let networkCheckURL1: String = "http://www.google.com"
    let networkCheckURL2: String = "http://www.amazon.co.uk"
    
    enum netStatus {
        case down, up
    }
    
    var statusDemander: connectionStatusDemander?
    
    init(demander: connectionStatusDemander) {
        statusDemander = demander
        super.init()
    }
    
    private func responseOK() {
        NSLog("Network OK")
        self.statusDemander?.receivedNetworkStatus(netStatus.up)
    }
    
    private func responseFAIL() {
        NSLog("Network DOWN")
        self.statusDemander?.receivedNetworkStatus(netStatus.down)
    }
    
    private func doubleCheck() {
        
        let request: NSMutableURLRequest = NSMutableURLRequest(URL: NSURL(string: networkCheckURL2)!)
        request.HTTPMethod = "HEAD"
        
        NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue(),
            completionHandler: { (response: NSURLResponse!, data: NSData!, error: NSError!) in
                if response != nil { self.responseOK() }
                if error != nil { self.responseFAIL() }
        } )
    }
    
    func check() {
        
        let request: NSMutableURLRequest = NSMutableURLRequest(URL: NSURL(string: networkCheckURL1)!)
        request.HTTPMethod = "HEAD"
        
        NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue(),
            completionHandler: { (response: NSURLResponse!, data: NSData!, error: NSError!) in

                if response != nil { self.responseOK() }
                if error != nil { self.doubleCheck() }
            } )
        
        
    }

}


