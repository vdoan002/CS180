//
//  messagesCellDetail.m
//  UCR-Craigslist-Native
//
//  Created by Michael Chen on 5/20/16.
//  Copyright © 2016 UCR. All rights reserved.
//

#import "messagesCellDetail.h"
#import "messages.h"
#import "loginPage.h"
#import "dbArrays.h"
#import "users.h"
#import "messagesCellDetail.h"

@interface messagesCellDetail ()

@end

@implementation messagesCellDetail
@synthesize message, navBarItem, currentLoggedInUserName, num_messages_label, barButtonItem, composeField, sendButtonItem, loginPageObj, relevantMessagesArray;
- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    self.view.backgroundColor = [UIColor colorWithRed:0.13 green:0.13 blue:0.13 alpha:1.0];
    loginPageObj = [[loginPage alloc] init];
    
    [self findRelevantMessages];
    composeField = [[UITextView alloc] initWithFrame:CGRectMake(0, 10, 310, 32)];
    self.composeField.layer.cornerRadius = 10;
    UIBarButtonItem * textFieldItem = [[UIBarButtonItem alloc] initWithCustomView:composeField];


    self.toolbarItems= @[textFieldItem];
    NSMutableArray * newItems = [self.toolbarItems mutableCopy];
    [newItems addObject:sendButtonItem];
    self.toolbarItems = newItems;
    
    self.navigationController.toolbar.barTintColor = [UIColor blackColor];
    [self.navigationController.toolbar setFrame:CGRectMake(self.navigationController.toolbar.frame.origin.x,
                                                           self.navigationController.toolbar.frame.origin.y,
                                                           self.navigationController.toolbar.frame.size.width,
                                                           self.navigationController.toolbar.frame.size.height + 20)];
    
    // keyboard listener http://stackoverflow.com/questions/30879903/move-uitoolbar-with-keyboard-ios8
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow:)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHide:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
    
    //keyboard dismiss: http://stackoverflow.com/a/5711504
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                          action:@selector(dismissKeyboard)];
    [self.view addGestureRecognizer:tap];
    
    num_messages_label.userInteractionEnabled = false;
    self.navigationController.toolbarHidden = false;
    self.tableView.estimatedRowHeight = 100.0;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    loginPageObj = [[loginPage alloc] init];
}

-(void)dismissKeyboard { //http://stackoverflow.com/a/5711504
    [composeField resignFirstResponder];
}

