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
@synthesize message, navBarItem, num_messages_label, barButtonItem, composeField, sendButtonItem, loginPageObj, relevantMessagesArray;
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupData];
    [self setupKeyboard];
    [self setupUI];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setupUI{
    self.view.backgroundColor = [UIColor colorWithRed:0.13 green:0.13 blue:0.13 alpha:1.0];
    num_messages_label.userInteractionEnabled = false;
    self.tableView.estimatedRowHeight = 100.0;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    
    //creating composeField at the bottom
    composeField = [[UITextView alloc] initWithFrame:CGRectMake(0, 10, 310, 32)];
    self.composeField.layer.cornerRadius = 10;
    UIBarButtonItem * textFieldItem = [[UIBarButtonItem alloc] initWithCustomView:composeField];
    self.toolbarItems= @[textFieldItem]; //adding it to the toolbar
    NSMutableArray * newItems = [self.toolbarItems mutableCopy];
    [newItems addObject:sendButtonItem];
    self.toolbarItems = newItems;
    self.navigationController.toolbar.barTintColor = [UIColor blackColor];
    [self.navigationController.toolbar setFrame:CGRectMake(self.navigationController.toolbar.frame.origin.x,
                                                           self.navigationController.toolbar.frame.origin.y,
                                                           self.navigationController.toolbar.frame.size.width,
                                                           self.navigationController.toolbar.frame.size.height + 20)];
    self.navigationController.toolbarHidden = false;
    
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

- (void)setupData{
    [self getRelevantMessages];
}

- (void)setupKeyboard{
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
- (void)writeToDB{
    // Create your request string with parameter name as defined in PHP file
    NSString * messageUser;
    NSString * messageFriend;
    if([message.message_sender isEqualToString:[dbArrays sharedInstance].user.username]){
        messageUser = message.message_sender;
        messageFriend = message.message_receiver;
    }
    else{
        messageUser = message.message_receiver;
        messageFriend = message.message_sender;
    }
    NSString *myRequestString = [NSString stringWithFormat:@"content=%@&sender=%@&receiver=%@&", composeField.text, messageUser, messageFriend];
    NSData *data = [NSData dataWithBytes: [myRequestString UTF8String] length: [myRequestString length]];
    NSString *postLength = [NSString stringWithFormat:@"%lu", (unsigned long)[data length]];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL: [NSURL URLWithString: @"http://www.practicemakesperfect.co.nf/setMessage.php"]];
    
    [request setHTTPMethod: @"POST"];
    [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
    [request setHTTPBody: data];
    
    NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    [[session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {}] resume];
}

- (void)refreshAll{
    loginPageObj = [[loginPage alloc] init];
    [loginPageObj retrieveMessages]; //reload database retrieval
    [self getRelevantMessages];
    [self.tableView reloadData];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.tableView reloadData];
}

- (void)getMessages:(id)_message{
    message = _message;
}

- (void)getRelevantMessages{
    messages * messageObj;
    
    relevantMessagesArray = [NSMutableArray new];
    
    for(int i = 0; i < [dbArrays sharedInstance].messagesArray.count; i++){
        NSString * messageUser;
        NSString * messageFriend;
        messageObj = [[dbArrays sharedInstance].messagesArray objectAtIndex:i];
        if([message.message_sender isEqualToString:[dbArrays sharedInstance].user.username]){
            messageUser = message.message_sender;
            messageFriend = message.message_receiver;
        }
        else{
            messageUser = message.message_receiver;
            messageFriend = message.message_sender;
        }
        
        //set title
        navBarItem.title = messageFriend;
        
        if(([messageObj.message_receiver isEqualToString:[dbArrays sharedInstance].user.username] && [messageObj.message_sender isEqualToString:messageFriend]) || ([messageObj.message_sender isEqualToString:[dbArrays sharedInstance].user.username] && [messageObj.message_receiver isEqualToString:messageFriend])){
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
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return relevantMessagesArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"messageCell" forIndexPath:indexPath];
    messages * message_output;
    message_output = [relevantMessagesArray objectAtIndex:indexPath.row];
    NSString * timeStamp = [NSString stringWithFormat:@"%@ on %@", message_output.message_timesent, message_output.message_date];
    if([message_output.message_sender isEqualToString:[dbArrays sharedInstance].user.username]){
        //right align
        //cell.textLabel.textAlignment = NSTextAlignmentRight;
        //cell.detailTextLabel.textAlignment = NSTextAlignmentRight;
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

- (IBAction)sendButton:(id)sender{
    if(![composeField.text isEqualToString:@""]){
        [self writeToDB];
        [self performSelector:@selector(refreshAll) withObject:self afterDelay:0.5];
        NSLog(@"composeField.text: %@", composeField.text);
        [composeField setText:@""];
    }
}

- (IBAction)refreshButton:(id)sender {
    [self refreshAll];
}

@end
