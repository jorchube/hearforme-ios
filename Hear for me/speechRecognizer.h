//
//  speechRecognizer.h
//  Hear for me
//
//  Created by Jordi Chulia on 06/10/14.
//  Copyright (c) 2014 Jordi Chulia. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#import <SpeechKit/SpeechKit.h>


@interface speechRecognizer : NSObject <SKRecognizerDelegate>

@property SKRecognizer* recognizer;
@property UITextView* textview;
@property int shouldListen;


-(void) setup;
-(void) recognizeNow: (UIViewController*) vc;

@end
