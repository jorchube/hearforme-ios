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

#import "Translator.h"
#import "PrivateKeys.h"
#import "RecognizerUnit.h"
#import "Status.h"


@interface speechRecognizer : NSObject <SKRecognizerDelegate>

@property RecognizerUnit* recogUnit00;
@property RecognizerUnit* recogUnit01;
@property UITextView* textview;
@property int shouldListen;
@property int status;

-(void) setup:(UIViewController*) vc;
-(void) startRecognitionLanguage;
-(void) stopRecognition;
-(void) cancelRecognition;
-(void) destroyRecognizer;
-(int) getStatus;
-(void) setHearingLanguage:(NSString*) hLang translatingLanguage:(NSString*) tLang wantsTranslation:(BOOL) hasToTranslate;
//-(void) translationFinishedWithResult:(NSString*)str;

@end
