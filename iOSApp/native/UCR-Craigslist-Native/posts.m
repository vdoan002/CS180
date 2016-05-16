//
//  posts.m
//  UCR-Craigslist-Native
//
//  Created by Michael Chen on 5/15/16.
//  Copyright © 2016 UCR. All rights reserved.
//

#import "posts.h"

@implementation posts
@synthesize post_id, post_title, post_username, post_price, post_category, post_description, post_date, post_time, post_photos, post_photo_id;

- (id)initWithPosts: (NSString *)pID post_title: (NSString *)pTitle post_username: (NSString *)pUsername post_price: (NSString *)pPrice post_category: (NSString *)pCategory post_description: (NSString *)pDescription post_date: (NSString *)pDate post_time: (NSString *)pTime post_photos: (NSString *)pPhotos post_photo_id: (NSString *)pPhotoID{
    
    self = [super init];
    if (self){
        post_id = pID;
        post_title = pTitle;
        post_username = pUsername;
        post_price = pPrice;
        post_category = pCategory;
        post_description = pDescription;
        post_date = pDate;
        post_time = pTime;
        post_photos = pPhotos;
        post_photo_id = pPhotoID;
    }
    
    return self;
}
@end
