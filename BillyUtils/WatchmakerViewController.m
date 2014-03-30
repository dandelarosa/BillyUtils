//
//  WatchmakerViewController.m
//  BillyUtils
//
//  Created by Dan Dela Rosa on 3/9/14.
//  Copyright (c) 2014 MRD Engineering. All rights reserved.
//

#import "WatchmakerViewController.h"
#import "WatchmakerSolverViewController.h"

@interface WatchmakerViewController ()

@property (nonatomic, strong) WatchmakerSolverViewController *bronzeViewController;
@property (nonatomic, strong) WatchmakerSolverViewController *silverViewController;
@property (nonatomic, strong) WatchmakerSolverViewController *goldViewController;

@property (weak) IBOutlet NSView *bronzeContainerView;
@property (weak) IBOutlet NSView *silverContainerView;
@property (weak) IBOutlet NSView *goldContainerView;

@end

@implementation WatchmakerViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
}

- (void)setupView
{
    WatchmakerSolverViewController *bronzeViewController = [[WatchmakerSolverViewController alloc] initWithNibName:NSStringFromClass([WatchmakerSolverViewController class]) bundle:nil];
    [self addSubview:bronzeViewController.view toView:self.bronzeContainerView];
    self.bronzeViewController = bronzeViewController;
    
    WatchmakerSolverViewController *silverViewController = [[WatchmakerSolverViewController alloc] initWithNibName:NSStringFromClass([WatchmakerSolverViewController class]) bundle:nil];
    [self addSubview:silverViewController.view toView:self.silverContainerView];
    self.silverViewController = silverViewController;
    
    WatchmakerSolverViewController *goldViewController = [[WatchmakerSolverViewController alloc] initWithNibName:NSStringFromClass([WatchmakerSolverViewController class]) bundle:nil];
    [self addSubview:goldViewController.view toView:self.goldContainerView];
    self.goldViewController = goldViewController;
}

- (void)addSubview:(NSView *)subview toView:(NSView *)view
{
    [view addSubview:subview];
    [subview setTranslatesAutoresizingMaskIntoConstraints:NO];
    [view addConstraints:[NSLayoutConstraint
                          constraintsWithVisualFormat:@"H:|-0-[subview]-0-|"
                          options:NSLayoutFormatDirectionLeadingToTrailing
                          metrics:nil
                          views:NSDictionaryOfVariableBindings(subview)]];
    [view addConstraints:[NSLayoutConstraint
                          constraintsWithVisualFormat:@"V:|-0-[subview]-0-|"
                          options:NSLayoutFormatDirectionLeadingToTrailing
                          metrics:nil
                          views:NSDictionaryOfVariableBindings(subview)]];
}

@end
