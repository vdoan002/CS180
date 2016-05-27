//
//  FifthViewController.h
//  UCR-Craigslist-Native
//
//  Created by Michael Chen on 5/17/16.
//  Copyright © 2016 UCR. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FifthViewController : UITableViewController
@property (strong, nonatomic) IBOutlet UINavigationItem *navBar;
@property (strong, nonatomic) IBOutlet UITextField *num_reviews_label;

@property (strong, nonatomic) NSMutableArray * relevantReviewsArray;

- (void)getRelevantReviews;

- (IBAction)logoutButton:(id)sender;
@end
