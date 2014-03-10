//
//  WatchmakerViewController.m
//  BillyUtils
//
//  Created by Dan Dela Rosa on 3/9/14.
//  Copyright (c) 2014 MRD Engineering. All rights reserved.
//

#import "WatchmakerViewController.h"

@interface WatchmakerViewController ()

@property (weak) IBOutlet NSTextField *smallGearwheelValueTextField;
@property (weak) IBOutlet NSTextField *mediumGearwheelValueTextField;
@property (weak) IBOutlet NSTextField *largeGearwheelValueTextField;
@property (weak) IBOutlet NSTextField *gearingRequiredTextField;

@end

@implementation WatchmakerViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Initialization code here.
    }
    return self;
}

- (IBAction)solveButtonPressed:(id)sender
{
    NSInteger smallGearwheelValue = self.smallGearwheelValueTextField.integerValue;
    NSInteger mediumGearwheelValue = self.mediumGearwheelValueTextField.integerValue;
    NSInteger largeGearwheelValue = self.largeGearwheelValueTextField.integerValue;
    NSInteger gearingRequired = self.gearingRequiredTextField.integerValue;
    
    for (int comb = 0; comb < 7; comb++) {
        BOOL isSmallGearNegative;
        BOOL isMediumGearNegative;
        BOOL isLargeGearNegative;
        
        switch (comb) {
            case 0:
                isSmallGearNegative = NO;
                isMediumGearNegative = NO;
                isLargeGearNegative = NO;
                break;
                
            case 1:
                isSmallGearNegative = NO;
                isMediumGearNegative = NO;
                isLargeGearNegative = YES;
                break;
                
            case 2:
                isSmallGearNegative = NO;
                isMediumGearNegative = YES;
                isLargeGearNegative = NO;
                break;
                
            case 3:
                isSmallGearNegative = NO;
                isMediumGearNegative = YES;
                isLargeGearNegative = YES;
                break;
                
            case 4:
                isSmallGearNegative = YES;
                isMediumGearNegative = NO;
                isLargeGearNegative = NO;
                break;
                
            case 5:
                isSmallGearNegative = YES;
                isMediumGearNegative = NO;
                isLargeGearNegative = YES;
                break;
                
            case 6:
                isSmallGearNegative = YES;
                isMediumGearNegative = YES;
                isLargeGearNegative = NO;
                break;
                // No need for seventh case, that's all negative numbers
            default:
                break;
        }
        
        for (NSInteger numberOfLargeGearsUsed = 0; numberOfLargeGearsUsed < 11; numberOfLargeGearsUsed++) {
            for (NSInteger numberOfMediumGearsUsed = 0; numberOfLargeGearsUsed + numberOfMediumGearsUsed < 11; numberOfMediumGearsUsed++) {
                for (NSInteger numberOfSmallGearsUsed = 0; numberOfLargeGearsUsed + numberOfMediumGearsUsed + numberOfSmallGearsUsed < 11; numberOfSmallGearsUsed++) {
                    NSInteger large = (isLargeGearNegative ? -1 : 1) * numberOfLargeGearsUsed * largeGearwheelValue;
                    NSInteger medium = (isMediumGearNegative ? -1 : 1) * numberOfMediumGearsUsed * mediumGearwheelValue;
                    NSInteger small = (isSmallGearNegative ? -1 : 1) * numberOfSmallGearsUsed * smallGearwheelValue;
                    
                    if (large + medium + small == gearingRequired) {
                        NSLog(@"Small: %ld Medium: %ld Large: %ld Total: %ld",
                              (isSmallGearNegative ? -1 : 1) * numberOfSmallGearsUsed,
                              (isMediumGearNegative ? -1 : 1) * numberOfMediumGearsUsed,
                              (isLargeGearNegative ? -1 : 1) * numberOfLargeGearsUsed,
                              numberOfSmallGearsUsed + numberOfMediumGearsUsed + numberOfLargeGearsUsed);
                    }
                }
            }
        }
    }
    
}

@end
