//
//  postCellDetail.m
//  UCR-Craigslist-Native
//
//  Created by Michael Chen on 5/15/16.
//  Copyright © 2016 UCR. All rights reserved.
//

#import "postCellDetail.h"
#import "posts.h"

@interface postCellDetail ()

@end

@implementation postCellDetail
@synthesize post_id_label, post_title_label, post_username_label, post_price_label, post_category_label, post_description_label, post_date_label, post_time_label, post_photos_label, post_photo_id_label, post, navBarItem;


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setLabels];
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

-(void)setLabels{
    navBarItem.title = post.post_title;
    
    post_id_label.text = post.post_id;
    post_username_label.text = [NSString stringWithFormat:@"Seller: %@", post.post_username];
    post_price_label.text = [NSString stringWithFormat:@"Price: %@", post.post_price];
    post_category_label.text = [NSString stringWithFormat:@"Category: %@", post.post_category];
    post_description_label.text = [NSString stringWithFormat:@"Description: %@", post.post_description];
    post_date_label.text = post.post_date;
    post_time_label.text = post.post_time;
    post_photos_label.text = post.post_photos;
    post_photo_id_label.text = post.post_photo_id;
}
    
@end
