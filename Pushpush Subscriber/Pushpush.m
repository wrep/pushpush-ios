//
//  Pushpush.m
//  Pushpush Subscriber
//
//  Created by Rick Pastoor on 11-04-13.
//  Copyright (c) 2013 Wrep. All rights reserved.
//

#import "Pushpush.h"

@implementation Pushpush
+ subscribeToPushPushWithChannelKey:(NSString*)channelKey andDeviceToken:(NSData*)deviceToken
{
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
    NSString *payload = [NSString stringWithFormat:@"devicetoken=%@", pushToken];    
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:[payload dataUsingEncoding:NSUTF8StringEncoding]];
    [request setValue:@"application/json" forHTTPHeaderField:@"content-type"];
    
    NSURLResponse* response = nil;
    [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:nil];
    
    int statusCode = [((NSHTTPURLResponse *)response) statusCode];
    if (statusCode != 200) {
        NSLog(@"Bad response from pushpush received: %d.", statusCode);
    }
}
@end
