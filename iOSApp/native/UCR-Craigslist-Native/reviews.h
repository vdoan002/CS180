//
//  reviews.h
//  UCR-Craigslist-Native
//
//  Created by Michael Chen on 5/15/16.
//  Copyright © 2016 UCR. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface reviews : NSObject

@property (strong, nonatomic) NSString * review_id;
@property (strong, nonatomic) NSString * user_id;
@property (strong, nonatomic) NSString * review;
@property (strong, nonatomic) NSString * reviewer;
@property (strong, nonatomic) NSString * rating;

#pragma mark -
#pragma mark Class Methods

- (id)initWithReviews: (NSString *)_review_id user_id: (NSString *)_user_id review: (NSString *)_review reviewer: (NSString *)reviewer rating: (NSString *)_rating;

@end
