//
//  FirstViewController.m
//  UCR-Craigslist-Native
//
//  Created by Michael Chen on 5/15/16.
//  Copyright © 2016 UCR. All rights reserved.
//

#import "PostsTableViewController.h"
#import "loginPage.h"
#import "posts.h"
#import "dbArrays.h"
#import "postCellDetail.h"

@interface PostsTableViewController ()

@end

@implementation PostsTableViewController
@synthesize navBar, num_posts_label, category, relevantPostsArray, searchResults, searchController;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupData];
    [self setupUI];
    
    //self.tableView.contentInset = UIEdgeInsetsMake(HeightOfTableViewCells, 0, 0, 0);

    NSLog(@"searchController.searchBar.frame.size.height: %f", searchController.searchBar.frame.size.height);
    searchController.loadViewIfNeeded;
    

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)updateSearchResultsForSearchController: (UISearchController *)_searchController{
    [self searchForText:_searchController.searchBar.text];
}

// based on: https://www.raywenderlich.com/113772/uisearchcontroller-tutorial
- (void)setupSearchBar{
    searchController = [[UISearchController alloc] initWithSearchResultsController:nil];
    searchController.searchResultsUpdater = self;
    searchController.dimsBackgroundDuringPresentation = false;
    searchController.definesPresentationContext = YES;
    //searchController.hidesNavigationBarDuringPresentation = false;
    self.tableView.tableHeaderView = searchController.searchBar;
    
    UITextField * searchField = [searchController.searchBar valueForKey:@"_searchField"];
    [searchField setContentVerticalAlignment:UIControlContentVerticalAlignmentBottom];
    
    
    
    //[searchController.searchBar setBackgroundColor:[UIColor colorWithRed:0.13 green:0.13 blue:0.13 alpha:1.0]];
    //[searchController.searchBar setPlaceholder:@"search for a keyword"];
}

- (void)searchForText: (NSString *)searchText{
    searchResults = [[NSMutableArray alloc] init];
    for(int i = 0; i < relevantPostsArray.count; i++){
        posts * post = [relevantPostsArray objectAtIndex:i];
        if([[post.post_title lowercaseString] containsString:[searchText lowercaseString]] || [[post.description lowercaseString] containsString:[searchText lowercaseString]]){
            [searchResults addObject:post];
        }
    }
    
    [self.tableView reloadData];
}

- (void)setupData{
    [self getRelevantPostsArray];
}

- (void)updateNumPostsLabel: (NSMutableArray *)_array{
    if(_array.count == 1){
        num_posts_label.text = @"       1 post";
    }
    else{
        num_posts_label.text = [NSString stringWithFormat:@"       %lu posts", _array.count];
    }
}

- (void)setupUI{
    self.extendedLayoutIncludesOpaqueBars = YES;
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.view.backgroundColor = [UIColor colorWithRed:0.13 green:0.13 blue:0.13 alpha:1.0];
    navBar.title = category;
    num_posts_label.userInteractionEnabled = false;
    num_posts_label.textColor = [UIColor whiteColor];
    num_posts_label.backgroundColor = [UIColor blackColor];
    
    UIView * viewBackground = [[UIView alloc] init];
    viewBackground.backgroundColor = [UIColor colorWithRed:0.13 green:0.13 blue:0.13 alpha:1.0];
    [self.tableView setBackgroundView:viewBackground];

    [self setupSearchBar];
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
    //NSLog(@"number of rows: %lu", relevantPostsArray.count);
    if(searchController.active){
        self.tableView.contentInset = UIEdgeInsetsMake(searchController.searchBar.frame.size.height - 24, 0, 0, 0);
        [self updateNumPostsLabel:searchResults];
    }
    else if(!searchController.active){
        self.tableView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
        [self updateNumPostsLabel:relevantPostsArray];
    }
    
    if([searchController.searchBar.text isEqualToString:@""]){
        [self updateNumPostsLabel:relevantPostsArray];
    }
    
    if(searchController.active && ![searchController.searchBar.text isEqualToString:@""]){
        return searchResults.count;
    }
    else{
        return relevantPostsArray.count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"postCell" forIndexPath:indexPath];
    
    // Configure the cell...
    
    posts * post = [[posts alloc] init];
    
    if(searchController.active && ![searchController.searchBar.text isEqualToString:@""]) {
        post = searchResults[indexPath.row];
    }
    else{
        post = [relevantPostsArray objectAtIndex:indexPath.row];
    }
    
    cell.textLabel.text = post.post_title;
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.backgroundColor = [UIColor colorWithRed:0.13 green:0.13 blue:0.13 alpha:1.0];
    cell.textLabel.textColor = [UIColor whiteColor];
    cell.textLabel.highlightedTextColor = [UIColor blackColor];
    
    return cell;
}

- (void)dismissPostsAndShowComposer{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UIViewController * CreatePostViewController = [storyboard instantiateViewControllerWithIdentifier:@"CreatePostViewController"];
    [self presentViewController:CreatePostViewController animated:YES completion:nil];
}

- (void)getCategory:(id)_category{
    category = _category;
}

- (void)getRelevantPostsArray{
    //NSLog(@"category passed over: %@", category);
    if([category isEqualToString:@"All"]){
        relevantPostsArray = [dbArrays sharedInstance].postsArray;
    }
    else if([category isEqualToString:@"Books"]){
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
        
        if(![dbArrays sharedInstance].imagesLoaded){
            loginPage * loginPageObj = [[loginPage alloc] init];
            [loginPageObj retrieveImages];
        }
        
        NSIndexPath * indexPath = [self.tableView indexPathForSelectedRow];
        posts * post = [[posts alloc] init];
       
        if(searchController.active && ![searchController.searchBar.text isEqualToString:@""]){
            post = searchResults[indexPath.row];
            [searchController setActive:NO];
        }
        else{
            post = relevantPostsArray[indexPath.row];
        }
        
        if(searchController.active){
            [searchController setActive:NO];
        }
 
        [[segue destinationViewController] getPost:post];
    }
}

- (void)dealloc{
    searchController.loadViewIfNeeded;
}

@end
