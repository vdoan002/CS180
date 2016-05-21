//
//  FourthViewController.h
//  UCR-Craigslist-Native
//
//  Created by Michael Chen on 5/20/16.
//  Copyright © 2016 UCR. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FourthViewController : UITableViewController
@property (strong, nonatomic) IBOutlet UITextField *num_threads_label;
@property (strong, nonatomic) IBOutlet UINavigationItem *navBar;
- (NSMutableArray*)findRelevantThreads;
@end
