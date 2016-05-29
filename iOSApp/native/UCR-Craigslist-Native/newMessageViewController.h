//
//  newMessageViewController.h
//  UCR-Craigslist-Native
//
//  Created by Michael Chen on 5/25/16.
//  Copyright © 2016 UCR. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface newMessageViewController : UIViewController<UITextViewDelegate, UIPickerViewDelegate, UIPickerViewDataSource>

@property (strong, nonatomic) IBOutlet UIPickerView *usersPicker;
@property (strong, nonatomic) IBOutlet UITextView *msgView;
@property (strong, nonatomic) IBOutlet UINavigationBar *navBar;

@property (strong, nonatomic) NSMutableArray * friends;
@property (strong, nonatomic) NSString * xingFriend;

- (void)getFriends:(id)_friends;

- (IBAction)sendButton:(id)sender;
- (IBAction)cancelButton:(id)sender;

@end
