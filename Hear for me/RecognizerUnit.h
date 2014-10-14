//
//  RecognizerUnit.h
//  Hear for me
//
//  Created by Jordi Chulia on 14/10/14.
//  Copyright (c) 2014 Jordi Chulia. All rights reserved.
//

#import <SpeechKit/SpeechKit.h>



@interface RecognizerUnit : NSObject 

@property int status;
@property SKRecognizer* recognizer;



@end
