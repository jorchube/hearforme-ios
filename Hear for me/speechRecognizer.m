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

@synthesize recognizer;
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
    status = IDLE;
    [self broadcastStatus];
}

-(void) recognizeNowWithStopType:(SKEndOfSpeechDetection) StopDetectionType
{
    status = PREPARING;
    NSLog(@"Recognizing");
    if (recognizer) recognizer = nil;
    recognizer = [[SKRecognizer alloc] initWithType:SKDictationRecognizerType
                                          detection:StopDetectionType
                                           language:hearingLanguage
                                           delegate:self];

    if (recognizer == nil){ status = IDLE; }
    [self broadcastStatus];
}

-(void) recognizerDidBeginRecording:(SKRecognizer *)recognizer
{
    NSLog(@"Begin recording");
    status = HEARING;
    [self broadcastStatus];
}

-(void) recognizerDidFinishRecording:(SKRecognizer *)recognizer
{
    NSLog(@"Finish recording");
    status = PROCESSING;
    [self broadcastStatus];
}

-(void) recognizer:(SKRecognizer *)r didFinishWithError:(NSError *)error suggestion:(NSString *)suggestion
{
    NSLog(@"Recognition error: %@", error);
    status = IDLE;
    recognizer = nil;
    [self broadcastStatus];
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
    status = IDLE;
    r = nil;
    [self broadcastStatus];
}


-(void) startRecognitionLanguage
{
    shouldListen = 1;
    while (status == IDLE)
        [self recognizeNowWithStopType:SKShortEndOfSpeechDetection];
}

-(void) stopRecognition
{
    shouldListen = 0;
    [recognizer stopRecording];
}

-(void) cancelRecognition
{
    shouldListen = 0;
    [recognizer cancel];
    //[SpeechKit destroy];
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

-(float) getAudioLevel
{
    /*
     recognizer.audioLevel ranges from -90 to 0
     This function returns a value between 0 and 1
     */
    return (recognizer.audioLevel + 90)/90;
}

-(void) broadcastStatus
{
    [vc setRecognizerStatus:status];
}

@end
