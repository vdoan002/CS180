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
@synthesize usersArray, postsArray, reviewsArray, imagesArray, messagesArray, jsonArray, imagesLoaded, relevantThreadsArray, relevantThreadsArraySender, usersLoaded, transition, relevantBooksArray, relevantClothingArray, relevantPetsArray, relevantMusicArray, relevantOtherArray, relevantLeasesArray, relevantTicketsArray, relevantServicesArray, relevantVehiclesArray, relevantFurnitureArray, relevantHouseholdArray, relevantElectronicsArray, user;

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
        myInstance.messagesArray = [NSMutableArray arrayWithObject:@""];
        
        myInstance.relevantBooksArray = [NSMutableArray arrayWithObject:@""];
        myInstance.relevantClothingArray = [NSMutableArray arrayWithObject:@""];
        myInstance.relevantElectronicsArray = [NSMutableArray arrayWithObject:@""];
        myInstance.relevantFurnitureArray = [NSMutableArray arrayWithObject:@""];
        myInstance.relevantHouseholdArray = [NSMutableArray arrayWithObject:@""];
        myInstance.relevantLeasesArray = [NSMutableArray arrayWithObject:@""];
        myInstance.relevantMusicArray = [NSMutableArray arrayWithObject:@""];
        myInstance.relevantPetsArray = [NSMutableArray arrayWithObject:@""];
        myInstance.relevantServicesArray = [NSMutableArray arrayWithObject:@""];
        myInstance.relevantTicketsArray = [NSMutableArray arrayWithObject:@""];
        myInstance.relevantVehiclesArray = [NSMutableArray arrayWithObject:@""];
        myInstance.relevantOtherArray = [NSMutableArray arrayWithObject:@""];
        myInstance.relevantThreadsArray = [NSMutableArray arrayWithObject:@""];
        myInstance.relevantThreadsArraySender = [NSMutableArray arrayWithObject:@""];
        
        myInstance.imagesLoaded = false;
        myInstance.usersLoaded = false;
        myInstance.transition = false;
        
        myInstance.user = [[users alloc] init];
        myInstance.user.userID = @"";
        myInstance.user.email = @"";
        myInstance.user.username = @"";
        myInstance.user.password = @"";
        myInstance.user.num_reviews = @"";
    }
    return myInstance;
}

@end
