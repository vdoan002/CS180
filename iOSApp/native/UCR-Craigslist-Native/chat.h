//
//  chat.h
//  UCR-Craigslist-Native
//
//  Created by Michael Chen on 5/15/16.
//  Copyright © 2016 UCR. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface chat : NSObject

@property (strong, nonatomic) NSString * chat_id;
@property (strong, nonatomic) NSString * user_id;
@property (strong, nonatomic) NSString * message;
@property (strong, nonatomic) NSString * sent_on;

#pragma mark -
#pragma mark Class Methods

- (id)initWithChat: (NSString *)_chat_id user_id: (NSString *)_user_id message: (NSString *)_message sent_on: (NSString *)_sent_on;

@end
