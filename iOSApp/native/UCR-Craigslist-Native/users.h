//
//  users.h
//  UCR-Craigslist-Native
//
//  Created by Michael Chen on 5/14/16.
//  Copyright © 2016 UCR. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface users : NSObject

-(void)loginWithUsername:(NSString *)username andPassword:(NSString *)password;
-(void)logout;
-(BOOL)validUser;

@property (strong, nonatomic) NSString * userID;
@property (strong, nonatomic) NSString * email;
@property (strong, nonatomic) NSString * username;
@property (strong, nonatomic) NSString * password;
@property (strong, nonatomic) NSString * num_reviews;
@property (strong, nonatomic) NSString * total_rating;

#pragma mark -
#pragma mark Class Methods

- (id)initWithUsers: (NSString *)userID email: (NSString *)email username: (NSString *)username password: (NSString *)password num_reviews: (NSString *)num_reviews total_rating: (NSString *)total_rating;

@end
