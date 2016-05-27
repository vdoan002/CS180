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
@synthesize navBar, num_posts_label, category, relevantPostsArray;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupData];
    [self setupUI];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setupData{
    [self getRelevantPostsArray];
}

- (void)setupUI{
    self.view.backgroundColor = [UIColor colorWithRed:0.13 green:0.13 blue:0.13 alpha:1.0];
    num_posts_label.userInteractionEnabled = false;
    if(relevantPostsArray.count == 1){
        num_posts_label.text = @"1 post";
    }
    else{
        num_posts_label.text = [NSString stringWithFormat:@"%lu posts", relevantPostsArray.count];
    }
    num_posts_label.textColor = [UIColor whiteColor];
    num_posts_label.backgroundColor = [UIColor blackColor];
}

- (void) viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    // You code here to update the view.
    [self refreshAll];
}

-(void)refreshAll{
    NSLog(@"Before retrievePosts - relevantPostsArray.count: %lu", relevantPostsArray.count);
    NSLog(@"After retrievePosts - relevantPostsArray.count: %lu", relevantPostsArray.count);
    [self.tableView reloadData];
    if(relevantPostsArray.count == 1){
        num_posts_label.text = @"1 post";
    }
    else{
        num_posts_label.text = [NSString stringWithFormat:@"%lu posts", relevantPostsArray.count];
    }
    
    //sort postsArray http://stackoverflow.com/a/12913805
    NSSortDescriptor * postsName = [NSSortDescriptor
                                    sortDescriptorWithKey:@"post_title"
                                    ascending:YES];
    NSArray *sortDescriptors = [NSArray arrayWithObject:postsName];
    NSArray * sortedArray = [relevantPostsArray sortedArrayUsingDescriptors:sortDescriptors];
    relevantPostsArray = [NSMutableArray arrayWithArray:sortedArray];
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
    NSLog(@"number of rows: %lu", relevantPostsArray.count);
    return relevantPostsArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"postCell" forIndexPath:indexPath];
    
    // Configure the cell...
    
    posts * post;
    post = [relevantPostsArray objectAtIndex:indexPath.row];
    cell.textLabel.text = post.post_title;
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.backgroundColor = [UIColor colorWithRed:0.13 green:0.13 blue:0.13 alpha:1.0];
    cell.textLabel.textColor = [UIColor whiteColor];
    cell.textLabel.highlightedTextColor = [UIColor blackColor];
    
    return cell;
}

- (void)dismissPostsAndShowComposer{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UIViewController * ThirdViewController = [storyboard instantiateViewControllerWithIdentifier:@"ThirdViewController"];
    [self presentViewController:ThirdViewController animated:YES completion:nil];
}

- (void)getCategory:(id)_category{
    category = _category;
}

- (void)getRelevantPostsArray{
    //NSLog(@"category passed over: %@", category);
    if([category isEqualToString:@"Books"]){
        relevantPostsArray = [dbArrays sharedInstance].relevantBooksArray;
    }
    else if([category isEqualToString:@"Clothing"]){
        relevantPostsArray = [dbArrays sharedInstance].relevantClothingArray;
    }
    else if([category isEqualToString:@"Electronics"]){
        relevantPostsArray = [dbArrays sharedInstance].relevantElectronicsArray;
    }
    else if([category isEqualToString:@"Furniture"]){
        relevantPostsArray = [dbArrays sharedInstance].relevantFurnitureArray;
    }
    else if([category isEqualToString:@"Household"]){
        relevantPostsArray = [dbArrays sharedInstance].relevantHouseholdArray;
    }
    else if([category isEqualToString:@"Leases"]){
        relevantPostsArray = [dbArrays sharedInstance].relevantLeasesArray;
    }
    else if([category isEqualToString:@"Music"]){
        relevantPostsArray = [dbArrays sharedInstance].relevantMusicArray;
    }
    else if([category isEqualToString:@"Pets"]){
        relevantPostsArray = [dbArrays sharedInstance].relevantPetsArray;
    }
    else if([category isEqualToString:@"Services"]){
        relevantPostsArray = [dbArrays sharedInstance].relevantServicesArray;
    }
    else if([category isEqualToString:@"Tickets"]){
        relevantPostsArray = [dbArrays sharedInstance].relevantTicketsArray;
    }
    else if([category isEqualToString:@"Vehicles"]){
        relevantPostsArray = [dbArrays sharedInstance].relevantVehiclesArray;
    }
    else if([category isEqualToString:@"Other"]){
        relevantPostsArray = [dbArrays sharedInstance].relevantOtherArray;
    }
}

- (IBAction)newButton:(id)sender {
        [self dismissPostsAndShowComposer];
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
        
        posts * post = [relevantPostsArray objectAtIndex:indexPath.row];
        
        [[segue destinationViewController] getPost:post];
    }
}
                                


@end
