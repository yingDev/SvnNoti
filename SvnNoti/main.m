//
//  main.m
//  SvnNoti
//
//  Created by ying yuandong on 13-4-20.
//  Copyright (c) 2013年 ying yuandong. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "Model/SvnChecker.h"

int main(int argc, char *argv[])
{
	return NSApplicationMain(argc, (const char **)argv);
//	SvnChecker* check = [SvnChecker checkerWithURLString:@"svn://202.114.255.14/AdouSvn/zgcm"];
//	check.svnCmd = @"/usr/bin/svn";
//	
//	[check checkAsync:^(NSError * err, SvnMsg * msg)
//	{
//		if(err != nil)
//		{
//			NSLog(@"Error:%@",err);
//		}else if(msg != nil)
//		{
//			NSLog(@"%@",msg);
//		}
//	}];
//
//	while (1) {
//		sleep(100);
//	}

//	NSError* err;
//	[check check:&err];
//	
//	if(err == nil)
//	{
//		NSLog(@"message:%@",check.lastMsg);
//	}else
//	{
//		NSLog(@"checker error:%@",err);
//	}
}
