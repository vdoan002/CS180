//
//  messages.h
//  UCR-Craigslist-Native
//
//  Created by Michael Chen on 5/20/16.
//  Copyright © 2016 UCR. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface messages : NSObject

@property (strong, nonatomic) NSString * message_id;
@property (strong, nonatomic) NSString * message_sender;
@property (strong, nonatomic) NSString * message_receiver;
@property (strong, nonatomic) NSString * message_content;
@property (strong, nonatomic) NSString * message_timesent;
@property (strong, nonatomic) NSString * message_date;
@property (strong, nonatomic) NSString * message_seen;
@property (nonatomic) BOOL message_threadLoaded;

#pragma mark -
#pragma mark Class Methods

- (id)initWithMessages: (NSString *)_message_id message_sender: (NSString *)_message_sender message_receiver: (NSString *)_message_receiver message_content: (NSString *)_message_content message_timesent: (NSString *)_message_timesent message_date: (NSString *)_message_date message_seen: (NSString *)_message_seen message_threadLoaded: (BOOL)_message_threadLoaded;

@end
