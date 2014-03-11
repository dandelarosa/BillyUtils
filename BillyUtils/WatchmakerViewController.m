//
//  WatchmakerViewController.m
//  BillyUtils
//
//  Created by Dan Dela Rosa on 3/9/14.
//  Copyright (c) 2014 MRD Engineering. All rights reserved.
//

#import "WatchmakerViewController.h"
#import "WatchmakerSolution.h"

@interface WatchmakerViewController () <NSTableViewDataSource, NSTableViewDelegate>

@property (weak) IBOutlet NSTextField *smallGearwheelValueTextField;
@property (weak) IBOutlet NSTextField *mediumGearwheelValueTextField;
@property (weak) IBOutlet NSTextField *largeGearwheelValueTextField;
@property (weak) IBOutlet NSTextField *gearingRequiredTextField;

@property (nonatomic, strong) NSMutableArray *solutions;

@property (weak) IBOutlet NSTableView *solutionTableView;
@property (weak) IBOutlet NSTableColumn *smallGearsTableColumn;
@property (weak) IBOutlet NSTableColumn *mediumGearsTableColumn;
@property (weak) IBOutlet NSTableColumn *largeGearsTableColumn;
@property (weak) IBOutlet NSTableColumn *totalTableColumn;

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
    self.solutions = [NSMutableArray array];
    
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
                        
                        WatchmakerSolution *solution = [[WatchmakerSolution alloc] init];
                        solution.numberOfSmallGearsUsed = numberOfSmallGearsUsed;
                        solution.numberOfMediumGearsUsed = numberOfMediumGearsUsed;
                        solution.numberOfLargeGearsUsed = numberOfLargeGearsUsed;
                        solution.isSmallGearNegative = isSmallGearNegative;
                        solution.isMediumGearNegative = isMediumGearNegative;
                        solution.isLargeGearNegative = isLargeGearNegative;
                        [self.solutions addObject:solution];
                    }
                }
            }
        }
    }
    [self.solutionTableView reloadData];
}

#pragma mark - NSTableViewDataSource

- (NSInteger)numberOfRowsInTableView:(NSTableView *)aTableView
{
    return self.solutions.count;
}

- (id)tableView:(NSTableView *)aTableView objectValueForTableColumn:(NSTableColumn *)aTableColumn row:(NSInteger)rowIndex
{
    WatchmakerSolution *solution = [self.solutions objectAtIndex:rowIndex];
    
    NSInteger large = (solution.isLargeGearNegative ? -1 : 1) * solution.numberOfLargeGearsUsed;
    NSInteger medium = (solution.isMediumGearNegative ? -1 : 1) * solution.numberOfMediumGearsUsed;
    NSInteger small = (solution.isSmallGearNegative ? -1 : 1) * solution.numberOfSmallGearsUsed;
    
    if (aTableColumn == self.smallGearsTableColumn) {
        return @(small);
    }
    else if (aTableColumn == self.mediumGearsTableColumn) {
        return @(medium);
    }
    else if (aTableColumn == self.largeGearsTableColumn) {
        return @(large);
    }
    else {
        return  @(solution.totalGearsUsed);
    }
}

@end
