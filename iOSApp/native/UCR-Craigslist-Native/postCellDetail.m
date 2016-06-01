//
//  postCellDetail.m
//  UCR-Craigslist-Native
//
//  Created by Michael Chen on 5/15/16.
//  Copyright © 2016 UCR. All rights reserved.
//

#import "postCellDetail.h"
#import "posts.h"
#import "images.h"
#import "dbArrays.h"

@interface postCellDetail ()

@end

@implementation postCellDetail
@synthesize post_id_label, post_title_label, post_username_label, post_price_label, post_category_label, post_description_label, post_date_label, post_time_label, post_photos_label, post_photo_id_label, post, navBarItem,
    image, image1, image2, image3, image4, animationImages;


- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupUI];
    [self displayImages];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -
#pragma mark methods

-(void)getPost:(id)_post{
    post = _post;
}

-(void)getImages:(id)_image{
    image = _image;
}

-(void)displayImages{
    image1.contentMode = UIViewContentModeScaleAspectFit;
    image2.contentMode = UIViewContentModeScaleAspectFit;
    image3.contentMode = UIViewContentModeScaleAspectFit;
    image4.contentMode = UIViewContentModeScaleAspectFit;
    
    images * imageObj;
    BOOL image1Set = false, image2Set = false, image3Set = false, image4Set = false;
    
    for(int i = 0; i < [dbArrays sharedInstance].imagesArray.count; i++){
        
        imageObj = [[dbArrays sharedInstance].imagesArray objectAtIndex: i];
        
        if(imageObj.image_post_id == post.post_id && !image1Set){
            image1.image = [UIImage imageWithData:imageObj.image_data];
            image1Set = true;
        }
        else if(imageObj.image_post_id == post.post_id && !image2Set){
            image2.image = [UIImage imageWithData:imageObj.image_data];
            image2Set = true;
        }
        else if(imageObj.image_post_id == post.post_id && !image3Set){
            image3.image = [UIImage imageWithData:imageObj.image_data];
            image3Set = true;
        }
        else if(imageObj.image_post_id == post.post_id && !image4Set){
            image4.image = [UIImage imageWithData:imageObj.image_data];
            image4Set = true;
        }
    }
    
    [self setTextFrames:image1Set and:image2Set and:image3Set and:image4Set];
}

- (void)setTextFrames: (BOOL)image1Set and: (BOOL)image2Set and: (BOOL)image3Set and: (BOOL)image4Set{
    if((!image1Set && !image2Set && !image3Set && !image4Set) || ((image1Set || image2Set) && !image3Set && !image4Set)){
        NSLog(@"NO IMAGES OR ONLY FIRST ROW OF IMAGES");
        NSLog(@"x: %f / y: %f", post_username_label.frame.origin.x, post_username_label.frame.origin.y);
        CGRect post_username_frame = post_username_label.frame;
        post_username_frame.origin.x = 20;
        post_username_frame.origin.y = 235;
        post_username_label.frame = post_username_frame;
        post_username_label.frame = CGRectMake(20, 235, post_username_label.frame.size.width, post_username_label.frame.size.height);
        post_date_label.frame = CGRectMake(20, 270, post_date_label.frame.size.width, post_date_label.frame.size.height);
        post_price_label.frame = CGRectMake(20, 305, post_price_label.frame.size.width, post_price_label.frame.size.height);
        post_description_label.frame = CGRectMake(20, 340, post_description_label.frame.size.width, post_description_label.frame.size.height);
    }
    else if(image1Set && image2Set && (image3Set || image4Set)){
        NSLog(@"ALL ROWS OF IMAGES PRESENT");
        NSLog(@"x: %f / y: %f", post_username_label.frame.origin.x, post_username_label.frame.origin.y);
        post_username_label.frame = CGRectMake(20, 407, post_username_label.frame.size.width, post_username_label.frame.size.height);
        post_date_label.frame = CGRectMake(20, 442, post_date_label.frame.size.width, post_date_label.frame.size.height);
        post_price_label.frame = CGRectMake(20, 477, post_price_label.frame.size.width, post_price_label.frame.size.height);
        post_description_label.frame = CGRectMake(20, 512, post_description_label.frame.size.width, post_description_label.frame.size.height);
    }
}

-(void)setupUI{
    self.view.backgroundColor = [UIColor colorWithRed:0.13 green:0.13 blue:0.13 alpha:1.0];
    navBarItem.title = post.post_title;
    
    //post_id_label.text = post.post_id;
    post_username_label.text = [NSString stringWithFormat:@"%@", post.post_username];
    post_price_label.text = [NSString stringWithFormat:@"$ %@", post.post_price];
    //post_category_label.text = [NSString stringWithFormat:@"Category: %@", post.post_category];
    post_description_label.text = [NSString stringWithFormat:@"%@", post.post_description];
    post_date_label.text = [NSString stringWithFormat:@"%@ @ %@", post.post_date, post.post_time];
    //post_photos_label.text = post.post_photos;
    //post_photo_id_label.text = post.post_photo_id;
    
    post_id_label.textColor = [UIColor whiteColor];
    post_username_label.textColor = [UIColor whiteColor];
    post_price_label.textColor = [UIColor whiteColor];
    post_category_label.textColor = [UIColor whiteColor];
    post_description_label.textColor = [UIColor whiteColor];
    post_date_label.textColor = [UIColor whiteColor];
    post_photos_label.textColor = [UIColor whiteColor];
    post_photo_id_label.textColor = [UIColor whiteColor];;
}
    
@end
