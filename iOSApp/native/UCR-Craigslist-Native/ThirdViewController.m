//
//  ThirdViewController.m
//  UCR-Craigslist-Native
//
//  Created by Michael Chen on 5/20/16.
//  Copyright © 2016 UCR. All rights reserved.
//

#import "ThirdViewController.h"
#import "messages.h"
#import "loginPage.h"
#import "dbArrays.h"
#import "users.h"
#import "messagesCellDetail.h"
#import "newMessageViewController.h"

@interface ThirdViewController ()

@end

@implementation ThirdViewController
@synthesize navBar, num_threads_label, loginPageObj, friends;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupData];
    [self setupUI];
    
}

- (void)setupData{
    loginPageObj = [[loginPage alloc] init];
    [loginPageObj retrieveMessages];
    [self getRelevantThreads];
    [self.tableView reloadData];
}

- (void)setupUI{
    self.view.backgroundColor = [UIColor colorWithRed:0.13 green:0.13 blue:0.13 alpha:1.0];
    num_threads_label.userInteractionEnabled = false;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
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
    num_threads_label.textAlignment = NSTextAlignmentCenter;
}


-(void)refreshAll{
    [self setupData];
    [self checkTransition];
    self.navigationController.toolbarHidden = true;
}

- (void) viewWillAppear:(BOOL)animated {
    [self refreshAll];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    //NSLog(@"transition: %d", [dbArrays sharedInstance].transition);
    if([dbArrays sharedInstance].transition){ // prevent extraneous transitioning
        //NSLog(@"SHOULD BE TRANSITIONING!!!!!!!!!!!!!!!!!!");
        [self performSegueWithIdentifier:@"messageCellSegue" sender:self];
    }
}

- (void)checkTransition{ //transition to the convo view after sending a new message from the composer
    //NSLog(@"transition: %d", [dbArrays sharedInstance].transition);
    if([dbArrays sharedInstance].transition){
        NSIndexPath * path = [NSIndexPath indexPathForRow:[dbArrays sharedInstance].relevantThreadsArray.count - 1 inSection:0];
        [self.tableView selectRowAtIndexPath:path animated:YES scrollPosition:UITableViewScrollPositionNone];
        [self tableView:self.tableView didSelectRowAtIndexPath:path];
        [dbArrays sharedInstance].transition = false;
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
    return [dbArrays sharedInstance].relevantThreadsArray.count;
}

- (void)dismissThreadsAndShowComposer{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UIViewController *newMessageViewController = [storyboard instantiateViewControllerWithIdentifier:@"newMessageViewController"];
    [self presentViewController:newMessageViewController animated:YES completion:nil];
}

- (void)presentPopup:(NSString *)titleText message: (NSString *)message{
    //courtesy popup
    UIAlertController *alert = [UIAlertController
                                alertControllerWithTitle:titleText
                                message:message
                                preferredStyle:UIAlertControllerStyleAlert];
    
    [self presentViewController:alert animated:YES completion:nil];
    
    //button creation and function (handler)
    UIAlertAction* actionOk = [UIAlertAction
                               actionWithTitle:@"Ok"
                               style:UIAlertActionStyleDefault
                               handler:^(UIAlertAction * action) {}];
    
    [alert addAction:actionOk];
}

- (void)getRelevantThreads{
    users * userObj;
    messages * message;
    
    [dbArrays sharedInstance].relevantThreadsArraySender = [NSMutableArray new];
    [dbArrays sharedInstance].relevantThreadsArray = [NSMutableArray new];
    
    //finding user.username
    for(int i  = 0; i < [dbArrays sharedInstance].usersArray.count; i++){
        userObj = [[dbArrays sharedInstance].usersArray objectAtIndex:i];
        //NSLog(@"userObj.loggedIn: %@", userObj.loggedIn);
        if(userObj.loggedIn){
            [dbArrays sharedInstance].user.username = userObj.username;
            break;
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
        
        /*NSLog(@"message.message_receiver: %@", message.message_receiver);
        NSLog(@"message.message_sender: %@", message.message_sender);
        NSLog(@"[dbArrays sharedInstance].user.username: %@", [dbArrays sharedInstance].user.username);
        NSLog(@"[dbArrays sharedInstance].relevantThreadsArraySender: %@", [dbArrays sharedInstance].relevantThreadsArraySender);*/
        
        if([message.message_receiver isEqualToString:[dbArrays sharedInstance].user.username] && ![[dbArrays sharedInstance].relevantThreadsArraySender containsObject:message.message_sender]){
            //NSLog(@"thread ADDED!!!!!!!!!!!!!!!!!");
            [[dbArrays sharedInstance].relevantThreadsArray addObject:message];
            [[dbArrays sharedInstance].relevantThreadsArraySender addObject:message.message_sender];
        }
        else if([message.message_sender isEqualToString:[dbArrays sharedInstance].user.username] && ![[dbArrays sharedInstance].relevantThreadsArraySender containsObject:message.message_receiver]){
            //NSLog(@"thread ADDED!!!!!!!!!!!!!!!!!");
            [[dbArrays sharedInstance].relevantThreadsArray addObject:message];
            [[dbArrays sharedInstance].relevantThreadsArraySender addObject:message.message_receiver];
        }
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"threadCell" forIndexPath:indexPath];
    
    messages * message = [[dbArrays sharedInstance].relevantThreadsArray objectAtIndex:indexPath.row];
    if([message.message_sender isEqualToString:[dbArrays sharedInstance].user.username]){
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


#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if([[segue identifier] isEqualToString:@"messageCellSegue"]){
        NSIndexPath * indexPath = [self.tableView indexPathForSelectedRow];
        messages * message = [[dbArrays sharedInstance].relevantThreadsArray objectAtIndex:indexPath.row];
        [[segue destinationViewController] getMessages:message]; //pass on message object to convo view
    }
}

- (IBAction)newButton:(id)sender {
    //NSLog(@"relevantThreadsArray.count: %lu", [dbArrays sharedInstance].relevantThreadsArray.count);
    //NSLog(@"usersArray.count: %lu", [dbArrays sharedInstance].usersArray.count);
    if([dbArrays sharedInstance].relevantThreadsArray.count < [dbArrays sharedInstance].usersArray.count - 1){
        [self dismissThreadsAndShowComposer];
    }
    else{
        [self presentPopup:@"You have already messaged every existing user." message:@"Please select a user to message from your list of threads."];
    }
}

@end
