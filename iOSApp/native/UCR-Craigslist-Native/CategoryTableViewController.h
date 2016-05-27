//
//  CategoryTableViewController.h
//  UCR-Craigslist-Native
//
//  Created by Michael Chen on 5/26/16.
//  Copyright © 2016 UCR. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CategoryTableViewController : UITableViewController

@property (strong, nonatomic) IBOutlet UITextField *num_categories_label;
@property (strong, nonatomic) NSArray * categories;

- (IBAction)newButton:(id)sender;
- (IBAction)refreshButton:(id)sender;

@end
