//
//  users.m
//  UCR-Craigslist-Native
//
//  Created by Michael Chen on 5/14/16.
//  Copyright © 2016 UCR. All rights reserved.
//

#import "users.h"

@implementation users
@synthesize userID, email, username, password, num_reviews, total_rating;

- (id)initWithUsers: (NSString *)_userID email: (NSString *)_email username: (NSString *)_username password: (NSString *)_password num_reviews: (NSString *)_num_reviews total_rating: (NSString *)_total_rating{
    
    self = [super init];
    if (self){
        userID = _userID;
        email = _email;
        username = _username;
        password = _password;
        num_reviews = _num_reviews;
        total_rating = _total_rating;
    }
    
    return self;
}

//given code
- (void)loginWithUsername:(NSString *)username andPassword:(NSString *)password{
    
    // Validate user here with your implementation
    // and notify the root controller
    [[NSNotificationCenter defaultCenter] postNotificationName:@"loginActionFinished" object:self userInfo:nil];
}


- (BOOL)validUser {
    
    // This variable is only for testing
    // Here you have to implement a mechanism
    BOOL auth = YES;
    
    if (auth) {
        return YES;
    }
    
    return NO;
}
//end given code
@end
