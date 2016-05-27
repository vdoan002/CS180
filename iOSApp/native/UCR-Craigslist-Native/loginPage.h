//
//  loginPage.h
//  UCR-Craigslist-Native
//
//  Created by Michael Chen on 5/14/16.
//  Copyright © 2016 UCR. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "users.h"

@interface loginPage : UIViewController<UITextFieldDelegate>

@property (strong, nonatomic) IBOutlet UITextField *userTF;
@property (strong, nonatomic) IBOutlet UITextField *passwdTF;
@property (strong, nonatomic) IBOutlet UIButton *loginUIButton;
@property (retain, nonatomic) IBOutlet UILabel *titleLabel;
@property (strong, nonatomic) users * user;
@property (nonatomic) BOOL matched;

#pragma mark -
#pragma mark Class Methods

- (void) retrieveUsers;
- (void) retrievePosts;
- (void) retrieveReviews;
- (void) retrieveImages;
- (void) retrieveMessages;

- (void)getUser:(id)_user;

- (IBAction)loginButton:(id)sender;

@end
