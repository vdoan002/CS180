//
//  profileCellDetail.h
//  UCR-Craigslist-Native
//
//  Created by Michael Chen on 5/17/16.
//  Copyright © 2016 UCR. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "reviews.h"
#import "loginPage.h"

@interface profileCellDetail : UIViewController

@property(nonatomic, strong) IBOutlet UILabel * reviewer_label;
@property(nonatomic, strong) IBOutlet UILabel * rating_label;
@property(nonatomic, strong) IBOutlet UILabel * review_label;

@property(nonatomic, strong) reviews * review;
@property(nonatomic, strong) loginPage * loginPageObj;
@property (strong, nonatomic) IBOutlet UINavigationItem *navBarItem;

#pragma mark -
#pragma mark Methods

-(void)getReview:(id)_review;
-(void)setLabels;

@end
