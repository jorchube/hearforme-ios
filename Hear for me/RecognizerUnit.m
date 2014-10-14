//
//  RecognizerUnit.m
//  Hear for me
//
//  Created by Jordi Chulia on 14/10/14.
//  Copyright (c) 2014 Jordi Chulia. All rights reserved.
//

#import "RecognizerUnit.h"

#import "Status.h"

@implementation RecognizerUnit

@synthesize status;
@synthesize recognizer;


-(id) init
{
    if(self = [super init]){
        self.status = IDLE;
    }
    return self;
}

@end
