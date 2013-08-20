//
//  AppDelegate.h
//  SvnNoti
//
//  Created by ying yuandong on 13-4-20.
//  Copyright (c) 2013年 ying yuandong. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "ClickableLable.h"

@interface AppDelegate : NSObject <NSApplicationDelegate>

@property (assign) IBOutlet NSWindow *window;

@property (strong) IBOutlet NSMenu* statusMenu;
@property (strong) NSStatusItem* statusItem;

@end
