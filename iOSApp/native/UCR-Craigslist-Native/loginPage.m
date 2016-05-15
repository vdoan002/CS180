//
//  loginPage.m
//  UCR-Craigslist-Native
//
//  Created by Michael Chen on 5/14/16.
//  Copyright © 2016 UCR. All rights reserved.
//

#import "loginPage.h"
#import "users.h"

#define getDataURL @"http://practicemakesperfect.co.nf/service.php"

@interface loginPage ()

@end

@implementation loginPage
@synthesize loginArray, jsonArray;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self retrieveData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark -
#pragma mark Class Methods
    
- (void)retrieveData {
    NSURL * url = [NSURL URLWithString:getDataURL];
    NSData * data = [NSData dataWithContentsOfURL:url];
    
    jsonArray = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
    
    loginArray = [[NSMutableArray alloc] init];
    
    NSLog(@"jsonArray.count: %lu", (unsigned long)jsonArray.count);
    for(int i = 0; i < jsonArray.count; i++){
        NSString * userID = [[jsonArray objectAtIndex:i] objectForKey:@"userID"];
        NSString * email = [[jsonArray objectAtIndex:i] objectForKey:@"email"];
        NSString * username = [[jsonArray objectAtIndex:i] objectForKey:@"username"];
        NSString * password = [[jsonArray objectAtIndex:i] objectForKey:@"password"];
        NSString * num_reviews = [[jsonArray objectAtIndex:i] objectForKey:@"num_reviews"];
        NSString * total_rating = [[jsonArray objectAtIndex:i] objectForKey:@"total_rating"];
        
        [loginArray addObject:[[users alloc]initWithUsers:userID email:email username:username password:password num_reviews:num_reviews total_rating:total_rating]];
    }
}

- (IBAction)loginButton:(id)sender {
    
    //trying to match inputted text with database
    BOOL matched = 0;
    NSLog(@"loginArray.count: %lu", (unsigned long)loginArray.count);
    for(int i = 0; i < loginArray.count && !matched; i++){
        
        /*NSLog(@"userTF.text: %@", userTF.text);
        NSLog(@"passwdTF.text: %@", passwdTF.text);
        NSLog(@"loginArray.username: %@", [[loginArray objectAtIndex:i] username]);
        NSLog(@"loginArray.password: %@", [[loginArray objectAtIndex:i] password]);*/
        
        if([userTF.text isEqualToString:[[loginArray objectAtIndex:i] username]] && [passwdTF.text isEqualToString:[[loginArray objectAtIndex:i] password]]){
           
             UIAlertController *alert = [UIAlertController
                                              alertControllerWithTitle:@"Valid login!"
                                              message:@"Proceed to tab view."
                                              preferredStyle:UIAlertControllerStyleAlert];
            
            [self presentViewController:alert animated:YES completion:nil];
            
            //button creation and function (handler)
            UIAlertAction* actionOk = [UIAlertAction
                                       actionWithTitle:@"OK"
                                       style:UIAlertActionStyleDefault
                                       handler:^(UIAlertAction * action) {}];
            
            [alert addAction:actionOk];
            matched = 1;
        }
    }
    
    if(!matched){
        UIAlertController *alert = [UIAlertController
                                          alertControllerWithTitle:@"Invalid login!"
                                          message:@"Please enter a correct username/password combination."
                                          preferredStyle:UIAlertControllerStyleAlert];
        //button creation and function (handler)
        UIAlertAction* actionOk = [UIAlertAction
                                   actionWithTitle:@"OK"
                                   style:UIAlertActionStyleDefault
                                   handler:^(UIAlertAction * action) {}];
        
        [alert addAction:actionOk];

        [self presentViewController:alert animated:YES completion:nil];
    }
    
}
         
@end
