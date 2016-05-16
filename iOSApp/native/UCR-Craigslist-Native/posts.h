//
//  posts.h
//  UCR-Craigslist-Native
//
//  Created by Michael Chen on 5/15/16.
//  Copyright © 2016 UCR. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface posts : NSObject

@property (strong, nonatomic) NSString * post_id;
@property (strong, nonatomic) NSString * post_title;
@property (strong, nonatomic) NSString * post_username;
@property (strong, nonatomic) NSString * post_price;
@property (strong, nonatomic) NSString * post_category;
@property (strong, nonatomic) NSString * post_description;
@property (strong, nonatomic) NSString * post_date;
@property (strong, nonatomic) NSString * post_time;
@property (strong, nonatomic) NSString * post_photos;
@property (strong, nonatomic) NSString * post_photo_id;

#pragma mark -
#pragma mark Class Methods

- (id)initWithPosts: (NSString *)pID post_title: (NSString *)pTitle post_username: (NSString *)pUsername post_price: (NSString *)pPrice post_category: (NSString *)pCategory post_description: (NSString *)pDescription post_date: (NSString *)pDate post_time: (NSString *)pTime post_photos: (NSString *)pPhotos post_photo_id: (NSString *)pPhotoID;

@end
