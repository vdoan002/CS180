//
//  loginPage.m
//  UCR-Craigslist-Native
//
//  Created by Michael Chen on 5/14/16.
//  Copyright © 2016 UCR. All rights reserved.
//

#import "AppDelegate.h"
#import "dbArrays.h"
#import "loginPage.h"
#import "users.h"
#import "posts.h"
#import "reviews.h"
#import "images.h"
#import "messages.h"
#import "registerPage.h"
#import "PostsTableViewController.h"

#define getUsersURL @"http://practicemakesperfect.co.nf/getUsers.php"
#define getPostsURL @"http://practicemakesperfect.co.nf/getPosts.php"
#define getReviewsURL @"http://practicemakesperfect.co.nf/getReviews.php"
#define getImagesURL @"http://practicemakesperfect.co.nf/getImagesURL.php"
#define getChatURL @"http://practicemakesperfect.co.nf/getChat.php"
#define getMessagesURL @"http://practicemakesperfect.co.nf/getMessages.php"

@interface loginPage ()

@end

@implementation loginPage
@synthesize  titleLabel, loginUIButton, user, userTF, passwdTF, matched;

- (void)viewDidLoad {
    [super viewDidLoad];
  
    [self setupData];
    [self setupUI];
    [self setupKeyboard];
}

- (void)setupData{
    [self retrieveUsers];
    userTF.delegate = self;
    passwdTF.delegate = self;
}

- (void)setupUI{
    //set placeholder text color
    UIColor *color = [UIColor lightGrayColor];
    userTF.attributedPlaceholder =[[NSAttributedString alloc] initWithString:@"enter a username" attributes:@{NSForegroundColorAttributeName:color}];
    passwdTF.attributedPlaceholder =[[NSAttributedString alloc] initWithString:@"enter a password" attributes:@{NSForegroundColorAttributeName:color}];
}

- (void) viewWillAppear:(BOOL)animated {
    if(![dbArrays sharedInstance].usersLoaded){
        [self retrieveUsers];
    }
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    if (textField == userTF) {
        [textField resignFirstResponder];
        [passwdTF becomeFirstResponder];
    }
    else if (textField == passwdTF) {
        [textField resignFirstResponder];
        [loginUIButton sendActionsForControlEvents:UIControlEventTouchUpInside];
    }
    return YES;
}

-(void)dismissKeyboard { //http://stackoverflow.com/a/5711504
    [userTF resignFirstResponder];
    [passwdTF resignFirstResponder];
}

- (void)setupKeyboard{
    //keyboard dismiss: http://stackoverflow.com/a/5711504
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                          action:@selector(dismissKeyboard)];
    [self.view addGestureRecognizer:tap];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    loginPage * loginPageObj = [[loginPage alloc] init];
    loginPageObj.userTF = userTF;
    loginPageObj.passwdTF = passwdTF;
    if([[segue identifier] isEqualToString:@"registerSegue"]){
        [[segue destinationViewController] getLoginPageObj:loginPageObj]; //pass on filled in fields to registration page
    }
}

#pragma mark -
#pragma mark Class Methods
    
- (void)retrieveUsers { //referenced from: http://youtu.be/nqnohLXQRW4 - database linking
    NSLog(@"RETRIEVEING USERS!!!!!!");
    NSURL * url = [NSURL URLWithString:getUsersURL];
    NSData * data = [NSData dataWithContentsOfURL:url];
    
    [dbArrays sharedInstance].jsonArray = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
    [dbArrays sharedInstance].usersArray = [[NSMutableArray alloc] init];
    
    //NSLog(@"retrieveUsers jsonArray.count: %lu", (unsigned long)[dbArrays sharedInstance].jsonArray.count);
    for(int i = 0; i < [dbArrays sharedInstance].jsonArray.count; i++){
        NSString * userID = [[[dbArrays sharedInstance].jsonArray objectAtIndex:i] objectForKey:@"id"];
        NSString * email = [[[dbArrays sharedInstance].jsonArray objectAtIndex:i] objectForKey:@"email"];
        NSString * username = [[[dbArrays sharedInstance].jsonArray objectAtIndex:i] objectForKey:@"username"];
        NSString * password = [[[dbArrays sharedInstance].jsonArray objectAtIndex:i] objectForKey:@"password"];
        NSString * num_reviews = [[[dbArrays sharedInstance].jsonArray objectAtIndex:i] objectForKey:@"num_reviews"];
        NSString * total_rating = [[[dbArrays sharedInstance].jsonArray objectAtIndex:i] objectForKey:@"total_rating"];
        BOOL loggedIn = false;
        
        [[dbArrays sharedInstance].usersArray addObject:[[users alloc]initWithUsers:userID email:email username:username password:password num_reviews:num_reviews total_rating:total_rating loggedIn:loggedIn]];
    }
    [dbArrays sharedInstance].usersLoaded = true;
}

