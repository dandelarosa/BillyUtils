//
//  AppDelegate.m
//  BillyUtils
//
//  Created by Dan Dela Rosa on 3/9/14.
//  Copyright (c) 2014 MRD Engineering. All rights reserved.
//

#import "AppDelegate.h"
#import "WatchmakerViewController.h"

@interface AppDelegate ()

@property (nonatomic, strong) IBOutlet WatchmakerViewController *watchmakerViewController;

@end

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    self.watchmakerViewController = [[WatchmakerViewController alloc] initWithNibName:@"WatchmakerViewController" bundle:nil];
    NSView *subview = self.watchmakerViewController.view;
    [self.window.contentView addSubview:subview];
    [subview setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.window.contentView addConstraints:[NSLayoutConstraint
                               constraintsWithVisualFormat:@"H:|-0-[subview]-0-|"
                               options:NSLayoutFormatDirectionLeadingToTrailing
                               metrics:nil
                               views:NSDictionaryOfVariableBindings(subview)]];
    [self.window.contentView addConstraints:[NSLayoutConstraint
                               constraintsWithVisualFormat:@"V:|-0-[subview]-0-|"
                               options:NSLayoutFormatDirectionLeadingToTrailing
                               metrics:nil
                               views:NSDictionaryOfVariableBindings(subview)]];
    [self.watchmakerViewController setupView];
}

@end
