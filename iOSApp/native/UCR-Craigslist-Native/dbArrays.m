//
//  dbArrays.m
//  UCR-Craigslist-Native
//
//  Created by Michael Chen on 5/15/16.
//  Copyright © 2016 UCR. All rights reserved.
//

#import "dbArrays.h"
#import "users.h"

static NSString * _loggedIn;

@implementation dbArrays
@synthesize usersArray, postsArray, reviewsArray, imagesArray, chatArray, messagesArray, jsonArray, imagesLoaded;

// singleton: http://stackoverflow.com/questions/10649370/simple-passing-of-variables-between-classes-in-xcode
+ (dbArrays*) sharedInstance {
    static dbArrays *myInstance = nil;
    if (myInstance == nil) {
        myInstance = [[[self class] alloc] init];
        myInstance.jsonArray = [NSMutableArray arrayWithObject:@""];
        myInstance.usersArray = [NSMutableArray arrayWithObject:@""];
        myInstance.postsArray = [NSMutableArray arrayWithObject:@""];
        myInstance.reviewsArray = [NSMutableArray arrayWithObject:@""];
        myInstance.imagesArray = [NSMutableArray arrayWithObject:@""];
        myInstance.chatArray = [NSMutableArray arrayWithObject:@""];
        myInstance.messagesArray = [NSMutableArray arrayWithObject:@""];
        myInstance.imagesLoaded = false;
    }
    return myInstance;
}

@end
