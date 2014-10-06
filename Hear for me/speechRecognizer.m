//
//  speechRecognizer.m
//  Hear for me
//
//  Created by Jordi Chulia on 06/10/14.
//  Copyright (c) 2014 Jordi Chulia. All rights reserved.
//

#import "speechRecognizer.h"
#import "Hear_for_me-Swift.h"

const unsigned char SpeechKitApplicationKey[] = {0x36, 0x70, 0xb4, 0xd7, 0x35, 0xb1, 0xe6, 0x79, 0x2d, 0xa0, 0xbb, 0x3e, 0x1c, 0xc7, 0x73, 0xef, 0xb8, 0xb6, 0x06, 0xf7, 0x50, 0x8f, 0x49, 0x7a, 0x13, 0x22, 0x57, 0xe5, 0xb3, 0x30, 0xe7, 0xe9, 0xa0, 0x9b, 0xc1, 0xd5, 0x4d, 0xa7, 0x4e, 0x7a, 0x47, 0x0a, 0xb8, 0x63, 0xd1, 0x2c, 0x52, 0x89, 0xe2, 0x59, 0x81, 0x33, 0xe8, 0xca, 0xad, 0xfb, 0xec, 0x05, 0xe0, 0x9f, 0x35, 0xc8, 0x89, 0xd5};

ViewController* vc;

@implementation speechRecognizer

@synthesize recognizer;
@synthesize textview;
@synthesize shouldListen;


-(id) init
{
    self = [super init];
    shouldListen =  false;
    return self;
}

-(void) setup
{
    [SpeechKit setupWithID:@"NMDPTRIAL_jorchube20141006101458"
                      host:@"sslsandbox.nmdp.nuancemobility.net"
                      port:443
                    useSSL:YES
                  delegate:nil];
    
}

-(void) recognizeNow: (ViewController*) sender
{
    vc = sender;
    NSLog(@"Recognizing");
    if (recognizer) recognizer = nil;
    recognizer = [[SKRecognizer alloc] initWithType:SKDictationRecognizerType
                        detection:SKShortEndOfSpeechDetection
                         language:@"eng-USA"
                         delegate:self];

}

-(void) recognizerDidFinishRecording:(SKRecognizer *)recognizer
{
    NSLog(@"Finish recording");
    /*if (shouldListen == 1) {
        NSLog(@"RecordingAgain");
        [self recognizeNow];
    }*/
    
}

-(void) recognizer:(SKRecognizer *)r didFinishWithError:(NSError *)error suggestion:(NSString *)suggestion
{
    NSLog(@"finished with error");
    recognizer = nil;
    NSLog(@"Recognition error: %@", error);
}

-(void) recognizer:(SKRecognizer *)r didFinishWithResults:(SKRecognition *)results
{
    
    NSLog(@"finished with results");
    recognizer = nil;
    NSLog(@"Result: %@", [results firstResult]);
    
    if ( [[textview text] isEqualToString: @""]) {
        [textview setText:[results firstResult]];
    }
    else if (results){
        [[textview text] stringByAppendingString:[results firstResult]];
    }
    [vc continueRecognizing];
    
    
}

@end
