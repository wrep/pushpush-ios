//
//  Pushpush.h
//  Pushpush Subscriber
//
//  Created by Rick Pastoor on 11-04-13.
//  Copyright (c) 2013 Wrep. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Pushpush : NSObject
+ subscribeToPushPushWithChannelKey:(NSString*)channelKey andDeviceToken:(NSString*)deviceToken;
@end
