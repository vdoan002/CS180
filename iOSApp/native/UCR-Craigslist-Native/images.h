//
//  images.h
//  UCR-Craigslist-Native
//
//  Created by Michael Chen on 5/15/16.
//  Copyright © 2016 UCR. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface images : NSObject

@property (strong, nonatomic) NSString * image_id;
@property (strong, nonatomic) NSString * image_post_id;
@property (strong, nonatomic) NSString * image_name;
@property (strong, nonatomic) NSString * image_pic;

#pragma mark -
#pragma mark Class Methods

- (id)initWithImages: (NSString *)_image_id image_post_id: (NSString *)_image_post_id image_name: (NSString *)_image_name image_pic: (NSString *)_image_pic;

@end
