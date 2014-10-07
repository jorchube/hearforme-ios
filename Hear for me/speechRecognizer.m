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

const unsigned char SpeechKitApplicationKey[] = {0x36, 0x70, 0xb4, 0xd7, 0x35, 0xb1, 0xe6, 0x79, 0x2d, 0xa0, 0xbb, 0x3e, 0x1c, 0xc7, 0x73, 0xef, 0xb8, 0xb6, 0x06, 0xf7, 0x50, 0x8f, 0x49, 0x7a, 0x13, 0x22, 0x57, 0xe5, 0xb3, 0x30, 0xe7, 0xe9, 0xa0, 0x9b, 0xc1, 0xd5, 0x4d, 0xa7, 0x4e, 0x7a, 0x47, 0x0a, 0xb8, 0x63, 0xd1, 0x2c, 0x52, 0x89, 0xe2, 0x59, 0x81, 0x33, 0xe8, 0xca, 0xad, 0xfb, 0xec, 0x05, 0xe0, 0x9f, 0x35, 0xc8, 0x89, 0xd5};


@implementation speechRecognizer

@synthesize recognizer;
@synthesize textview;
@synthesize shouldListen;
@synthesize status;

const NSString* nuanceID = @"NMDPTRIAL_jorchube20141006101458";
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
