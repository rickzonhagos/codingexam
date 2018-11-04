//
//  TestTableViewCell.m
//  CodingTest
//
//  Created by Rickzon Hagos on 29/10/2018.
//  Copyright © 2018 Rickzon. All rights reserved.
//

#import "TestTableViewCell.h"

@implementation TestTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    

    
    
}
- (int ) getSmallPostive : (NSMutableArray *) A{
    int max = [[A valueForKeyPath:@"@max.self"] intValue];
    int min = [[A valueForKeyPath:@"@min.self"] intValue];
    int index = 0;
    for(NSNumber *a in A){
        int result = 0;
        
        if (max > 0) {
            result = ([a intValue]  - 1);
            if (result == 0) continue;
            if (![A containsObject:@(result)]) {
                return result;
            }
        }else{
            result = ([a intValue]  + 1);
            if (result == 0) continue;
            if (![A containsObject:@(result)]) {
                return result;
            }
        }
        index++;
    }
    
    if (max > 0) {
        return max+ 1;
    }
    return 0;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
/*
 
 Create an iOS app which lists the venues near you.
 
 Use four square REST api 'venues/search' to fetch and list the venues near your location. In the first screen provide a list of venues. Display the name and distance of the venue from your location. When the user selects a venue, open a detailed screen to display the name and address of a venue.
 
 Preferable: Use storyboards and swift
 
 What we are interested to know
 1. Ability to provide a working solution
 2. Standard coding practices and design approaches used to solve the problem
 
 Share the codebase via github.

 */
@end
