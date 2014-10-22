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


#define SETUP       00

#define IDLE        10
#define PREPARING   20
#define HEARING     30
#define PROCESSING  40
#define RESTARTING  50

#define ERROR       99




@interface speechRecognizer : NSObject <SKRecognizerDelegate>

@property SKRecognizer* recognizer;
@property UITextView* textview;
@property BOOL shouldListen;

-(void) setup:(UIViewController*) vc;
-(void) startRecognition;
-(void) stopRecognitionShouldBroadcastStatus:(BOOL) shouldBroadcast;;
-(void) cancelRecognitionShouldBroadcastStatus:(BOOL) shouldBroadcast;;
-(void) destroyRecognizer;
-(void) setHearingLanguage:(NSString*) hLang translatingLanguage:(NSString*) tLang wantsTranslation:(BOOL) hasToTranslate;
//-(void) translationFinishedWithResult:(NSString*)str;
-(float) getAudioLevel; /* returns a value between 0 and 1 */

@end
