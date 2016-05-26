//
//  FourthViewController.m
//  UCR-Craigslist-Native
//
//  Created by Michael Chen on 5/20/16.
//  Copyright © 2016 UCR. All rights reserved.
//

#import "FourthViewController.h"
#import "messages.h"
#import "loginPage.h"
#import "dbArrays.h"
#import "users.h"
#import "messagesCellDetail.h"
#import "newMessageViewController.h"

@interface FourthViewController ()

@end

@implementation FourthViewController
@synthesize navBar, num_threads_label, loginPageObj, friends;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    self.view.backgroundColor = [UIColor colorWithRed:0.13 green:0.13 blue:0.13 alpha:1.0];
    num_threads_label.userInteractionEnabled = false;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self findRelevantThreads];
    loginPageObj = [[loginPage alloc] init];
    
    [loginPageObj retrieveMessages];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
    return [dbArrays sharedInstance].relevantThreadsArray.count;
}

- (void)dismissThreadsAndShowComposer{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UIViewController *newMessageViewController = [storyboard instantiateViewControllerWithIdentifier:@"newMessageViewController"];
    [self presentViewController:newMessageViewController animated:YES completion:nil];
}

- (IBAction)newButton:(id)sender {
    [self dismissThreadsAndShowComposer];
}

- (void)findRelevantThreads{
    users * userObj;
    messages * message;
    //NSUInteger reviewCnt = 0;
    
    [dbArrays sharedInstance].relevantThreadsArraySender = [NSMutableArray new];
    [dbArrays sharedInstance].relevantThreadsArray = [NSMutableArray new];
    NSString * currentLoggedInUserID;
    
    for(int i  = 0; i < [dbArrays sharedInstance].usersArray.count; i++){
        userObj = [[dbArrays sharedInstance].usersArray objectAtIndex:i];
        //NSLog(@"userObj.loggedIn: %@", userObj.loggedIn);
        if([userObj.loggedIn isEqualToString:@"true"]){
            [dbArrays sharedInstance].currentLoggedInUserName = userObj.username;
            currentLoggedInUserID = userObj.userID;
        }
    }
    
    for(int i = 0; i < [dbArrays sharedInstance].messagesArray.count; i++){
        message = [[dbArrays sharedInstance].messagesArray objectAtIndex:i];
        /*NSLog(@"message.message_id: %@", message.message_id);
        NSLog(@"message.message_sender: %@", message.message_sender);
        NSLog(@"message.message_receiver: %@", message.message_receiver);
        NSLog(@"message.message_content: %@", message.message_content);
        NSLog(@"message.message_timesent: %@", message.message_timesent);
        NSLog(@"message.message_date: %@", message.message_date);
        NSLog(@"message.message_seen: %@", message.message_seen);*/

        if([message.message_receiver isEqualToString:[dbArrays sharedInstance].currentLoggedInUserName] && ![[dbArrays sharedInstance].relevantThreadsArraySender containsObject:message.message_sender]){
            //NSLog(@"thread ADDED!!!!!!!!!!!!!!!!!");
            [[dbArrays sharedInstance].relevantThreadsArray addObject:message];
            [[dbArrays sharedInstance].relevantThreadsArraySender addObject:message.message_sender];
        }
        else if([message.message_sender isEqualToString:[dbArrays sharedInstance].currentLoggedInUserName] && ![[dbArrays sharedInstance].relevantThreadsArraySender containsObject:message.message_receiver]){
            //NSLog(@"thread ADDED!!!!!!!!!!!!!!!!!");
            [[dbArrays sharedInstance].relevantThreadsArray addObject:message];
            [[dbArrays sharedInstance].relevantThreadsArraySender addObject:message.message_receiver];
        }
    }
    
    //set num of threads label here
    if([dbArrays sharedInstance].relevantThreadsArray.count == 0){
       num_threads_label.text = @"You need friends";
    }
    else if([dbArrays sharedInstance].relevantThreadsArray.count == 1){
        num_threads_label.text = @"1 thread";
    }
    else{
        num_threads_label.text = [NSString stringWithFormat:@"%lu threads", (unsigned long)[dbArrays sharedInstance].relevantThreadsArray.count];
    }
    num_threads_label.textColor = [UIColor whiteColor];
    num_threads_label.backgroundColor = [UIColor blackColor];
    self.num_threads_label.textAlignment = NSTextAlignmentCenter;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"threadCell" forIndexPath:indexPath];
    
    // Configure the cell...
    
    //messages * message;
    messages * message = [[dbArrays sharedInstance].relevantThreadsArray objectAtIndex:indexPath.row];
    if([message.message_sender isEqualToString:[dbArrays sharedInstance].currentLoggedInUserName]){
        cell.textLabel.text = message.message_receiver;
    }
    else{
        cell.textLabel.text = message.message_sender;
    }
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.backgroundColor = [UIColor colorWithRed:0.13 green:0.13 blue:0.13 alpha:1.0];
    cell.textLabel.textColor = [UIColor whiteColor];
    cell.textLabel.highlightedTextColor = [UIColor blackColor];
    
    return cell;
}

-(void)refreshAll{
    [loginPageObj retrieveMessages]; //reload database retrieval
    [self findRelevantThreads];
    [self.tableView reloadData];
    self.navigationController.toolbarHidden = true;
}

/*-(void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item {
    if(item.tag == 4) {
        NSLog(@"YOU GOT ME!");
        [self refreshAll];
    }
}*/

- (void) viewWillAppear:(BOOL)animated {
    [self refreshAll];
}
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
    
    if([[segue identifier] isEqualToString:@"messageCellSegue"]){
        NSIndexPath * indexPath = [self.tableView indexPathForSelectedRow];
        
        //get obj for selected row
        messages * message = [[dbArrays sharedInstance].relevantThreadsArray objectAtIndex:indexPath.row];
        
        [[segue destinationViewController] getMessages:message];
    }
    /*else if([[segue identifier] isEqualToString:@"newMsgSegue"]){
        [self setupFriends];
        NSLog(@"FourthViewController.friends.count: %lu", friends.count);
        [[segue destinationViewController] getFriends:friends];
    }*/
}

@end
