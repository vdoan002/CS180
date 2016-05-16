//
//  reviews.m
//  UCR-Craigslist-Native
//
//  Created by Michael Chen on 5/15/16.
//  Copyright © 2016 UCR. All rights reserved.
//

#import "reviews.h"

@implementation reviews
@synthesize review_id, user_id, review, reviewer, rating;

- (id)initWithReviews: (NSString *)_review_id user_id: (NSString *)_user_id review: (NSString *)_review reviewer: (NSString *)_reviewer rating: (NSString *)_rating{
    
    self = [super init];
    if (self){
        review_id = _review_id;
        user_id = _user_id;
        review = _review;
        reviewer = _reviewer;
        rating = _rating;
    }
    
    return self;
}

@end
