//
//  registerPage.m
//  UCR-Craigslist-Native
//
//  Created by Michael Chen on 5/24/16.
//  Copyright © 2016 UCR. All rights reserved.
//

#import "registerPage.h"
#import "loginPage.h"
#import "dbArrays.h"
#import "users.h"

@interface registerPage ()

@end

@implementation registerPage
@synthesize emailTextField, userTextField, passwordTextField, registerUIButton, loginPageObj;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupUI];
    [self setupKeyboard];
    emailTextField.delegate = self;
    userTextField.delegate = self;
    passwordTextField.delegate = self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    if (textField == emailTextField) {
        [textField resignFirstResponder];
        [userTextField becomeFirstResponder];
    }
    else if (textField == userTextField) {
        [textField resignFirstResponder];
        [passwordTextField becomeFirstResponder];
    }
    else if (textField == userTextField) {
        [textField resignFirstResponder];
        [registerUIButton sendActionsForControlEvents:UIControlEventTouchUpInside];
    }
    return YES;
}

-(void)dismissKeyboard { //http://stackoverflow.com/a/5711504
    [emailTextField resignFirstResponder];
    [userTextField resignFirstResponder];
    [passwordTextField resignFirstResponder];
}

- (void)setupKeyboard{
    //keyboard dismiss: http://stackoverflow.com/a/5711504
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                          action:@selector(dismissKeyboard)];
    [self.view addGestureRecognizer:tap];
}

- (void)getLoginPageObj:(id)_loginPageObj{
    loginPageObj = _loginPageObj;
}

- (void)setupUI{
    emailTextField.placeholder = @"enter an UCR email";
    userTextField.placeholder = @"enter a username";
    passwordTextField.placeholder = @"enter a password";
    
    userTextField.text = loginPageObj.userTF.text;
    passwordTextField.text = loginPageObj.passwdTF.text;
}

- (void)presentPopup:(NSString *)titleText message: (NSString *)message{
    //courtesy popup
    UIAlertController *alert = [UIAlertController
                                alertControllerWithTitle:titleText
                                message:message
                                preferredStyle:UIAlertControllerStyleAlert];
    
    //button creation and function (handler)
    UIAlertAction* actionOk = [UIAlertAction
                               actionWithTitle:@"Ok"
                               style:UIAlertActionStyleDefault
                               handler:^(UIAlertAction * action) {}];
    
    [alert addAction:actionOk];
    
    [self presentViewController:alert animated:YES completion:nil];
}

// http://stackoverflow.com/a/11515771
// http://stackoverflow.com/a/15589721
- (void)writeToDB{
    // Create your request string with parameter name as defined in PHP file®
    NSString *myRequestString = [NSString stringWithFormat:@"email=%@&username=%@&password=%@", emailTextField.text, userTextField.text, passwordTextField.text];
    NSLog(@"%@", myRequestString);
    
    // Create Data from request
    NSData *data = [NSData dataWithBytes: [myRequestString UTF8String] length: [myRequestString length]];
    NSString *postLength = [NSString stringWithFormat:@"%lu", (unsigned long)[data length]];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL: [NSURL URLWithString: @"http://www.practicemakesperfect.co.nf/setRegistration.php"]];
    
    [request setHTTPMethod: @"POST"];
    [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
    [request setHTTPBody: data];
    
    NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    [[session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        NSString *requestReply = [[NSString alloc] initWithData:data encoding:NSASCIIStringEncoding];
        NSLog(@"requestReply: %@", requestReply);
    }] resume];
}

- (void)dismissRegistrationAndShowLogin{
    [self dismissViewControllerAnimated:YES completion:^{
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        UITabBarController *loginPage = [storyboard instantiateViewControllerWithIdentifier:@"loginPage"];
        [self presentViewController:loginPage animated:YES completion:nil];
    }];
}

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

- (IBAction)registerButton:(id)sender {
    BOOL userExist = false, emailExist = false;
    users * userObj;
    for(int i = 0; i < [dbArrays sharedInstance].usersArray.count; i++){
        userObj = [[dbArrays sharedInstance].usersArray objectAtIndex:i];
        if([userObj.username isEqualToString:userTextField.text]){
            userExist = true;
        }
        if([userObj.email isEqualToString:emailTextField.text]){
            emailExist = true;
        }
    }
    if([userTextField.text isEqualToString:@""] && [passwordTextField.text isEqualToString:@"" ] && [emailTextField.text isEqualToString:@""]){
        [self presentPopup:@"Empty email, username, and password!" message:@"Please enter an email address, username, and password."];
    }
    else if([userTextField.text isEqualToString:@""] && [passwordTextField.text isEqualToString:@""]){
        [self presentPopup:@"Empty username and password!" message:@"Please enter a username and password."];
    }
    else if([userTextField.text isEqualToString:@""] && [emailTextField.text isEqualToString:@""]){
        [self presentPopup:@"Empty email and username!" message:@"Please enter an email address and a username."];
    }
    else if([emailTextField.text isEqualToString:@""] && [passwordTextField.text isEqualToString:@""]){
        [self presentPopup:@"Empty email and password!" message:@"Please enter an email address and password."];
    }
    else if([emailTextField.text isEqualToString:@""]){
        [self presentPopup:@"Empty email!" message:@"Please enter an email address."];
    }
    else if([userTextField.text isEqualToString:@""]){
        [self presentPopup:@"Empty username!" message:@"Please enter a username."];
    }
    else if([passwordTextField.text isEqualToString:@""]){
        [self presentPopup:@"Empty password!" message:@"Please enter a password."];
    }
    else if(userExist){
        [self presentPopup:@"Username already exists!" message:@"Please enter a different username."];
    }
    else if(emailExist){
        [self presentPopup:@"There is an account already registered with that email." message:@"Please enter a different email."];
    }
    else if([emailTextField.text rangeOfString:@"@ucr.edu"].location != emailTextField.text.length - 8){
        [self presentPopup:@"Invalid email!" message:@"Please register using a valid UCR email."];
    }
    else if(userExist && emailExist){
        [self presentPopup:@"Username and email already exist!" message:@"Please enter a different username and email."];
    }
    else{ // valid registration
        [self writeToDB];
        [self presentPopup:@"Registered!" message:@"Thank you for registering for UCR Craigslist."];
        [self dismissRegistrationAndShowLogin];
    }
}

- (IBAction)backToLoginButton:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
