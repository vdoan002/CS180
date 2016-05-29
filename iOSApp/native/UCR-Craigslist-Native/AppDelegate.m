//
//  AppDelegate.m
//  UCR-Craigslist-Native
//
//  Created by Michael Chen on 4/24/16.
//  Copyright © 2016 UCR. All rights reserved.
//

#import "AppDelegate.h"
#import "users.h"
#import "loginPage.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    //set tint color to white
    [self.window setTintColor:[UIColor whiteColor]];
    
    //universal appearance config
    [[UITabBar appearance] setBackgroundColor:[UIColor colorWithRed:0.04 green:0.04 blue:0.04 alpha:1.0]];
    [[UITabBar appearance] setBarTintColor:[UIColor colorWithRed:0.04 green:0.04 blue:0.04 alpha:1.0]];
    [[UITextField appearance] setTintColor:[UIColor colorWithRed:0.29 green:0.53 blue:0.91 alpha:1.0]];
    //[[UITextView appearance] setTintColor:[UIColor darkGrayColor]];
    //[[UITextView appearance] setTextColor:[UIColor whiteColor]];
    [[UITableViewCell appearance] setSelectionStyle:UITableViewCellSelectionStyleGray];
    [[UITableView appearance] setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [[UINavigationBar appearance] setBarStyle:UIBarStyleBlack];
    [[UINavigationBar appearance] setBarTintColor:[UIColor blackColor]];
    [[UITableViewCell appearance] setLayoutMargins:UIEdgeInsetsZero];
    [[UITableViewCell appearance] setSeparatorInset:UIEdgeInsetsZero];
    [[UITableViewCell appearance] setBackgroundColor:[UIColor darkGrayColor]];
    [[UITextField appearance] setClearButtonMode:UITextFieldViewModeAlways];
    [[UISearchBar appearance] setBarStyle:UIBarStyleBlackTranslucent];
    //[[UISearchBar appearance] setBackgroundColor:[UIColor colorWithRed:0.13 green:0.13 blue:0.13 alpha:1.0]];
    //[[UISearchBar appearance] setPlaceholder:@"search for a keyword"];
    [[UITextField appearanceWhenContainedInInstancesOfClasses:@[[UISearchBar class]]] setDefaultTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
    [[UITextField appearanceWhenContainedInInstancesOfClasses:@[[UISearchBar class]]] setAttributedPlaceholder:[[NSAttributedString alloc] initWithString:@"search for a keyword"]];
    [[UITextField appearanceWhenContainedInInstancesOfClasses:@[[UISearchBar class]]] setContentVerticalAlignment:UIControlContentVerticalAlignmentBottom];
    [[UIBarButtonItem appearanceWhenContainedInInstancesOfClasses:@[[UIToolbar class]]] setTintColor:[UIColor cyanColor]];
    [[UITabBar appearance] setBackgroundImage:[[UIImage alloc] init]];
    [[UITabBar appearance] setShadowImage:[[UIImage alloc] init]];
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
