//
//  speechRecognizer.m
//  Hear for me
//
//  Created by Jordi Chulia on 06/10/14.
//  Copyright (c) 2014 Jordi Chulia. All rights reserved.
//

#import "speechRecognizer.h"
#import "Hear_for_me-Swift.h"
#import "PrivateKeys.h"

#define REFRESH_INTERVAL 3 /* seconds */

const unsigned char SpeechKitApplicationKey[] = PRIVATE_SpeechKitApplicationKey;


@implementation speechRecognizer

@synthesize recognizer;
@synthesize textview;
@synthesize shouldListen;
@synthesize status;

const NSString* nuanceID = PRIVATE_nuanceID;
const NSString* nuanceHost = @"sandbox.nmdp.nuancemobility.net";

ViewController* vc;

int killerTurn = 1;

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
                    useSSL:NO
                  delegate:nil];
    status = IDLE;
}

-(void) recognizeNowWithStopType:(SKEndOfSpeechDetection) StopDetectionType
{
    status = PREPARING;
    NSLog(@"Recognizing");
    if (recognizer) recognizer = nil;
    recognizer = [[SKRecognizer alloc] initWithType:SKDictationRecognizerType
                                          detection:StopDetectionType
                                           language:@"spa-ESP"
                                           delegate:self];

    if (recognizer == nil){
        NSLog(@"Fucking nil");
        status = IDLE;
    }
}

-(void) recognizerDidBeginRecording:(SKRecognizer *)recognizer
{
    NSLog(@"Begin recording");
    status = HEARING;
}

-(void) recognizerDidFinishRecording:(SKRecognizer *)recognizer
{
    NSLog(@"Finish recording");
    status = PROCESSING;
}

-(void) recognizer:(SKRecognizer *)r didFinishWithError:(NSError *)error suggestion:(NSString *)suggestion
{
    NSLog(@"Recognition error: %@", error);
    status = IDLE;
    recognizer = nil;
}

-(void) recognizer:(SKRecognizer *)r didFinishWithResults:(SKRecognition *)results
{
    
    NSLog(@"Result: %@", [results firstResult]);
    
    if ([results firstResult]){
        [textview insertText:[results firstResult]];
        [textview insertText:@"\n"];
        NSRange range = NSMakeRange([textview.text length]-2, [textview.text length]-1);
        [textview scrollRangeToVisible:range];
    }
    NSLog(@"TextView string: %@", [textview text]);
    status = IDLE;
    recognizer = nil;
    //[vc finishedRecognizing];
}


-(void) startRecognition
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
    killerTurn = 1;
    [recognizer cancel];
    //[SpeechKit destroy];
}

-(void) destroyRecognizer
{
    [SpeechKit destroy];
}

@end
