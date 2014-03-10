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
    [self.window.contentView addSubview:self.watchmakerViewController.view];
}

@end
