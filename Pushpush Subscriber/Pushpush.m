//
//  Pushpush.m
//  Pushpush Subscriber
//
//  Created by Rick Pastoor on 11-04-13.
//  Copyright (c) 2013 Wrep. All rights reserved.
//

#import "Pushpush.h"

static NSString * const kPushtokenKey = @"com.pushpush.pushtoken";

@implementation Pushpush

+ (void)subscribeToPushPushWithChannelKey:(NSString*)channelKey andDeviceToken:(NSData*)deviceToken
{
    // Get existing pushtoken
    NSString *existingPushtoken = [[NSUserDefaults standardUserDefaults] objectForKey:kPushtokenKey];
    
    // Process channelkey
    NSArray *keyParts = [channelKey componentsSeparatedByString:@"-"];
    
    // Prepare url
    NSString *url = [NSString stringWithFormat:@"http://%@:%@@pushpush.wrep.nl/api/receiver/register.json", [keyParts objectAtIndex:0], [keyParts objectAtIndex:1]];
    
    // Build request
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:url]];
    
    // Process devicetoken
    NSString *pushToken = [[[deviceToken description] stringByReplacingOccurrencesOfString:@" " withString:@""]
                           stringByTrimmingCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"<>"]];
    
    // Prepare payload
    NSMutableDictionary *payload = [[NSMutableDictionary alloc] initWithObjectsAndKeys:pushToken, @"devicetoken", nil];
    if (existingPushtoken != nil)
    {
        [payload setObject:existingPushtoken forKey:@"pushtoken"];
    }
    
    // Set method and body
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:[NSJSONSerialization dataWithJSONObject:payload
                                                         options:NSJSONWritingPrettyPrinted
                                                           error:nil]];
    [request setValue:@"application/json" forHTTPHeaderField:@"content-type"];
    
    NSURLResponse* response = nil;
    NSData *responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:nil];
    
    int statusCode = [((NSHTTPURLResponse *)response) statusCode];
    if (statusCode == 200 || statusCode == 201) {
        NSLog(@"[Pushpush] Got positive response: %d.", statusCode);
        
        // Collect and parse JSON
        NSError* error;
        NSDictionary* jsonObject = [NSJSONSerialization JSONObjectWithData:responseData
                                                                   options:kNilOptions
                                                                     error:&error];
        
        // Access and store pushtoken
        [[NSUserDefaults standardUserDefaults] setObject:[jsonObject objectForKey:@"pushtoken"] forKey:kPushtokenKey];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
    else
    {
        NSLog(@"[Pushpush] Uhoh, got a bad response from the server: %d.", statusCode);
    }
}
@end
