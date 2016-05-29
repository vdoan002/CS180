//
//  newMessageViewController.m
//  UCR-Craigslist-Native
//
//  Created by Michael Chen on 5/25/16.
//  Copyright © 2016 UCR. All rights reserved.
//

#import "newMessageViewController.h"
#import "loginPage.h"
#import "messages.h"
#import "users.h"
#import "dbArrays.h"
#import "messagesCellDetail.h"

@interface newMessageViewController ()

@end

@implementation newMessageViewController
@synthesize usersPicker, msgView, friends, xingFriend, navBar;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setupData];
    [self setupKeyboard];
    [self setupUI];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)dismissKeyboard { //http://stackoverflow.com/a/5711504
    [msgView resignFirstResponder];
}

- (void)setupKeyboard{
    //keyboard dismiss: http://stackoverflow.com/a/5711504
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                          action:@selector(dismissKeyboard)];
    [self.view addGestureRecognizer:tap];
}

- (void)setupData{
    [self setupFriends];
    msgView.delegate = self;
    usersPicker.delegate = self;
    usersPicker.dataSource = self;
}

- (void)setupUI{
    self.view.backgroundColor = [UIColor colorWithRed:0.13 green:0.13 blue:0.13 alpha:1.0];
    self.msgView.layer.cornerRadius = 5;
    [navBar setFrame:CGRectMake(0, 0, self.view.frame.size.width, 64.0)];
}

- (void)setupFriends{ //get list of friends that have not been messaged yet
    friends = [[NSMutableArray alloc] init];
    for(int i = 0; i < [dbArrays sharedInstance].usersArray.count; i++){
        users * userObj = [[dbArrays sharedInstance].usersArray objectAtIndex:i];
        BOOL alreadyMessaged = false;
        
        // skip user.username check
        if([userObj.username isEqualToString:[dbArrays sharedInstance].user.username]){
            alreadyMessaged = true;
        }
        
        //NSLog(@"usersArray[%d].username: %@", i, userObj.username);
        for(int j = 0; j < [dbArrays sharedInstance].relevantThreadsArraySender.count && !alreadyMessaged; j++){
            NSString * sender = [[dbArrays sharedInstance].relevantThreadsArraySender objectAtIndex:j];
            //NSLog(@"relevantThreadsArraySender[%d]: %@", j, sender);
            if([sender isEqualToString:userObj.username]){
                alreadyMessaged = true;
            }
        }
        if(!alreadyMessaged){
            //NSLog(@"ADDING NEW FRIEND");
            [friends addObject:[[[dbArrays sharedInstance].usersArray objectAtIndex:i] username]];
        }
    }
    //sort by alphabetical order http://stackoverflow.com/a/6107774
    [friends sortUsingSelector:@selector(caseInsensitiveCompare:)];
    xingFriend = friends[0];
}

- (void)viewWillAppear:(BOOL)animated {
    self.navigationController.navigationBarHidden = false;
    [navBar setFrame:CGRectMake(0, 0, self.view.frame.size.width, 64.0)];
}

- (void)textViewDidBeginEditing:(UITextView *)textView{
    NSLog(@"msgView.text: %@", msgView.text);
    if(textView == msgView && [msgView.text isEqualToString:@"enter a message"]){
        msgView.text = @"";
    }
}

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

- (void)getFriends:(id)_friends{ //pasover method from FourthViewController
    friends = _friends;
}

//UIPickerView setup http://stackoverflow.com/questions/13756591/how-would-i-set-up-a-uipickerview
// http://www.techotopia.com/index.php/An_iOS_7_UIPickerView_Example#UIPickerView_Delegate_and_DataSource
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)thePickerView {
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)thePickerView numberOfRowsInComponent:(NSInteger)component {
    //NSLog(@"friends.count: %lu", (unsigned long)friends.count);
    return friends.count;
}

- (NSString *)pickerView:(UIPickerView *)thePickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    return friends[row];
}

// changing pickerView text color http://stackoverflow.com/q/20698547
- (NSAttributedString *)pickerView:(UIPickerView *)pickerView attributedTitleForRow:(NSInteger)row forComponent:(NSInteger)component {
    NSString * friend = friends[row];
    NSAttributedString * attString = [[NSAttributedString alloc] initWithString:friend attributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
    return attString;
}

#pragma mark -
#pragma mark PickerView Delegate
-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row
      inComponent:(NSInteger)component{
    xingFriend = friends[row];
}

// http://stackoverflow.com/a/11515771
// http://stackoverflow.com/a/15589721
-(void)writeToDB{
    // Create your request string with parameter name as defined in PHP file
    NSString *myRequestString = [NSString stringWithFormat:@"content=%@&sender=%@&receiver=%@&", msgView.text, [dbArrays sharedInstance].user.username, xingFriend];
    
    // Create Data from request
    NSData *data = [NSData dataWithBytes: [myRequestString UTF8String] length: [myRequestString length]];
    NSString *postLength = [NSString stringWithFormat:@"%lu", (unsigned long)[data length]];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL: [NSURL URLWithString: @"http://www.practicemakesperfect.co.nf/setMessage.php"]];
    
    [request setHTTPMethod: @"POST"];
    [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
    [request setHTTPBody: data];
    
    NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    [[session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {}] resume];
}

- (void)dismissComposeAndShowMessages{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UITableViewController * messagesCellDetail = [storyboard instantiateViewControllerWithIdentifier:@"messagesCellDetail"];
    [self presentViewController:messagesCellDetail animated:YES completion:nil];
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

- (IBAction)sendButton:(id)sender {
    if(![msgView.text isEqualToString:@""] && ![msgView.text isEqualToString:@"enter a message"]){
        [self writeToDB]; //write to the database
 
        //courtesy popup
        UIAlertController *alert = [UIAlertController
                                    alertControllerWithTitle:@"Message sent!"
                                    message:@"You have made a new friend."
                                    preferredStyle:UIAlertControllerStyleAlert];
        
        //button creation and function (handler)
        UIAlertAction* actionOk = [UIAlertAction
                                   actionWithTitle:@"Ok"
                                   style:UIAlertActionStyleDefault
                                   handler:^(UIAlertAction * action) {
                                       [dbArrays sharedInstance].transition = true;
                                       [self dismissViewControllerAnimated:YES completion:nil];
                                   }];
        
        [alert addAction:actionOk];
        
        [self presentViewController:alert animated:YES completion:nil];
    }
    else{
        [self presentPopup:@"Empty message!" message:@"Please enter a message."];
    }
}

- (IBAction)cancelButton:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
