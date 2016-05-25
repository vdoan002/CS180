//
//  FourthViewController.h
//  UCR-Craigslist-Native
//
//  Created by Michael Chen on 5/20/16.
//  Copyright © 2016 UCR. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "loginPage.h"

@interface FourthViewController : UITableViewController<UITabBarDelegate>
@property (strong, nonatomic) IBOutlet UITextField *num_threads_label;
@property (strong, nonatomic) IBOutlet UINavigationItem *navBar;
@property (strong, nonatomic) NSMutableArray * relevantThreadsArray;
@property(nonatomic, strong) loginPage * loginPageObj;
@property(nonatomic, strong) NSString * currentLoggedInUserName;
- (IBAction)newButton:(id)sender;
- (void)findRelevantThreads;
-(void)refreshAll;
@end
