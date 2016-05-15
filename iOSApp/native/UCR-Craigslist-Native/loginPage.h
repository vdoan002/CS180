//
//  loginPage.h
//  UCR-Craigslist-Native
//
//  Created by Michael Chen on 5/14/16.
//  Copyright © 2016 UCR. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LoginViewController.h"

@protocol <#protocol name#> <NSObject>

<#methods#>

@end

@interface loginPage : UIViewController{
    
    IBOutlet UITextField *userTF;
    IBOutlet UITextField *passwdTF;
}

- (IBAction)loginButton:(id)sender;

@property (nonatomic, strong) NSMutableArray * jsonArray;
@property (nonatomic, strong) NSMutableArray * loginArray;
@

#pragma mark - 
#pragma mark Class Methods
- (void) retrieveData;

@end
