//
//  FirstViewController.m
//  UCR-Craigslist-Native
//
//  Created by Michael Chen on 5/15/16.
//  Copyright © 2016 UCR. All rights reserved.
//

#import "FirstViewController.h"
#import "loginPage.h"
#import "posts.h"
#import "dbArrays.h"
#import "postCellDetail.h"

@interface FirstViewController ()

@end

@implementation FirstViewController
@synthesize navBar, num_posts_label, loginPageObj;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    
    self.view.backgroundColor = [UIColor colorWithRed:0.13 green:0.13 blue:0.13 alpha:1.0];
    
    loginPageObj = [[loginPage alloc] init];
    [loginPageObj retrieveMessages];
    
    NSLog(@"FirstViewController: users: %@", [dbArrays sharedInstance].usersArray);
    
    num_posts_label.userInteractionEnabled = false;
    if([dbArrays sharedInstance].postsArray.count == 1){
        num_posts_label.text = @"1 post";
    }
    else{
        num_posts_label.text = [NSString stringWithFormat:@"%lu posts", [dbArrays sharedInstance].postsArray.count];
    }
    num_posts_label.textColor = [UIColor whiteColor];
    num_posts_label.backgroundColor = [UIColor blackColor];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    // You code here to update the view.
    [self refreshAll];
}

-(void)refreshAll{
    NSLog(@"Before retrievePosts - postsArray.count: %lu", [dbArrays sharedInstance].postsArray.count);
    [loginPageObj retrievePosts];
    NSLog(@"After retrievePosts - postsArray.count: %lu", [dbArrays sharedInstance].postsArray.count);
    [self.tableView reloadData];
    if([dbArrays sharedInstance].postsArray.count == 1){
        num_posts_label.text = @"1 post";
    }
    else{
        num_posts_label.text = [NSString stringWithFormat:@"%lu posts", [dbArrays sharedInstance].postsArray.count];
    }
}

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}



#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [dbArrays sharedInstance].postsArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"postCell" forIndexPath:indexPath];
    
    // Configure the cell...
    
    posts * post;
    post = [[dbArrays sharedInstance].postsArray objectAtIndex:indexPath.row];
    cell.textLabel.text = post.post_title;
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.backgroundColor = [UIColor colorWithRed:0.13 green:0.13 blue:0.13 alpha:1.0];
    cell.textLabel.textColor = [UIColor whiteColor];
    cell.textLabel.highlightedTextColor = [UIColor blackColor];
    return cell;
}

- (IBAction)refreshButton:(id)sender {
    NSLog(@"refreshButton pressed!");
    [loginPageObj retrieveImages];
    [self refreshAll];
}
/*-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    //I have a static list of section titles in SECTION_ARRAY for reference.
    //Obviously your own section title code handles things differently to me.
    //return [SECTION_ARRAY objectAtIndex:section];
    return @"Posts";
}*/

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    
    if([[segue identifier] isEqualToString:@"postCellSegue"]){
        NSIndexPath * indexPath = [self.tableView indexPathForSelectedRow];
        
        //get obj for selected row
        posts * post = [[dbArrays sharedInstance].postsArray objectAtIndex:indexPath.row];
        
        [[segue destinationViewController] getPost:post];
    }
}
                                


@end
