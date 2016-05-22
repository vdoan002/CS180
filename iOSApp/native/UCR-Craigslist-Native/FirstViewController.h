//
//  FirstViewController.h
//  UCR-Craigslist-Native
//
//  Created by Michael Chen on 5/15/16.
//  Copyright © 2016 UCR. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "loginPage.h"

@interface FirstViewController : UITableViewController
@property (strong, nonatomic) IBOutlet UITableView *navBar;
@property (strong, nonatomic) IBOutlet UITextField *num_posts_label;
@property (strong, nonatomic) loginPage * loginPageObj;
- (IBAction)refreshButton:(id)sender;
-(void)refreshAll;

@end
