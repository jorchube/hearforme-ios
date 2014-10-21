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


#define IDLE        00
#define PREPARING   10
#define HEARING     20
#define PROCESSING  30
#define RESTARTING  40




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
