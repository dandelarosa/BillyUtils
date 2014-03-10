//
//  WatchmakerSolution.h
//  BillyUtils
//
//  Created by Dan Dela Rosa on 3/10/14.
//  Copyright (c) 2014 MRD Engineering. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WatchmakerSolution : NSObject

@property (nonatomic, assign) NSInteger numberOfSmallGearsUsed;
@property (nonatomic, assign) NSInteger numberOfMediumGearsUsed;
@property (nonatomic, assign) NSInteger numberOfLargeGearsUsed;

@property (nonatomic, assign) BOOL isSmallGearNegative;
@property (nonatomic, assign) BOOL isMediumGearNegative;
@property (nonatomic, assign) BOOL isLargeGearNegative;

@end
