//
//  speechRecognizer.m
//  Hear for me
//
//  Created by Jordi Chulia on 06/10/14.
//  Copyright (c) 2014 Jordi Chulia. All rights reserved.
//

#import "speechRecognizer.h"
#import "Hear_for_me-Swift.h"

#define REFRESH_INTERVAL 3 /* seconds */

const unsigned char SpeechKitApplicationKey[] = PRIVATE_SpeechKitApplicationKey;


@implementation speechRecognizer

@synthesize recogUnit00;
@synthesize recogUnit01;
@synthesize textview;
@synthesize shouldListen;
@synthesize status;

const NSString* nuanceID = PRIVATE_nuanceID;
const NSString* nuanceHost = @"sslsandbox.nmdp.nuancemobility.net";


NSString* hearingLanguage;
NSString* translatingLanguage;
bool    wantsTranslation;
bool    waitForTranslation;

ViewController* vc;

int currentRecognizer;

-(id) init
{
    self = [super init];
    shouldListen = 0;
    
    return self;
}

-(void) setup: (ViewController *) sender
{
    NSLog(@"Setting up");
    vc = sender;
    [SpeechKit setupWithID:(NSString*)nuanceID
                      host:(NSString*)nuanceHost
                      port:443
                    useSSL:YES
                  delegate:nil];
    
    recogUnit00 = [[RecognizerUnit alloc] init];
    recogUnit01 = [[RecognizerUnit alloc] init];
    
}

-(void) recognizeNowWithStopType:(SKEndOfSpeechDetection) StopDetectionType unit:(RecognizerUnit*) unit
{
    status = PREPARING;
    NSLog(@"Recognizing");
    if (unit.recognizer) unit.recognizer = nil;
    unit.recognizer = [[SKRecognizer alloc] initWithType:SKDictationRecognizerType
                                          detection:StopDetectionType
                                           language:hearingLanguage
                                           delegate:self];

    if (unit.recognizer == nil){ unit.status = IDLE; }
}

-(void) recognizerDidBeginRecording:(SKRecognizer *)recognizer
{
    NSLog(@"Begin recording");
    if (recognizer == recogUnit00.recognizer){
        NSLog(@"Recog 00");
        recogUnit00.status = HEARING;
    }
    if (recognizer == recogUnit01.recognizer){
        NSLog(@"Recog 01");
        recogUnit01.status = HEARING;
    }
}

-(void) recognizerDidFinishRecording:(SKRecognizer *)recognizer
{
    NSLog(@"Finish recording");
    if (recognizer == recogUnit00.recognizer) recogUnit00.status = PROCESSING;
    if (recognizer == recogUnit01.recognizer) recogUnit01.status = PROCESSING;
}

-(void) recognizer:(SKRecognizer *)r didFinishWithError:(NSError *)error suggestion:(NSString *)suggestion
{
    NSLog(@"Recognition error: %@", error);
    if (r == recogUnit00.recognizer) recogUnit00.status = IDLE;
    if (r == recogUnit01.recognizer) recogUnit01.status = IDLE;
    r = nil;
}
/*
-(void) translationFinishedWithResult:(NSString *)str
{
    translatedResult = str;
    waitForTranslation = false;
}*/

-(void) recognizer:(SKRecognizer *)r didFinishWithResults:(SKRecognition *)results
{
    
    NSLog(@"Result: %@", [results firstResult]);
    
    if ([results firstResult]){
        
        NSString* finalText;
        
        /*if(wantsTranslation){
            [Translator translate:[results firstResult]
                           toLang:translatingLanguage
                       inTextView:textview];
        }
        else*/ {
            finalText = [results firstResult];
        
            [textview insertText:finalText];
            [textview insertText:@"\n"];
            NSRange range = NSMakeRange([textview.text length]-2, [textview.text length]-1);
            [textview scrollRangeToVisible:range];
        }
    }
    NSLog(@"Heard string: %@", [textview text]);
    if (r == recogUnit00.recognizer) recogUnit00.status = IDLE;
    if (r == recogUnit01.recognizer) recogUnit01.status = IDLE;
    r = nil;
}


-(void) startRecognitionLanguage
{
    NSLog(@"Trying to start a recognition");
    shouldListen = 1;
    while(self.getStatus == AVAILABLE || self.getStatus == IDLE){
        if(recogUnit00.status == IDLE){
            recogUnit00.status = BUSY;
            [self recognizeNowWithStopType:SKShortEndOfSpeechDetection unit:recogUnit00];
        }

        else if(self.status == AVAILABLE)
            [self recognizeNowWithStopType:SKShortEndOfSpeechDetection unit:recogUnit01];
    }
}

-(void) stopRecognition
{
    shouldListen = 0;
    [recogUnit00.recognizer stopRecording];
    [recogUnit01.recognizer stopRecording];
}

-(void) cancelRecognition
{
    shouldListen = 0;
    [recogUnit00.recognizer cancel];
    [recogUnit01.recognizer cancel];
}

-(void) destroyRecognizer
{
    [SpeechKit destroy];
}

-(void) setHearingLanguage:(NSString *)hLang translatingLanguage:(NSString *)tLang wantsTranslation:(BOOL)hasToTranslate
{
    hearingLanguage = hLang;
    translatingLanguage = tLang;
    wantsTranslation = hasToTranslate;
}

-(int) getStatus
{
    if (recogUnit00.status == HEARING || recogUnit01.status == HEARING) return HEARING;
    
    if (recogUnit00.status == IDLE && recogUnit01.status == IDLE) return IDLE;
    
    if (recogUnit00.status == IDLE || recogUnit01.status == IDLE) return AVAILABLE;
    
    return BUSY;
}

@end
