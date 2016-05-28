//
//  ThirdViewController.h
//  UCR-Craigslist-Native
//
//  Created by Michael Chen on 5/20/16.
//  Copyright © 2016 UCR. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "loginPage.h"

@interface ThirdViewController : UITableViewController<UITabBarDelegate>

@property (strong, nonatomic) IBOutlet UITextField *num_threads_label;
@property (strong, nonatomic) IBOutlet UINavigationItem *navBar;
@property(nonatomic, strong) loginPage * loginPageObj;
@property(nonatomic, strong) NSMutableArray * friends;

- (void)getRelevantThreads;
- (void)refreshAll;

- (IBAction)newButton:(id)sender;

@end
