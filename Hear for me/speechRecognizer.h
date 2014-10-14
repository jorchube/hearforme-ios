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


#define IDLE 0
#define HEARING 1
#define PROCESSING 2

#define PREPARING 10


@interface speechRecognizer : NSObject <SKRecognizerDelegate>

@property SKRecognizer* recognizer;
@property UITextView* textview;
@property int shouldListen;
@property int status;

-(void) setup:(UIViewController*) vc;
-(void) startRecognitionLanguage;
-(void) stopRecognition;
-(void) cancelRecognition;
-(void) destroyRecognizer;
-(void) setHearingLanguage:(NSString*) hLang translatingLanguage:(NSString*) tLang wantsTranslation:(BOOL) hasToTranslate;
//-(void) translationFinishedWithResult:(NSString*)str;

@end
