//
//  Translator.h
//  Hear for me
//
//  Created by Jordi Chulia on 14/10/14.
//  Copyright (c) 2014 Jordi Chulia. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UITextView.h>

@interface Translator : NSObject <NSURLConnectionDataDelegate>

+(void) translate: (NSString*) str toLang: (NSString*) target inTextView:(UITextView*) textview;

@end
