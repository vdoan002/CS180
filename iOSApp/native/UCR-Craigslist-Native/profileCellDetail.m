//
//  profileCellDetail.m
//  UCR-Craigslist-Native
//
//  Created by Michael Chen on 5/17/16.
//  Copyright © 2016 UCR. All rights reserved.
//

#import "profileCellDetail.h"
#import "reviews.h"
#import "dbArrays.h"

@interface profileCellDetail ()

@end

@implementation profileCellDetail
@synthesize review, review_label, rating_label, navBarItem, loginPageObj;
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor colorWithRed:0.13 green:0.13 blue:0.13 alpha:1.0];
    [self setLabels];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)getReview:(id)_review{
    review = _review;
}

-(void)setLabels{
    navBarItem.title = [NSString stringWithFormat:@"Review by %@", review.reviewer];
    
    rating_label.text = [NSString stringWithFormat:@"rating: %@/5", review.rating];
    review_label.text = review.review;
}



@end
