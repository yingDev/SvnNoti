//
//  AppDelegate.m
//  SvnNoti
//
//  Created by ying yuandong on 13-4-20.
//  Copyright (c) 2013年 ying yuandong. All rights reserved.
//

#import "AppDelegate.h"

@implementation AppDelegate
{
	int svnState;
}


-(void) onSvnError:(NSNotification*) noti
{
	NSLog(@"onSvnError:%@",noti.userInfo);
	self.statusItem.image = [NSImage imageNamed:@"svn_error.png"];
	svnState = 2;
}

-(void) onclick
{
	NSLog(@"onclick");
	if(svnState == 1)
	{
		self.statusItem.image = [NSImage imageNamed:@"svn_default.png"];
	}
	
	[self.statusItem popUpStatusItemMenu:self.statusMenu];
}

-(void) onSvnUpdated
{
	NSLog(@"onSvnUpdated");
	//txtIcon.textColor = [NSColor colorWithSRGBRed:0.0 green:0.6 blue:0.0 alpha:1.0];
	self.statusItem.image = [NSImage imageNamed:@"svn_updated.png"];
	svnState = 1;
}

-(void) beginCheckSvn
{
	NSLog(@"beginCheckSvn");
	svnState = 0;
	//txtIcon.textColor = [NSColor blackColor];
	self.statusItem.image = [NSImage imageNamed:@"svn_default.png"];
}


- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
	self.statusItem = [[NSStatusBar systemStatusBar] statusItemWithLength:32.0f];
	//self.statusItem.menu = self.statusMenu;
	//self.statusItem.title = @"SVN";
	self.statusItem.image = [NSImage imageNamed:@"svn_default.png"];
	self.statusItem.alternateImage = [NSImage imageNamed:@"svn_alter.png"];
	self.statusItem.highlightMode = YES;
	
	[self.statusItem setAction:@selector(onclick)];
	[self.statusItem setTarget:self];
	
	[NSApp activateIgnoringOtherApps:YES];
	
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onSvnError:) name:@"onSvnError" object:nil];
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onSvnUpdated) name:@"onSvnUpdated" object:nil];
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(beginCheckSvn) name:@"beginCheckSvn" object:nil];
}

-(void)dealloc
{
	[[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
