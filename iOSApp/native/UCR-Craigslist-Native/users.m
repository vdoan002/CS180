//
//  users.m
//  UCR-Craigslist-Native
//
//  Created by Michael Chen on 5/14/16.
//  Copyright © 2016 UCR. All rights reserved.
//

#import "users.h"

@implementation users
@synthesize userID, email, username, password, num_reviews, total_rating, loggedIn;

- (id)initWithUsers: (NSString *)_userID email: (NSString *)_email username: (NSString *)_username password: (NSString *)_password num_reviews: (NSString *)_num_reviews total_rating: (NSString *)_total_rating loggedIn: (BOOL)_loggedIn{
    
    self = [super init];
    if (self){
        userID = _userID;
        email = _email;
        username = _username;
        password = _password;
        num_reviews = _num_reviews;
        total_rating = _total_rating;
        loggedIn = false;
    }
    
    return self;
}

@end
