//
//  images.m
//  UCR-Craigslist-Native
//
//  Created by Michael Chen on 5/15/16.
//  Copyright © 2016 UCR. All rights reserved.
//

#import "images.h"

@implementation images
@synthesize image_id, image_post_id, image_name, image_pic;

- (id)initWithImages: (NSString *)_image_id image_post_id: (NSString *)_image_post_id image_name: (NSString *)_image_name image_pic: (NSString *)_image_pic {
    
    self = [super init];
    if (self){
        image_id = _image_id;
        image_post_id = _image_post_id;
        image_name = _image_name;
        image_pic = _image_pic;
    }
    
    return self;
}

@end