// move toolbar up and down http://stackoverflow.com/questions/30879903/move-uitoolbar-with-keyboard-ios8
- (void)keyboardWillShow:(NSNotification *)aNotification
{
    NSDictionary* keyboardInfo = [aNotification userInfo];
    
    // the keyboard is showing so resize the table's height
    NSTimeInterval animationDuration =
    [[[aNotification userInfo] objectForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    
    //kbSize: http://www.idev101.com/code/User_Interface/keyboard.html
    CGSize kbSize = [[keyboardInfo objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
    NSLog(@"kbSize.height: %f", kbSize.height);
    
    [UIView beginAnimations:@"ResizeForKeyboard" context:nil];
    [UIView setAnimationDuration:animationDuration];

    [self.navigationController.toolbar setFrame:CGRectMake(self.navigationController.toolbar.frame.origin.x,
                                                           self.navigationController.toolbar.frame.origin.y - 162.0,
                                                           self.navigationController.toolbar.frame.size.width,
                                                           self.navigationController.toolbar.frame.size.height)];
    
    [UIView commitAnimations];
}

- (void)keyboardWillHide:(NSNotification *)aNotification
{
    NSDictionary* keyboardInfo = [aNotification userInfo];
    
    //kbSize: http://www.idev101.com/code/User_Interface/keyboard.html
    CGSize kbSize = [[keyboardInfo objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
    NSLog(@"kbSize.height: %f", kbSize.height);
    
    // the keyboard is hiding reset the table's height
    NSTimeInterval animationDuration =
    [[[aNotification userInfo] objectForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    //frame.origin.y += self.navigationController.toolbar.frame.size.height;
    [UIView beginAnimations:@"ResizeForKeyboard" context:nil];
    [UIView setAnimationDuration:animationDuration];
    
    [self.navigationController.toolbar setFrame:CGRectMake(self.navigationController.toolbar.frame.origin.x,
                                                           self.navigationController.toolbar.frame.origin.y + 162.0,
                                                           self.navigationController.toolbar.frame.size.width,
                                                           self.navigationController.toolbar.frame.size.height)];
    
    [UIView commitAnimations];
}
// http://stackoverflow.com/a/11515771
// http://stackoverflow.com/a/15589721
-(void)writeToDB{
    // Create your request string with parameter name as defined in PHP file
    NSString * messageUser;
    NSString * messageFriend;
    if([message.message_sender isEqualToString:currentLoggedInUserName]){
        messageUser = message.message_sender;
        messageFriend = message.message_receiver;
    }
    else{
        messageUser = message.message_receiver;
        messageFriend = message.message_sender;
    }
    NSString *myRequestString = [NSString stringWithFormat:@"content=%@&sender=%@&receiver=%@&", composeField.text, messageUser, messageFriend];
    
    // Create Data from request
    NSData *data = [NSData dataWithBytes: [myRequestString UTF8String] length: [myRequestString length]];
    NSString *postLength = [NSString stringWithFormat:@"%lu", (unsigned long)[data length]];
    /*NSDictionary *dictionary = @{@"content": composeField.text, @"sender": currentLoggedInUserName, @"receiver": message.message_sender};
    NSError *error = nil;
    NSData *data = [NSJSONSerialization dataWithJSONObject:dictionary
                                                   options:kNilOptions error:&error];*/

    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL: [NSURL URLWithString: @"http://www.practicemakesperfect.co.nf/setMessage.php"]];
    
    [request setHTTPMethod: @"POST"];
    [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
    [request setHTTPBody: data];
    
    NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    [[session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        NSString *requestReply = [[NSString alloc] initWithData:data encoding:NSASCIIStringEncoding];
        NSLog(@"requestReply: %@", requestReply);
    }] resume];
    
    /*NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:config];
    NSURLSessionUploadTask *uploadTask = [session uploadTaskWithRequest:request fromData:data completionHandler:^(NSData *data,NSURLResponse *response, NSError *error) {
        NSLog(@"response: %@", response);
    }];
    [uploadTask resume];*/
    //NSData * returnData = [NSURLConnection sendSynchronousRequest: request returningResponse: nil error: nil];
    // Log Response
    //NSString * response = [[NSString alloc] initWithBytes:[returnSession bytes] length:[returnData length] encoding:NSUTF8StringEncoding];
    //NSLog(@"response: %@",response);
}

-(void)refreshAll{
    NSLog(@"Before retrieveChat - relevantMessagesArray.count: %lu",relevantMessagesArray.count);
    NSLog(@"Before retrieveChat - messagesArray.count: %lu", [dbArrays sharedInstance].messagesArray.count);
    [loginPageObj retrieveMessages]; //reload database retrieval
    NSLog(@"After retrieveChat - messagesArray.count: %lu", [dbArrays sharedInstance].messagesArray.count);
    [self findRelevantMessages];
    NSLog(@"After retrieveChat - relevantMessagesArray.count: %lu",relevantMessagesArray.count);
    NSLog(@"%@", self.tableView);
    [self.tableView reloadData];
}

- (IBAction)sendButton:(id)sender{
    if(![composeField.text isEqualToString:@""]){
        [self writeToDB]; //write to the database
        [self performSelector:@selector(refreshAll) withObject:self afterDelay:1.0];
        NSLog(@"composeField.text: %@", composeField.text);
        [composeField setText:@""];
    }
}

- (IBAction)refreshButton:(id)sender {
    [self refreshAll];
}

- (void) viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.tableView reloadData];
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
    return relevantMessagesArray.count;
}

-(void)findRelevantMessages{
    users * userObj;
    messages * messageObj;
    
    relevantMessagesArray = [NSMutableArray new];
    NSString * currentLoggedInUserID;
    
    for(int i  = 0; i < [dbArrays sharedInstance].usersArray.count; i++){
        userObj = [[dbArrays sharedInstance].usersArray objectAtIndex:i];
        NSLog(@"userObj.loggedIn: %@", userObj.loggedIn);
        if([userObj.loggedIn isEqualToString:@"true"]){
            currentLoggedInUserName = userObj.username;
            currentLoggedInUserID = userObj.userID;
        }
    }
    
    for(int i = 0; i < [dbArrays sharedInstance].messagesArray.count; i++){
        NSString * messageUser;
        NSString * messageFriend;
        messageObj = [[dbArrays sharedInstance].messagesArray objectAtIndex:i];
        if([message.message_sender isEqualToString:currentLoggedInUserName]){
            messageUser = message.message_sender;
            messageFriend = message.message_receiver;
        }
        else{
            messageUser = message.message_receiver;
            messageFriend = message.message_sender;
        }
        
        //set title
        navBarItem.title = messageFriend;
        
        if(([messageObj.message_receiver isEqualToString:currentLoggedInUserName] && [messageObj.message_sender isEqualToString:messageFriend]) || ([messageObj.message_sender isEqualToString:currentLoggedInUserName] && [messageObj.message_receiver isEqualToString:messageFriend])){
            /*NSLog(@"message ADDED!!!!!!!!!!!!!!!!!");
            NSLog(@"messageObj.message_id: %@", messageObj.message_id);
            NSLog(@"messageObj.message_sender: %@", messageObj.message_sender);
            NSLog(@"messageObj.message_receiver: %@", messageObj.message_receiver);
            NSLog(@"messageObj.message_content: %@", messageObj.message_content);
            NSLog(@"messageObj.message_timesent: %@", messageObj.message_timesent);
            NSLog(@"messageObj.message_date: %@", messageObj.message_date);
            NSLog(@"messageObj.message_seen: %@", messageObj.message_seen);*/
            [relevantMessagesArray addObject:messageObj];
        }
    }
    
    
    
    //set num of messages label here
    if(relevantMessagesArray.count == 1){
         num_messages_label.text = @"1 message";
    }
    else{
        num_messages_label.text = [NSString stringWithFormat:@"%lu messages", (unsigned long)relevantMessagesArray.count];
    }
    num_messages_label.textColor = [UIColor whiteColor];
    num_messages_label.backgroundColor = [UIColor blackColor];
}

-(void)getMessages:(id)_message{
    message = _message;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"messageCell" forIndexPath:indexPath];
    
    messages * message_output;
    message_output = [relevantMessagesArray objectAtIndex:indexPath.row];
    NSString * timeStamp = [NSString stringWithFormat:@"%@ on %@", message_output.message_timesent, message_output.message_date];
    if([message_output.message_sender isEqualToString:currentLoggedInUserName]){
        //right align
        cell.textLabel.textAlignment = NSTextAlignmentRight;
        cell.detailTextLabel.textAlignment = NSTextAlignmentRight;
        cell.detailTextLabel.text = [NSString stringWithFormat:@"you @ %@", timeStamp];
    }
    else{
        cell.detailTextLabel.text = [NSString stringWithFormat:@"%@ @ %@", message_output.message_sender, timeStamp];
    }
    cell.textLabel.text = [NSString stringWithFormat:@"%@", message_output.message_content];
    cell.accessoryType = UITableViewCellAccessoryNone;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.textLabel.numberOfLines = 0;
    [cell.textLabel setLineBreakMode:NSLineBreakByWordWrapping];
    cell.backgroundColor = [UIColor colorWithRed:0.13 green:0.13 blue:0.13 alpha:1.0];
    cell.textLabel.textColor = [UIColor whiteColor];
    cell.detailTextLabel.textColor = [UIColor whiteColor];
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
