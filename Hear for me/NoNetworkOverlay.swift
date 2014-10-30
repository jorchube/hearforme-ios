//
//  NoNetworkOverlay.swift
//  Hear for me
//
//  Created by Jordi Chulia on 30/10/14.
//  Copyright (c) 2014 Jordi Chulia. All rights reserved.
//

import UIKit

class NoNetworkOverlayView: UIView {

    let initialized : Bool = false
    
    func initialize() {
        if initialized { return }
        
        
        
        initialized = true
    }
    
    override init() {
        super.init()
        
        initialize()
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(aDecoder)
        
        initialize()
    }
    
    override init(frame: CGRect) {
        super.init(frame)
        
        initialize()
    }

    
    
}
