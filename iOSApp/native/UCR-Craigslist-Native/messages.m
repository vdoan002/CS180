//
//  messages.m
//  UCR-Craigslist-Native
//
//  Created by Michael Chen on 5/20/16.
//  Copyright © 2016 UCR. All rights reserved.
//

#import "messages.h"

@implementation messages
@synthesize message_id, message_sender, message_receiver, message_content, message_timesent, message_date, message_seen, message_threadLoaded;


- (id)initWithMessages: (NSString *)_message_id message_sender: (NSString *)_message_sender message_receiver: (NSString *)_message_receiver message_content: (NSString *)_message_content message_timesent: (NSString *)_message_timesent message_date: (NSString *)_message_date message_seen: (NSString *)_message_seen message_threadLoaded: (BOOL)_message_threadLoaded{
    
    self = [super init];
    if (self){
        message_id = _message_id;
        message_sender = _message_sender;
        message_receiver = _message_receiver;
        message_content = _message_content;
        message_timesent = _message_timesent;
        message_date = _message_date;
        message_seen = _message_seen;
        message_threadLoaded = _message_threadLoaded;
    }
    
    return self;
}

@end
