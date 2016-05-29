//
//  postCellDetail.h
//  UCR-Craigslist-Native
//
//  Created by Michael Chen on 5/15/16.
//  Copyright © 2016 UCR. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "posts.h"
#import "images.h"

@interface postCellDetail : UIViewController

@property (nonatomic, strong) IBOutlet UINavigationItem *navBarItem;
@property (nonatomic, strong) IBOutlet UIImageView *image1;
@property (nonatomic, strong) IBOutlet UIImageView *image2;
@property (nonatomic, strong) IBOutlet UIImageView *image3;
@property (nonatomic, strong) IBOutlet UIImageView *image4;
@property (nonatomic, strong) IBOutlet UILabel * post_id_label;
@property (nonatomic, strong) IBOutlet UILabel * post_title_label;
@property (nonatomic, strong) IBOutlet UILabel * post_username_label;
@property (nonatomic, strong) IBOutlet UILabel * post_price_label;
@property (nonatomic, strong) IBOutlet UILabel * post_category_label;
@property (nonatomic, strong) IBOutlet UILabel * post_description_label;
@property (nonatomic, strong) IBOutlet UILabel * post_date_label;
@property (nonatomic, strong) IBOutlet UILabel * post_time_label;
@property (nonatomic, strong) IBOutlet UILabel * post_photos_label;
@property (nonatomic, strong) IBOutlet UILabel * post_photo_id_label;

@property (nonatomic, copy) NSArray * animationImages;

@property (nonatomic, strong) posts * post;
@property (nonatomic, strong) images * image;

#pragma mark -
#pragma mark Methods

-(void)getPost:(id)_post;
-(void)getImages:(id)_image;
-(void)setupUI;
-(void)displayImages;

@end