- (void) retrievePosts{
    NSURL * url = [NSURL URLWithString:getPostsURL];
    NSData * data = [NSData dataWithContentsOfURL:url];
    
    [dbArrays sharedInstance].jsonArray = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
    [dbArrays sharedInstance].postsArray = [[NSMutableArray alloc] init];
    
    //NSLog(@"retrievePosts jsonArray.count: %lu", (unsigned long)[dbArrays sharedInstance].jsonArray.count);
    for(int i = 0; i < [dbArrays sharedInstance].jsonArray.count; i++){
        NSString * post_id = [[[dbArrays sharedInstance].jsonArray objectAtIndex:i] objectForKey:@"post_id"];
        NSString * post_title = [[[dbArrays sharedInstance].jsonArray objectAtIndex:i] objectForKey:@"post_title"];
        NSString * post_username = [[[dbArrays sharedInstance].jsonArray objectAtIndex:i] objectForKey:@"post_username"];
        NSString * post_price = [[[dbArrays sharedInstance].jsonArray objectAtIndex:i] objectForKey:@"post_price"];
        NSString * post_category = [[[dbArrays sharedInstance].jsonArray objectAtIndex:i] objectForKey:@"post_category"];
        NSString * post_description = [[[dbArrays sharedInstance].jsonArray objectAtIndex:i] objectForKey:@"post_description"];
        NSString * post_date = [[[dbArrays sharedInstance].jsonArray objectAtIndex:i] objectForKey:@"post_date"];
        NSString * post_time = [[[dbArrays sharedInstance].jsonArray objectAtIndex:i] objectForKey:@"post_time"];
        NSString * post_photos = [[[dbArrays sharedInstance].jsonArray objectAtIndex:i] objectForKey:@"post_photos"];
        NSString * post_photo_id = [[[dbArrays sharedInstance].jsonArray objectAtIndex:i] objectForKey:@"post_photo_id"];
        
        [[dbArrays sharedInstance].postsArray addObject:[[posts alloc]initWithPosts:post_id post_title:post_title post_username:post_username post_price:post_price post_category:post_category post_description:post_description post_date:post_date post_time:post_time post_photos:post_photos post_photo_id:post_photo_id]];
    }
}

- (void) retrieveReviews {
    NSURL * url = [NSURL URLWithString:getReviewsURL];
    NSData * data = [NSData dataWithContentsOfURL:url];
    
    [dbArrays sharedInstance].jsonArray = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
    [dbArrays sharedInstance].reviewsArray = [[NSMutableArray alloc] init];
    //NSLog(@"retrieveReviews jsonArray.count: %lu", (unsigned long)[dbArrays sharedInstance].jsonArray.count);
    for(int i = 0; i < [dbArrays sharedInstance].jsonArray.count; i++){
        NSString * review_id = [[[dbArrays sharedInstance].jsonArray objectAtIndex:i] objectForKey:@"review_id"];
        NSString * user_id = [[[dbArrays sharedInstance].jsonArray objectAtIndex:i] objectForKey:@"user_id"];
        NSString * review = [[[dbArrays sharedInstance].jsonArray objectAtIndex:i] objectForKey:@"review"];
        NSString * reviewer = [[[dbArrays sharedInstance].jsonArray objectAtIndex:i] objectForKey:@"reviewer"];
        NSString * rating = [[[dbArrays sharedInstance].jsonArray objectAtIndex:i] objectForKey:@"rating"];

        [[dbArrays sharedInstance].reviewsArray addObject:[[reviews alloc]initWithReviews:review_id user_id:user_id review:review reviewer:reviewer rating:rating]];
    }
}

- (void)retrieveImages{
    NSURL * url = [NSURL URLWithString:getImagesURL];
    NSData * data = [NSData dataWithContentsOfURL:url];
    
    [dbArrays sharedInstance].jsonArray = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
    [dbArrays sharedInstance].imagesArray = [[NSMutableArray alloc] init];
    //NSLog(@"retrieveImages jsonArray.count: %lu", (unsigned long)[dbArrays sharedInstance].jsonArray.count);
    for(int i = 0; i < [dbArrays sharedInstance].jsonArray.count; i++){
        NSString * image_id = [[[dbArrays sharedInstance].jsonArray objectAtIndex:i] objectForKey:@"image_id"];
        NSString * image_post_id = [[[dbArrays sharedInstance].jsonArray objectAtIndex:i] objectForKey:@"image_post_id"];
        NSString * image_name = [[[dbArrays sharedInstance].jsonArray objectAtIndex:i] objectForKey:@"image_name"];
        NSString * image_pic = [[[dbArrays sharedInstance].jsonArray objectAtIndex:i] objectForKey:@"image_pic"];
        
        NSLog(@"image_pic: %@", image_pic);
        
        NSData * image_data = [[NSData alloc] initWithBase64EncodedString:image_pic options:0];
        
        [[dbArrays sharedInstance].imagesArray addObject:[[images alloc]initWithImages:image_id image_post_id:image_post_id image_name:image_name image_pic:image_pic image_data:image_data]];
    }
    
    [dbArrays sharedInstance].imagesLoaded = true;
}

