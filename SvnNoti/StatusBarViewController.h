//
//  StatusBarViewController.h
//  SvnNoti
//
//  Created by ying yuandong on 13-4-20.
//  Copyright (c) 2013年 ying yuandong. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface StatusBarViewController : NSViewController

@property (weak) IBOutlet NSUserDefaultsController* defaults;

-(IBAction) checkSvn:(id)sender;

@property (weak) IBOutlet NSTextField *revision;
@property (weak) IBOutlet NSTextField *author;
@property (weak) IBOutlet NSTextField *message;

@property (weak) IBOutlet NSTextField *time;
- (IBAction)showPrefWindow:(id)sender;
@property (unsafe_unretained) IBOutlet NSWindow *perfWindow;

@end
