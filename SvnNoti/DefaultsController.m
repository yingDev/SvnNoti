//
//  DefaultsController.m
//  SvnNoti
//
//  Created by ying yuandong on 13-4-20.
//  Copyright (c) 2013年 ying yuandong. All rights reserved.
//

#import "DefaultsController.h"

@implementation DefaultsController


- (IBAction)saveAndClose:(id)sender
{
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(prefsUpdated) name:NSUserDefaultsDidChangeNotification object:nil];
	
	[self save:sender];
	[self.window close];
	
	//[self.defaults synchronize];
}

-(void) prefsUpdated
{
	NSLog(@"prefs updated");
	[[NSNotificationCenter defaultCenter] postNotificationName:@"prefsUpdated" object:nil];
	[[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
