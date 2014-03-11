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

@property (weak) IBOutlet NSTextField *bronzeSmallGearwheelValueTextField;
@property (weak) IBOutlet NSTextField *bronzeMediumGearwheelValueTextField;
@property (weak) IBOutlet NSTextField *bronzeLargeGearwheelValueTextField;
@property (weak) IBOutlet NSTextField *bronzeGearingRequiredTextField;

@property (nonatomic, strong) NSMutableArray *bronzeSolutions;

@property (weak) IBOutlet NSTableView *bronzeSolutionTableView;
@property (weak) IBOutlet NSTableColumn *bronzeSmallGearsTableColumn;
@property (weak) IBOutlet NSTableColumn *bronzeMediumGearsTableColumn;
@property (weak) IBOutlet NSTableColumn *bronzeLargeGearsTableColumn;
@property (weak) IBOutlet NSTableColumn *bronzeTotalTableColumn;

@property (weak) IBOutlet NSTextField *silverSmallGearwheelValueTextField;
@property (weak) IBOutlet NSTextField *silverMediumGearwheelValueTextField;
@property (weak) IBOutlet NSTextField *silverLargeGearwheelValueTextField;
@property (weak) IBOutlet NSTextField *silverGearingRequiredTextField;

@property (nonatomic, strong) NSMutableArray *silverSolutions;

@property (weak) IBOutlet NSTableView *silverSolutionTableView;
@property (weak) IBOutlet NSTableColumn *silverSmallGearsTableColumn;
@property (weak) IBOutlet NSTableColumn *silverMediumGearsTableColumn;
@property (weak) IBOutlet NSTableColumn *silverLargeGearsTableColumn;
@property (weak) IBOutlet NSTableColumn *silverTotalTableColumn;

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

- (IBAction)bronzeGearingEntered:(id)sender
{
    [self solveBronzeGears];
}

- (IBAction)silverGearingEntered:(id)sender
{
    [self solveSilverGears];
}

- (IBAction)bronzeSolveButtonPressed:(id)sender
{
    [self solveBronzeGears];
}

- (IBAction)silverSolveButtonPressed:(id)sender
{
    [self solveSilverGears];
}

- (void)solveBronzeGears
{
    self.bronzeSolutions = [NSMutableArray array];
    
    NSInteger smallGearwheelValue = self.bronzeSmallGearwheelValueTextField.integerValue;
    NSInteger mediumGearwheelValue = self.bronzeMediumGearwheelValueTextField.integerValue;
    NSInteger largeGearwheelValue = self.bronzeLargeGearwheelValueTextField.integerValue;
    NSInteger gearingRequired = self.bronzeGearingRequiredTextField.integerValue;
    
    [self solveWithGearingRequired:gearingRequired
               smallGearwheelValue:smallGearwheelValue
              mediumGearwheelValue:mediumGearwheelValue
               largeGearwheelValue:largeGearwheelValue
                storeSolutionsHere:self.bronzeSolutions];
    
    [self.bronzeSolutionTableView reloadData];
}

- (void)solveSilverGears
{
    self.silverSolutions = [NSMutableArray array];
    
    NSInteger smallGearwheelValue = self.silverSmallGearwheelValueTextField.integerValue;
    NSInteger mediumGearwheelValue = self.silverMediumGearwheelValueTextField.integerValue;
    NSInteger largeGearwheelValue = self.silverLargeGearwheelValueTextField.integerValue;
    NSInteger gearingRequired = self.silverGearingRequiredTextField.integerValue;
    
    [self solveWithGearingRequired:gearingRequired
               smallGearwheelValue:smallGearwheelValue
              mediumGearwheelValue:mediumGearwheelValue
               largeGearwheelValue:largeGearwheelValue
                storeSolutionsHere:self.silverSolutions];
    
    [self.silverSolutionTableView reloadData];
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
    if (aTableView == self.bronzeSolutionTableView) {
        return self.bronzeSolutions.count;
    }
    else if (aTableView == self.silverSolutionTableView) {
        return self.silverSolutions.count;
    }
    else {
        return 0;
    }
}

- (id)tableView:(NSTableView *)aTableView objectValueForTableColumn:(NSTableColumn *)aTableColumn row:(NSInteger)rowIndex
{
    if (aTableView == self.bronzeSolutionTableView) {
        WatchmakerSolution *solution = [self.bronzeSolutions objectAtIndex:rowIndex];
        
        NSInteger large = (solution.isLargeGearNegative ? -1 : 1) * solution.numberOfLargeGearsUsed;
        NSInteger medium = (solution.isMediumGearNegative ? -1 : 1) * solution.numberOfMediumGearsUsed;
        NSInteger small = (solution.isSmallGearNegative ? -1 : 1) * solution.numberOfSmallGearsUsed;
        
        if (aTableColumn == self.bronzeSmallGearsTableColumn) {
            return @(small);
        }
        else if (aTableColumn == self.bronzeMediumGearsTableColumn) {
            return @(medium);
        }
        else if (aTableColumn == self.bronzeLargeGearsTableColumn) {
            return @(large);
        }
        else {
            return  @(solution.totalGearsUsed);
        }
    }
    else if (aTableView == self.silverSolutionTableView) {
        WatchmakerSolution *solution = [self.silverSolutions objectAtIndex:rowIndex];
        
        NSInteger large = (solution.isLargeGearNegative ? -1 : 1) * solution.numberOfLargeGearsUsed;
        NSInteger medium = (solution.isMediumGearNegative ? -1 : 1) * solution.numberOfMediumGearsUsed;
        NSInteger small = (solution.isSmallGearNegative ? -1 : 1) * solution.numberOfSmallGearsUsed;
        
        if (aTableColumn == self.silverSmallGearsTableColumn) {
            return @(small);
        }
        else if (aTableColumn == self.silverMediumGearsTableColumn) {
            return @(medium);
        }
        else if (aTableColumn == self.silverLargeGearsTableColumn) {
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
