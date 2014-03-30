//
//  WatchmakerSolverViewController.m
//  BillyUtils
//
//  Created by Dan Dela Rosa on 3/29/14.
//  Copyright (c) 2014 MRD Engineering. All rights reserved.
//

#import "WatchmakerSolverViewController.h"
#import "WatchmakerSolution.h"

@interface WatchmakerSolverViewController () <NSTableViewDataSource, NSTableViewDelegate>

@property (weak) IBOutlet NSTextField *gearingRequiredTextField;
@property (weak) IBOutlet NSTextField *smallGearwheelValueTextField;
@property (weak) IBOutlet NSTextField *mediumGearwheelValueTextField;
@property (weak) IBOutlet NSTextField *largeGearwheelValueTextField;

@property (nonatomic, strong) NSMutableArray *solutions;

@property (weak) IBOutlet NSTableView *solutionTableView;
@property (weak) IBOutlet NSTableColumn *smallGearsTableColumn;
@property (weak) IBOutlet NSTableColumn *mediumGearsTableColumn;
@property (weak) IBOutlet NSTableColumn *largeGearsTableColumn;
@property (weak) IBOutlet NSTableColumn *totalTableColumn;

@end

@implementation WatchmakerSolverViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Initialization code here.
    }
    return self;
}


#pragma mark - Control Events

- (IBAction)gearingEntered:(id)sender
{
    [self solve];
}

- (IBAction)solveButtonPressed:(id)sender
{
    [self solve];
}



#pragma mark - Finding Solutions

- (void)solve
{
    self.solutions = [NSMutableArray array];
    
    NSInteger smallGearwheelValue = self.smallGearwheelValueTextField.integerValue;
    NSInteger mediumGearwheelValue = self.mediumGearwheelValueTextField.integerValue;
    NSInteger largeGearwheelValue = self.largeGearwheelValueTextField.integerValue;
    NSInteger gearingRequired = self.gearingRequiredTextField.integerValue;
    
    [self solveWithGearingRequired:gearingRequired
               smallGearwheelValue:smallGearwheelValue
              mediumGearwheelValue:mediumGearwheelValue
               largeGearwheelValue:largeGearwheelValue
                storeSolutionsHere:self.solutions];
    
    [self.solutionTableView reloadData];
}

- (void)solveWithGearingRequired:(NSInteger)gearingRequired
             smallGearwheelValue:(NSInteger)smallGearwheelValue
            mediumGearwheelValue:(NSInteger)mediumGearwheelValue
             largeGearwheelValue:(NSInteger)largeGearwheelValue
              storeSolutionsHere:(NSMutableArray *)solutionsArray
{
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
                        WatchmakerSolution *solution = [[WatchmakerSolution alloc] init];
                        solution.numberOfSmallGearsUsed = numberOfSmallGearsUsed;
                        solution.numberOfMediumGearsUsed = numberOfMediumGearsUsed;
                        solution.numberOfLargeGearsUsed = numberOfLargeGearsUsed;
                        solution.isSmallGearNegative = isSmallGearNegative;
                        solution.isMediumGearNegative = isMediumGearNegative;
                        solution.isLargeGearNegative = isLargeGearNegative;
                        [solutionsArray addObject:solution];
                    }
                }
            }
        }
    }
}


#pragma mark - NSTableViewDataSource

- (NSInteger)numberOfRowsInTableView:(NSTableView *)aTableView
{
    if (aTableView == self.solutionTableView) {
        return self.solutions.count;
    }
    else {
        return 0;
    }
}

- (id)tableView:(NSTableView *)aTableView objectValueForTableColumn:(NSTableColumn *)aTableColumn row:(NSInteger)rowIndex
{
    if (aTableView == self.solutionTableView) {
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
    else {
        return nil;
    }
}

@end
