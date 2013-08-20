//
//  StatusBarViewController.m
//  SvnNoti
//
//  Created by ying yuandong on 13-4-20.
//  Copyright (c) 2013年 ying yuandong. All rights reserved.
//

#import "StatusBarViewController.h"
#import "Model/SvnChecker.h"

@interface StatusBarViewController ()

@end

@implementation StatusBarViewController
{
	NSTimer* _timer;
	NSString* oldRev;
}


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Initialization code here.
    }
	
	    
    return self;
}

-(void) prefsUpdated
{
	[self checkSvn:nil];
}

-(void) refreshView:(SvnMsg*) msg
{
	[self.revision setStringValue:msg.revision];
	[self.author setStringValue:msg.author];
	[self.message setStringValue:msg.message];
	[self.time setStringValue:msg.time];
	
}

-(void) scheduleNext:(NSNumber*) interval;
{
	NSLog(@"scheduleNext");
	[_timer invalidate];
	_timer = [NSTimer scheduledTimerWithTimeInterval:[interval doubleValue]*60
											  target:self selector:@selector(checkSvn:)
											userInfo:nil repeats:NO];
	
}

-(void) postNotification:(NSNotification*) notif
{
	[[NSNotificationCenter defaultCenter] postNotification:notif];
}

-(void) checkSvn:(id)sender
{
	NSString* url = [self.defaults.values valueForKey:@"url"];
	NSNumber* interval = [self.defaults.values valueForKey:@"interval"];
	
	if(url.length < 3) [self showPrefWindow:self];
	[self.message setStringValue:@"Checking..."];
	
	NSLog(@"time interval:%@",interval);
	
	SvnChecker* check = [SvnChecker checkerWithURLString:url];
	check.svnCmd = @"/usr/bin/svn";
	
	self.message.textColor = [NSColor blackColor];
	[[NSNotificationCenter defaultCenter] postNotificationName:@"beginCheckSvn" object:nil];
	[check checkAsync:^(NSError * err, SvnMsg * msg)
	 {
		 if(err != nil)
		 {
			 NSLog(@"Error:%@",err);
			 NSDictionary* userInfo = [NSDictionary dictionaryWithObjectsAndKeys:err,@"error", nil];
			 //[[NSNotificationCenter defaultCenter] postNotificationName:@"onSvnError" object:nil userInfo:userInfo];
			 NSNotification* note = [NSNotification notificationWithName:@"onSvnError" object:nil userInfo:userInfo];
			 
			 [_timer invalidate];
			 
			 [self performSelectorOnMainThread:@selector(postNotification:) withObject:note waitUntilDone:YES];
			 
			 [self.revision setStringValue:@":-("];
			 [self.author setStringValue:@"Oops..."];
			 [self.message setStringValue:[NSString stringWithFormat:@"%@",[err.userInfo valueForKey:@"msg"]]];
			 self.message.textColor = [NSColor redColor];
		 }else if(msg != nil)
		 {
			 
			 [self performSelectorOnMainThread:@selector(refreshView:) withObject:msg waitUntilDone:YES];
			 
			 //是否需要通知更新
			 if(![oldRev isEqualToString:msg.revision])
			 {
				[[NSNotificationCenter defaultCenter] postNotificationName:@"onSvnUpdated" object:nil userInfo:nil];
				oldRev = msg.revision;
			 }
			 
			  [self performSelectorOnMainThread:@selector(scheduleNext:) withObject:interval waitUntilDone:YES];
		 }
	 }];

}

-(void)awakeFromNib
{
	NSLog(@"StatusBarViewController registering to notification center.");
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(prefsUpdated) name:@"prefsUpdated" object:nil];
	[self checkSvn:nil];
}

- (IBAction)showPrefWindow:(id)sender
{
	[self.perfWindow setLevel:1280];
	[self.perfWindow makeKeyAndOrderFront:self];
}

-(void) dealloc
{
	[[NSNotificationCenter defaultCenter] removeObserver:self];
}
@end
