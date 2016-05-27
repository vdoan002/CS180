//
//  dbArrays.h
//  UCR-Craigslist-Native
//
//  Created by Michael Chen on 5/15/16.
//  Copyright © 2016 UCR. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "users.h"

@interface dbArrays : NSObject

@property (nonatomic, strong) NSMutableArray * jsonArray;
@property (nonatomic, strong) NSMutableArray * usersArray;
@property (nonatomic, strong) NSMutableArray * postsArray;
@property (nonatomic, strong) NSMutableArray * reviewsArray;
@property (nonatomic, strong) NSMutableArray * imagesArray;
@property (nonatomic, strong) NSMutableArray * messagesArray;
@property (nonatomic, strong) NSMutableArray * relevantThreadsArray;
@property (nonatomic, strong) NSMutableArray * relevantThreadsArraySender;
@property (nonatomic, strong) NSMutableArray * relevantBooksArray;
@property (nonatomic, strong) NSMutableArray * relevantClothingArray;
@property (nonatomic, strong) NSMutableArray * relevantElectronicsArray;
@property (nonatomic, strong) NSMutableArray * relevantFurnitureArray;
@property (nonatomic, strong) NSMutableArray * relevantHouseholdArray;
@property (nonatomic, strong) NSMutableArray * relevantLeasesArray;
@property (nonatomic, strong) NSMutableArray * relevantMusicArray;
@property (nonatomic, strong) NSMutableArray * relevantPetsArray;
@property (nonatomic, strong) NSMutableArray * relevantServicesArray;
@property (nonatomic, strong) NSMutableArray * relevantTicketsArray;
@property (nonatomic, strong) NSMutableArray * relevantVehiclesArray;
@property (nonatomic, strong) NSMutableArray * relevantOtherArray;

@property (nonatomic, strong) users * user;

@property (nonatomic) BOOL imagesLoaded;
@property (nonatomic) BOOL usersLoaded;
@property (nonatomic) BOOL transition;

+ (dbArrays*) sharedInstance;

@end
