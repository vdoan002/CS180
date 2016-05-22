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

@interface FourthViewController ()

@end

@implementation FourthViewController
@synthesize navBar, num_threads_label;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    num_threads_label.userInteractionEnabled = false;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self findRelevantThreads].count;
}

- (IBAction)newButton:(id)sender {
    
}

- (NSMutableArray*)findRelevantThreads{
    users * userObj;
    messages * message;
    //NSUInteger reviewCnt = 0;
    
    NSMutableArray * relevantThreadsArraySender = [NSMutableArray new];
    NSMutableArray * relevantThreadsArray = [NSMutableArray new];
    NSString * currentLoggedInUserName;
    NSString * currentLoggedInUserID;
    
    for(int i  = 0; i < [dbArrays sharedInstance].usersArray.count; i++){
        userObj = [[dbArrays sharedInstance].usersArray objectAtIndex:i];
        //NSLog(@"userObj.loggedIn: %@", userObj.loggedIn);
        if([userObj.loggedIn isEqualToString:@"true"]){
            currentLoggedInUserName = userObj.username;
            currentLoggedInUserID = userObj.userID;
        }
        
    }
    
    for(int i = 0; i < [dbArrays sharedInstance].messagesArray.count; i++){
        message = [[dbArrays sharedInstance].messagesArray objectAtIndex:i];
        NSLog(@"message.message_id: %@", message.message_id);
        NSLog(@"message.message_sender: %@", message.message_sender);
        NSLog(@"message.message_receiver: %@", message.message_receiver);
        NSLog(@"message.message_content: %@", message.message_content);
        NSLog(@"message.message_timesent: %@", message.message_timesent);
        NSLog(@"message.message_date: %@", message.message_date);
        NSLog(@"message.message_seen: %@", message.message_seen);

        if([message.message_receiver isEqualToString:currentLoggedInUserName] && ![relevantThreadsArraySender containsObject:message.message_sender]){
            NSLog(@"thread ADDED!!!!!!!!!!!!!!!!!");
            [relevantThreadsArray addObject:message];
            [relevantThreadsArraySender addObject:message.message_sender];
        }
    }
    
    //set num of threads label here
    if(relevantThreadsArray.count == 0){
       num_threads_label.text = @"You need friends";
    }
    else if(relevantThreadsArray.count == 1){
        num_threads_label.text = @"1 thread";
    }
    else{
        num_threads_label.text = [NSString stringWithFormat:@"%lu threads", (unsigned long)relevantThreadsArray.count];
    }
    
    return relevantThreadsArray;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"threadCell" forIndexPath:indexPath];
    
    // Configure the cell...
    
    //messages * message;
    messages * message = [[self findRelevantThreads] objectAtIndex:indexPath.row];
    cell.textLabel.text = message.message_sender;
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
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
        messages * message = [[self findRelevantThreads] objectAtIndex:indexPath.row];
        
        [[segue destinationViewController] getMessages:message];
    }
}

@end
