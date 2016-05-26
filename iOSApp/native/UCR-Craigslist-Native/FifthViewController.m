//
//  FifthViewController.m
//  UCR-Craigslist-Native
//
//  Created by Michael Chen on 5/17/16.
//  Copyright © 2016 UCR. All rights reserved.
//

#import "FifthViewController.h"
#import "loginPage.h"
#import "reviews.h"
#import "dbArrays.h"
#import "users.h"
#import "profileCellDetail.h"

@interface FifthViewController ()

@end

@implementation FifthViewController
@synthesize navBar, num_reviews_label;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    self.view.backgroundColor = [UIColor colorWithRed:0.13 green:0.13 blue:0.13 alpha:1.0];
    num_reviews_label.userInteractionEnabled = false;
    
    [self refreshAll];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) viewWillAppear:(BOOL)animated {
    [self refreshAll];
}

- (void)refreshAll{
    loginPage * loginPageObj = [[loginPage alloc] init];
    [loginPageObj retrieveReviews];
    [self findRelevantReviews];
    [self.tableView reloadData];
}

- (void)dismissProfileAndShowLogin{
    [self dismissViewControllerAnimated:YES completion:^{
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        UITabBarController *loginPage = [storyboard instantiateViewControllerWithIdentifier:@"loginPage"];
        [self presentViewController:loginPage animated:YES completion:nil];
    }];
}

- (void)presentOptionPopup:(NSString *)titleText message: (NSString *)message{
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
                                   [self dismissProfileAndShowLogin];
                               }];
    
    [alert addAction:logout];
    [alert addAction:cancel];
    
    [self presentViewController:alert animated:YES completion:nil];
}

- (IBAction)logoutButton:(id)sender {
    [self presentOptionPopup:@"Logout" message:@"Are you sure you want to logout?"];
}

- (NSMutableArray*)findRelevantReviews{
    users * userObj;
    reviews * reviewObj;
    
    //NSUInteger reviewCnt = 0;
    
    NSMutableArray * relevantReviewsArray = [NSMutableArray new];
    NSString * currentLoggedInUserName;
    NSString * currentLoggedInUserID;
    NSString * currentLoggedInUserRating;
    NSString * currentLoggedInUserNumOfRatings;
    float currentLoggedInUserRatingFloat = 0.0;
    
    for(int i  = 0; i < [dbArrays sharedInstance].usersArray.count; i++){
        userObj = [[dbArrays sharedInstance].usersArray objectAtIndex:i];
        NSLog(@"userObj.loggedIn: %@", userObj.loggedIn);
        if([userObj.loggedIn isEqualToString:@"true"]){
            currentLoggedInUserName = userObj.username;
            currentLoggedInUserID = userObj.userID;
            currentLoggedInUserRatingFloat = [userObj.total_rating floatValue] / [userObj.num_reviews floatValue];
            currentLoggedInUserRating = [NSString stringWithFormat:@"%.1f", currentLoggedInUserRatingFloat];
            currentLoggedInUserNumOfRatings = userObj.num_reviews;
        }
        
    }
    
    for(int i = 0; i < [dbArrays sharedInstance].reviewsArray.count; i++){
        reviewObj = [[dbArrays sharedInstance].reviewsArray objectAtIndex:i];
        NSLog(@"reviewObj.user_id: %@", reviewObj.user_id);
        NSLog(@"currentLoggedInUserID: %@", currentLoggedInUserID);
        NSLog(@"currentLoggedInUserName: %@", currentLoggedInUserName);
        NSLog(@"currentLoggedInUserRating: %@", currentLoggedInUserRating);
        NSLog(@"currentLoggedInUserNumOfRatings: %@", currentLoggedInUserNumOfRatings);
 
        
        if([reviewObj.user_id isEqualToString:currentLoggedInUserID]){
            NSLog(@"reivewObj ADDED!!!!!!!!!!!!!!!!!");
            [relevantReviewsArray addObject:reviewObj];
            //reviewCnt++;
        }
    }
    
    //set rating to 0 if null
    if(isnan(currentLoggedInUserRatingFloat)){
        navBar.title = [NSString stringWithFormat:@"%@", currentLoggedInUserName];
    }
    if(currentLoggedInUserRatingFloat == (int)currentLoggedInUserRatingFloat){
        currentLoggedInUserRating = [NSString stringWithFormat:@"%d", (int)currentLoggedInUserRatingFloat];
        navBar.title = [NSString stringWithFormat:@"%@: %@/5", currentLoggedInUserName, currentLoggedInUserRating];
    }
    
    //set num of ratings label here
    if([currentLoggedInUserNumOfRatings isEqualToString:@"0"]){
        num_reviews_label.text = [NSString stringWithFormat:@"No reviews yet"];
    }
    else{
        num_reviews_label.text = [NSString stringWithFormat:@"%@ reviews", currentLoggedInUserNumOfRatings];
    }
    num_reviews_label.textColor = [UIColor whiteColor];
    num_reviews_label.backgroundColor = [UIColor blackColor];
    
    NSLog(@"END OF findRelevantReviews; relevantReviewsArray.count: %lu", (unsigned long)relevantReviewsArray.count);
    return relevantReviewsArray;
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
    NSLog(@"relevantReviewsArray.count: %lu", (unsigned long)[self findRelevantReviews].count);
    return [self findRelevantReviews].count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"profileCell" forIndexPath:indexPath];
    
    // Configure the cell...
    
    reviews * review;
    review = [[self findRelevantReviews] objectAtIndex:indexPath.row];
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
        
        //get obj for selected row
        reviews * review = [[self findRelevantReviews] objectAtIndex:indexPath.row];
        
        [[segue destinationViewController] getReview:review];
    }
}

@end
