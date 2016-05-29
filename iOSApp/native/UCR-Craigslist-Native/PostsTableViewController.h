//
//  PostsTableViewController.h
//  UCR-Craigslist-Native
//
//  Created by Michael Chen on 5/15/16.
//  Copyright © 2016 UCR. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "loginPage.h"

@interface PostsTableViewController : UITableViewController
@property (strong, nonatomic) IBOutlet UITextField *num_posts_label;
@property (strong, nonatomic) NSString * category;
@property (strong, nonatomic) NSMutableArray * relevantPostsArray;
@property (strong, nonatomic) NSMutableArray * searchResults;
@property (strong, nonatomic) IBOutlet UINavigationItem *navBar;
@property (strong, nonatomic) UISearchController * searchController;

- (void)getCategory:(id)_category;
- (void)getRelevantPostsArray;

- (IBAction)newButton:(id)sender;

@end
