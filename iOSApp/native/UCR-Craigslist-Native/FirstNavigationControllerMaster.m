//
//  FirstNavigationControllerMaster.m
//  UCR-Craigslist-Native
//
//  Created by Michael Chen on 5/28/16.
//  Copyright © 2016 UCR. All rights reserved.
//

#import "FirstNavigationControllerMaster.h"

@interface FirstNavigationControllerMaster ()

@end

@implementation FirstNavigationControllerMaster

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.navigationController.navigationBar setTintColor:[UIColor whiteColor]];
    
    //fonts available https://coderwall.com/p/gdpyjq/how-to-list-all-available-fonts-in-xcode-by-family-name
    /*NSArray *families = [[UIFont familyNames] sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)];
    NSMutableString *fonts = [NSMutableString string];
    for (int i = 0; i < [families count]; i++) {
        [fonts appendString:[NSString stringWithFormat:@"\n%@:\n", families[i]]];
        NSArray *names = [UIFont fontNamesForFamilyName:families[i]];
        for (int j = 0; j < [names count]; j++) {
            [fonts appendString:[NSString stringWithFormat:@"\t%@\n", names[j]]];
        }
    }
    NSLog(@"%@", fonts);*/
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

@end
