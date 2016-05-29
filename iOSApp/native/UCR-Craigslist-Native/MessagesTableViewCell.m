//
//  MessagesTableViewCell.m
//  UCR-Craigslist-Native
//
//  Created by Michael Chen on 5/28/16.
//  Copyright © 2016 UCR. All rights reserved.
//

#import "MessagesTableViewCell.h"

@implementation MessagesTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    [self adjustAlignment];
}

- (void)adjustAlignment{
    //NSLog(@"detailTextLabel.text: %@", self.detailTextLabel.text);
    if([self.detailTextLabel.text containsString:@"you @"]){
        //right align
        self.textLabel.textAlignment = NSTextAlignmentRight;
        self.detailTextLabel.textAlignment = NSTextAlignmentRight;
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
