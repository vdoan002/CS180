//
//  FourthViewController.m
//  UCR-Craigslist-Native
//
//  Created by Michael Chen on 5/17/16.
//  Copyright © 2016 UCR. All rights reserved.
//

#import "FourthViewController.h"
#import "loginPage.h"
#import "reviews.h"
#import "dbArrays.h"
#import "users.h"
#import "profileCellDetail.h"

@interface FourthViewController ()

@end

@implementation FourthViewController
@synthesize navBar, num_reviews_label, relevantReviewsArray;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;

    [self setupData];
    [self setupUI];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setupUI{
    self.view.backgroundColor = [UIColor colorWithRed:0.13 green:0.13 blue:0.13 alpha:1.0];
    num_reviews_label.userInteractionEnabled = false;
    //set rating to 0 if null
    float currentLoggedInUserRatingFloat = [[dbArrays sharedInstance].user.total_rating floatValue] / [[dbArrays sharedInstance].user.num_reviews floatValue];
    if(isnan(currentLoggedInUserRatingFloat)){
        navBar.title = [NSString stringWithFormat:@"%@", [dbArrays sharedInstance].user.username];
    }
    else if(currentLoggedInUserRatingFloat == (int)currentLoggedInUserRatingFloat){
        navBar.title = [NSString stringWithFormat:@"%@: %d/5", [dbArrays sharedInstance].user.username, (int)currentLoggedInUserRatingFloat];
    }
    else{
        navBar.title = [NSString stringWithFormat:@"%@: %.1f/5", [dbArrays sharedInstance].user.username, currentLoggedInUserRatingFloat];
    }
    
    //set num of ratings label here
    NSLog(@"user.num_reviews: %@", [dbArrays sharedInstance].user.num_reviews);
    if([[dbArrays sharedInstance].user.num_reviews isEqualToString:@"0"]){
        num_reviews_label.text = [NSString stringWithFormat:@"No reviews yet"];
    }
    else{
        num_reviews_label.text = [NSString stringWithFormat:@"%@ reviews", [dbArrays sharedInstance].user.num_reviews];
    }
    num_reviews_label.textColor = [UIColor whiteColor];
    num_reviews_label.backgroundColor = [UIColor blackColor];
}

- (void)setupData{
    loginPage * loginPageObj = [[loginPage alloc] init];
    [loginPageObj retrieveReviews];
    [self getRelevantReviews];
}

- (void) viewWillAppear:(BOOL)animated {
    [self refreshAll];
}

- (void)refreshAll{
    [self setupData];
    [self.tableView reloadData];
}

- (void)dismissProfileAndShowLogin{
    [self dismissViewControllerAnimated:YES completion:^{
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        UITabBarController *loginPage = [storyboard instantiateViewControllerWithIdentifier:@"loginPage"];
        [self presentViewController:loginPage animated:YES completion:nil];
    }];
}

- (void)presentLogoutPopup:(NSString *)titleText message: (NSString *)message{
    //courtesy popup
    UIAlertController *alert = [UIAlertController
                                alertControllerWithTitle:titleText
                                message:message
                                preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction * cancel = [UIAlertAction
                                   actionWithTitle:@"Cancel"
                                   style:UIAlertActionStyleCancel
                                   handler:^(UIAlertAction *action) {}];
    
    //button creation and function (handler)
    UIAlertAction * logout = [UIAlertAction
                               actionWithTitle:@"Logout"
                               style:UIAlertActionStyleDefault
                               handler:^(UIAlertAction * action) {
                                   [dbArrays sharedInstance].usersLoaded = false;
                                   NSLog(@"[dbArrays sharedInstance].usersLoaded: %d", [dbArrays sharedInstance].usersLoaded);
                                   [self dismissViewControllerAnimated:YES completion:nil];
                               }];
    
    [alert addAction:logout];
    [alert addAction:cancel];
    
    [self presentViewController:alert animated:YES completion:nil];
}

- (IBAction)logoutButton:(id)sender {
    [self presentLogoutPopup:@"Logout" message:@"Are you sure you want to logout?"];
}

- (void)getRelevantReviews{
    reviews * reviewObj;
    relevantReviewsArray = [NSMutableArray new];

    for(int i = 0; i < [dbArrays sharedInstance].reviewsArray.count; i++){
        reviewObj = [[dbArrays sharedInstance].reviewsArray objectAtIndex:i];
        //NSLog(@"reviewObj.user_id: %@", reviewObj.user_id);
        
        if([reviewObj.user_id isEqualToString:[dbArrays sharedInstance].user.userID]){
            //NSLog(@"reivewObj ADDED!!!!!!!!!!!!!!!!!");
            [relevantReviewsArray addObject:reviewObj];
        }
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
    //NSLog(@"relevantReviewsArray.count: %lu", (unsigned long)[self findRelevantReviews].count);
    return relevantReviewsArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"profileCell" forIndexPath:indexPath];
    
    reviews * review;
    review = [relevantReviewsArray objectAtIndex:indexPath.row];
    cell.textLabel.text = [NSString stringWithFormat:@"Review by %@", review.reviewer];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.backgroundColor = [UIColor colorWithRed:0.13 green:0.13 blue:0.13 alpha:1.0];
    cell.textLabel.textColor = [UIColor whiteColor];
    cell.textLabel.highlightedTextColor = [UIColor blackColor];
    return cell;
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    
    if([[segue identifier] isEqualToString:@"profileCellSegue"]){
        NSIndexPath * indexPath = [self.tableView indexPathForSelectedRow];
        reviews * review = [relevantReviewsArray objectAtIndex:indexPath.row];
        [[segue destinationViewController] getReview:review];
    }
}

@end
