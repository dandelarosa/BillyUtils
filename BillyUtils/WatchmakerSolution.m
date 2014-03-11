//
//  WatchmakerSolution.m
//  BillyUtils
//
//  Created by Dan Dela Rosa on 3/10/14.
//  Copyright (c) 2014 MRD Engineering. All rights reserved.
//

#import "WatchmakerSolution.h"

@implementation WatchmakerSolution

- (NSInteger)totalGearsUsed
{
    return self.numberOfSmallGearsUsed + self.numberOfMediumGearsUsed + self.numberOfLargeGearsUsed;
}

@end
