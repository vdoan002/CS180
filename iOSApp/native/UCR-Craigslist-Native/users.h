//
//  users.h
//  UCR-Craigslist-Native
//
//  Created by Michael Chen on 5/14/16.
//  Copyright © 2016 UCR. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface users : NSObject

@property (strong, nonatomic) NSString * userID;
@property (strong, nonatomic) NSString * email;
@property (strong, nonatomic) NSString * username;
@property (strong, nonatomic) NSString * password;
@property (strong, nonatomic) NSString * num_reviews;
@property (strong, nonatomic) NSString * total_rating;

@property (nonatomic) BOOL loggedIn;

#pragma mark -
#pragma mark Class Methods

- (id)initWithUsers: (NSString *)_userID email: (NSString *)_email username: (NSString *)_username password: (NSString *)_password num_reviews: (NSString *)_num_reviews total_rating: (NSString *)_total_rating loggedIn: (BOOL)_loggedIn;

@end
