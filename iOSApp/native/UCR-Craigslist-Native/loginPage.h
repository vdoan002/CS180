//
//  loginPage.h
//  UCR-Craigslist-Native
//
//  Created by Michael Chen on 5/14/16.
//  Copyright © 2016 UCR. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "users.h"

@interface loginPage : UIViewController<UITextFieldDelegate> {
}

@property (strong, nonatomic) IBOutlet UITextField *userTF;
@property (strong, nonatomic) IBOutlet UITextField *passwdTF;
@property (strong, nonatomic) IBOutlet UIButton *loginUIButton;
@property (strong, nonatomic) IBOutlet UIButton *registerUIButton;

- (IBAction)loginButton:(id)sender;
- (IBAction)registerButton:(id)sender;

//@property (nonatomic, weak) id <LoginViewProtocl> delegate;
//@property (nonatomic, retain) LoginViewController * loginView;

@property (nonatomic, retain) IBOutlet UILabel *titleLabel;
@property (nonatomic) BOOL matched;
@property(nonatomic, strong) users * user;

#pragma mark - 
#pragma mark Class Methods

- (void) retrieveUsers;
- (void) retrievePosts;
- (void) retrieveReviews;
- (void) retrieveImages;
- (void) retrieveChat;
- (void) retrieveMessages;

-(void)getUser:(id)_user;

@end