- (void) retrieveMessages{
    //NSLog(@"RETRIEVING MESSAGES!!!!!!!!!!!!!!");
    NSURL * url = [NSURL URLWithString:getMessagesURL];
    NSData * data = [NSData dataWithContentsOfURL:url];
    
    [dbArrays sharedInstance].jsonArray = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
    [dbArrays sharedInstance].messagesArray = [[NSMutableArray alloc] init];
    //NSLog(@"retrieveMessages jsonArray.count: %lu", (unsigned long)[dbArrays sharedInstance].jsonArray.count);
    for(int i = 0; i < [dbArrays sharedInstance].jsonArray.count; i++) {
        NSString * message_id = [[[dbArrays sharedInstance].jsonArray objectAtIndex:i] objectForKey:@"message_id"];
        NSString * message_sender = [[[dbArrays sharedInstance].jsonArray objectAtIndex:i] objectForKey:@"message_sender"];
        NSString * message_receiver = [[[dbArrays sharedInstance].jsonArray objectAtIndex:i] objectForKey:@"message_receiver"];
        NSString * message_content = [[[dbArrays sharedInstance].jsonArray objectAtIndex:i] objectForKey:@"message_content"];
        NSString * message_timesent = [[[dbArrays sharedInstance].jsonArray objectAtIndex:i] objectForKey:@"message_timesent"];
        NSString * message_date = [[[dbArrays sharedInstance].jsonArray objectAtIndex:i] objectForKey:@"message_date"];
        NSString * message_seen = [[[dbArrays sharedInstance].jsonArray objectAtIndex:i] objectForKey:@"message_seen"];
        BOOL message_threadLoaded = false;
        
        [[dbArrays sharedInstance].messagesArray addObject:[[messages alloc]initWithMessages:message_id message_sender:message_sender message_receiver:message_receiver message_content:message_content message_timesent:message_timesent message_date:message_date message_seen:message_seen message_threadLoaded:message_threadLoaded]];
    }
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

- (void)getUser:(id)_user{
    user = _user;
}

- (IBAction)loginButton:(id)sender {
    [[self view] endEditing:YES]; 
    //trying to match inputted text with database
    matched = false;
    //NSLog(@"usersArray.count: %lu", (unsigned long)[dbArrays sharedInstance].usersArray.count);
    for(int i = 0; i < [dbArrays sharedInstance].usersArray.count && !matched; i++){
        
        if([userTF.text isEqualToString:[[[dbArrays sharedInstance].usersArray objectAtIndex:i] username]] && [passwdTF.text isEqualToString:[[[dbArrays sharedInstance].usersArray objectAtIndex:i] password]]){
            user = [[dbArrays sharedInstance].usersArray objectAtIndex:i];
            user.loggedIn = true;
            matched = true;
        }
    }
    
    if(!matched || [userTF.text isEqualToString:@""] || [passwdTF.text isEqualToString:@""]){
        [self presentPopup:@"Invalid login!" message:@"Please enter a valid username/password combination."];
    }
    else if(matched){
        UIAlertController *alert = [UIAlertController
                                    alertControllerWithTitle:[NSString stringWithFormat:@"Welcome, %@", userTF.text]
                                    message:@"to UCR Craigslist!"
                                    preferredStyle:UIAlertControllerStyleAlert];
        
        //button creation and function (handler)
        UIAlertAction* actionOk = [UIAlertAction
                                   actionWithTitle:@"OK"
                                   style:UIAlertActionStyleDefault
                                   handler:^(UIAlertAction * actionOK) {
                                       UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
                                       UITabBarController * tabView = [storyboard instantiateViewControllerWithIdentifier:@"tabView"];
                                       [self presentViewController:tabView animated:YES completion:nil];
                                   }];
        
        [alert addAction:actionOk];
        
        [self presentViewController:alert animated:YES completion:nil];
        
        //http://stackoverflow.com/a/21877460
        AppDelegate *appDelg = (AppDelegate*)[[UIApplication sharedApplication] delegate];
        appDelg.validLogin = 1;
    }
}

@end
