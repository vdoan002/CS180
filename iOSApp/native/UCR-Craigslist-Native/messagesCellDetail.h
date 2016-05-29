//
//  messagesCellDetail.h
//  UCR-Craigslist-Native
//
//  Created by Michael Chen on 5/20/16.
//  Copyright © 2016 UCR. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "messages.h"
#import "loginPage.h"

@interface messagesCellDetail : UITableViewController<UITextFieldDelegate>{
}

@property (strong, nonatomic) IBOutlet UITextField * num_messages_label;
@property (strong, nonatomic) IBOutlet UINavigationItem *navBarItem;
@property (strong, nonatomic) IBOutlet UIBarButtonItem *barButtonItem;
@property (strong, nonatomic) IBOutlet UIBarButtonItem *sendButtonItem;

@property (strong, nonatomic) UITextView * composeField;
@property (strong, nonatomic) NSMutableArray * relevantMessagesArray;

@property (strong, nonatomic) messages * message;
@property (strong, nonatomic) loginPage * loginPageObj;

#pragma mark -
#pragma mark Methods

-(void)getMessages:(id)_message;
-(void)getRelevantMessages;
-(void)writeToDB;
-(void)refreshAll;

- (IBAction)sendButton:(id)sender;
- (IBAction)refreshButton:(id)sender;

@end
