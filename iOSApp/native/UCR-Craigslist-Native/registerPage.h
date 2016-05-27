//
//  registerPage.h
//  UCR-Craigslist-Native
//
//  Created by Michael Chen on 5/24/16.
//  Copyright © 2016 UCR. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "loginPage.h"

@interface registerPage : UIViewController<UITextFieldDelegate>

@property (strong, nonatomic) IBOutlet UITextField *userTextField;
@property (strong, nonatomic) IBOutlet UITextField *passwordTextField;
@property (strong, nonatomic) IBOutlet UITextField *emailTextField;
@property (strong, nonatomic) IBOutlet UIButton *registerUIButton;

@property (strong, nonatomic) loginPage * loginPageObj;

- (void)presentPopup:(NSString *)titleText message: (NSString *)message;
- (void)getLoginPageObj:(id)_loginPageObj;

- (IBAction)registerButton:(id)sender;
- (IBAction)backToLoginButton:(id)sender;

@end
