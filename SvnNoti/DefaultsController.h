//
//  DefaultsController.h
//  SvnNoti
//
//  Created by ying yuandong on 13-4-20.
//  Copyright (c) 2013年 ying yuandong. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface DefaultsController : NSUserDefaultsController

- (IBAction)saveAndClose:(id)sender;

@property (unsafe_unretained) IBOutlet NSWindow *window;
@property (weak) IBOutlet NSTextField *timeIntervalText;


@end
