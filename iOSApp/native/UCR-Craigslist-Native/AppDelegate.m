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
    // Override point for customization after application launch.
    
    NSHTTPCookie *cookie;
    NSHTTPCookieStorage *cookieJar = [NSHTTPCookieStorage sharedHTTPCookieStorage];
    for (cookie in [cookieJar cookies]) {
        NSLog(@"%@", cookie);
    }

    users * user = [[users alloc] init];
    self.validLogin = [user validUser];
    
    [self.window setTintColor:[UIColor whiteColor]];
    
    //set tab bar color
    [[UITabBar appearance] setBackgroundColor:[UIColor colorWithRed:0.13 green:0.13 blue:0.13 alpha:1.0]];
    [[UITabBar appearance] setBarTintColor:[UIColor blackColor]];
    [[UITextField appearance] setTintColor:[UIColor darkGrayColor]];
    [[UITextView appearance] setTintColor:[UIColor darkGrayColor]];
    [[UITableViewCell appearance] setSelectionStyle:UITableViewCellSelectionStyleGray];
    [[UITableView appearance] setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [[UINavigationBar appearance] setBarStyle:UIBarStyleBlack];
    [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];
    [[UITableViewCell appearance] setLayoutMargins:UIEdgeInsetsZero];
    [[UITableViewCell appearance] setSeparatorInset:UIEdgeInsetsZero];
    [[UITableViewCell appearance] setBackgroundColor:[UIColor darkGrayColor]];
    [[UITextField appearance] setClearButtonMode:UITextFieldViewModeAlways];
    
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
    [[NSHTTPCookieStorage sharedHTTPCookieStorage] setCookieAcceptPolicy:NSHTTPCookieAcceptPolicyAlways];
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
