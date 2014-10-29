//
//  Translator.m
//  Hear for me
//
//  Created by Jordi Chulia on 14/10/14.
//  Copyright (c) 2014 Jordi Chulia. All rights reserved.
//

#import "Translator.h"
#import "PrivateKeys.h"

#import <Foundation/Foundation.h>



@implementation Translator

/*
 GET https://www.googleapis.com/language/translate/v2?key=INSERT-YOUR-KEY&target=de&q=Hello
 */



/*
 
 class func translate(target: String, payload:String) {
 
 let key: String = PRIVATE_googleKey
 
 var _scheme:String = "https"
 var _host:String = "www.googleapis.com"
 var _path:String = "/language/translate/v2?key=" + key + "&target=" + target + "&q=" + payload
 
 var _url:NSURL? = NSURL(scheme: _scheme, host: _host, path: _path)
 
 var _request: NSURLRequest = NSURLRequest(URL: _url! )
 
 NSURLConnection(request: _request, delegate: self)
 }
 
 func connection(connection: NSURLConnection, didReceiveData data: NSData) {
 var str:String? = NSString(data: data, encoding: NSUTF8StringEncoding)
 NSLog("Received: " + str!)
 
 }
 
 
 */
UITextView* _textview;
NSMutableData* receivedData;


+(NSString*) translate:(NSString *)str fromLang:(NSString *)sourceLang toLang:(NSString *)targetLang
{
    
    NSLog(@"from: %@, to: %@", sourceLang, targetLang);
    /*NSString* _scheme = @"https";
    NSString* _host = @"www.googleapis.com";
    NSString* _path = [NSString stringWithFormat: @"%@%@%@%@%@%@",
                       @"/language/translate/v2?key=",
                       key,
                       @"&target=",
                       target,
                       @"&q=",
                       str];*/
    
    /* http://api.mymemory.translated.net/get?q=Hello World!&langpair=en|it */
    
    
    NSString* sanitizedStr = [str stringByReplacingOccurrencesOfString:@"&" withString:@""];
    
    NSString* _scheme = @"http";
    NSString* _host = @"api.mymemory.translated.net";
    NSString* _path = [NSString stringWithFormat:@"%@%@%@%@%@%@",
                       @"/get?q=",
                       sanitizedStr,
                       @"&langpair=",
                       sourceLang,
                       @"|",
                       targetLang];

    
    NSURL* url = [[NSURL alloc] initWithScheme:_scheme host:_host path:_path];
    
    
    //NSLog(@"source:%@, target:%@\n%@", sourceLang, targetLang, [NSString stringWithContentsOfURL:url encoding:NSUTF8StringEncoding error:nil]);
    
    NSURLRequest* request = [NSURLRequest requestWithURL:url];
    
    NSURLResponse* response;
    NSError* error;
    
    NSData* result = [NSURLConnection sendSynchronousRequest:request
                          returningResponse:&response
                                      error:&error];
    
    if (error) {
        NSLog(@"Transalte error");
    }
    
    if (result) {
        NSDictionary* object = [NSJSONSerialization JSONObjectWithData:result options:NSJSONReadingAllowFragments error:nil];
        if (object) {
            NSLog(@"Status: %@", [object valueForKeyPath:@"responseStatus"]);
            if ( [[object valueForKeyPath:@"responseStatus"] integerValue] == 200 ){
                if ( [[object valueForKeyPath:@"matches.translation"] count] > 0 ) {
                    NSLog(@"Translation: %@",
                          [object valueForKeyPath:@"matches.translation"][0]);
                    return [object valueForKeyPath:@"matches.translation"][0];
                }
            }
        }
    }
    
    return nil;
}





+(void) translate:(NSString *)str toLang: (NSString *) target inTextView:(UITextView *)textview
{
    _textview = textview;
    
    NSString *key = @PRIVATE_googleKey;
    
    NSString* _scheme = @"https";
    NSString* _host = @"www.googleapis.com";
    NSString* _path = [NSString stringWithFormat: @"%@%@%@%@%@%@",
                       @"/language/translate/v2?key=",
                       key,
                       @"&target=",
                       target,
                       @"&q=",
                       str];

    
    /*NSString* urlString = [NSString stringWithFormat:@"%@%@%@",
                           _scheme,
                           _host,
                           _path];
    
    NSURL* url = [[NSURL alloc] initWithString:urlString];*/
    
    NSURL* url = [[NSURL alloc] initWithScheme:_scheme host:_host path:_path];
    
    NSURLRequest* request = [NSURLRequest requestWithURL:url];
    
    
    [NSURLConnection sendAsynchronousRequest:request
                                       queue:[NSOperationQueue mainQueue]
                           completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError)
    {
        if(!connectionError){
            NSString* str = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
            _textview.text = [NSString stringWithFormat:@"%@%@", [_textview text], str];
        }
        else NSLog(@"Connection error");
    }];
    
}

/*
-(void) connectionDidFinishLoading: (NSConnection*) connection
{
    
    
    NSString* str = [[NSString alloc]initWithData:receivedData encoding:NSUTF8StringEncoding];
    _textview.text = [NSString stringWithFormat:@"%@%@", [_textview text], str];
}

-(void) connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    receivedData = [[NSMutableData alloc]init];
}

-(void) connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    [receivedData appendData:data];
}

-(void) connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    NSLog(@"Translate request failed");
}
*/

@end







