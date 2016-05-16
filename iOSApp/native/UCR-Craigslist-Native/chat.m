//
//  chat.m
//  UCR-Craigslist-Native
//
//  Created by Michael Chen on 5/15/16.
//  Copyright © 2016 UCR. All rights reserved.
//

#import "chat.h"

@implementation chat
@synthesize chat_id, user_id, message, sent_on;

- (id)initWithChat: (NSString *)_chat_id user_id: (NSString *)_user_id message: (NSString *)_message sent_on: (NSString *)_sent_on {
	self = [super init];
    if (self){
        chat_id = _chat_id;
        user_id = _user_id;
        message = _message;
        sent_on = _sent_on;
    }
    
    return self;
}
@end
