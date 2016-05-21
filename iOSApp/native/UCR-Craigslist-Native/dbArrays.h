//
//  dbArrays.h
//  UCR-Craigslist-Native
//
//  Created by Michael Chen on 5/15/16.
//  Copyright © 2016 UCR. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface dbArrays : NSObject

@property (nonatomic, strong) NSMutableArray * jsonArray;
@property (nonatomic, strong) NSMutableArray * usersArray;
@property (nonatomic, strong) NSMutableArray * postsArray;
@property (nonatomic, strong) NSMutableArray * reviewsArray;
@property (nonatomic, strong) NSMutableArray * imagesArray;
@property (nonatomic, strong) NSMutableArray * chatArray;
@property (nonatomic, strong) NSMutableArray * messagesArray;
@property (nonatomic) BOOL imagesLoaded;
+ (dbArrays*) sharedInstance;

@end
