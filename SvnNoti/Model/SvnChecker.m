//
//  SvnChecker.m
//  SvnNoti
//
//  Created by ying yuandong on 13-4-20.
//  Copyright (c) 2013年 ying yuandong. All rights reserved.
//

#import "SvnChecker.h"

@implementation SvnChecker
{
	NSTask* _task;
}

+(id) checkerWithURLString:(NSString *)url
{
	id ins = [[SvnChecker alloc] initWithUrlString:url];
	return ins;
}

@synthesize url = _url;
@synthesize svnCmd = _svnCmd;
@synthesize lastMsg = _lastMsg;

-(NSString*) svnCmd
{
	if(_svnCmd == nil)
	{
		_svnCmd = @"/usr/bin/svn";
	}
	
	return _svnCmd;
}

-(id) initWithUrlString:(NSString*) url
{
	if(self = [super init])
	{
		_url = url;
	}
	
	return self;
}

-(SvnMsg*) parseStringMsg:(NSString*) strOut
{
	//eg:
	//------------------------------------------------------------------------
	//	r45 | ying | 2013-04-12 14:58:54 +0800 (Fri, 12 Apr 2013) | 2 lines
	//	
	//	commit前请先更新, 之前我写的东西直接被抹掉了!!!
	//	view里面的id要加前缀, ok?!!!
	//	------------------------------------------------------------------------
	SvnMsg* msg = [[SvnMsg alloc] init];
	
	NSArray* lines = [strOut componentsSeparatedByString:@"\n"];
	
	//第二行
	NSArray* infos = [[lines objectAtIndex:1] componentsSeparatedByString:@"|"];
	
	msg.revision = [infos objectAtIndex:0];
	msg.author = [infos objectAtIndex:1];
	msg.time = [(NSString*)[infos objectAtIndex:2] substringToIndex:17];
	
	//assemble the message body
	NSString* body = @"";
	for(int i=2;i<lines.count - 2;i++)
	{
		body = [body stringByAppendingFormat:@"%@\n",[lines objectAtIndex:i]];
	}
	
	msg.message = body;
	
	//NSLog(@"msg parsed: %@",msg);
	
	return msg;
}

-(void) check:(NSError**) error
{
	NSLog(@"SvnChecker: command: %@",self.svnCmd);
	NSLog(@"SvnChecker: checking url: %@",self.url);
	_task = [[NSTask alloc] init];
	_task.launchPath = self.svnCmd;
	
	//必须有此环境变量, 否则乱码!!
	NSMutableDictionary* env = [NSMutableDictionary dictionaryWithObjectsAndKeys:@"en_US.UTF-8",@"LC_ALL",nil];
	[_task setEnvironment:env];
		
	//eg:
	//svn log "svn://202.114.255.14/AdouSvn/zgcm" -l 1
	NSArray* args = [NSArray arrayWithObjects:@"log",self.url,@"-l",@"1",nil];
	_task.arguments = args;
	
	NSPipe* pipeOut = [NSPipe pipe];
	NSPipe* pipeErr = [NSPipe pipe];
	
	_task.standardOutput = pipeOut;
	_task.standardError = pipeErr;
	
	NSFileHandle* fileOut = [pipeOut fileHandleForReading];
	NSFileHandle* fileErr = [pipeErr fileHandleForReading];
	
	[_task launch];
	
	NSData* dataOut = [fileOut readDataToEndOfFile];
	NSData* dataErr = [fileErr readDataToEndOfFile];
	
	NSString* strOut = [[NSString alloc] initWithData:dataOut encoding:NSUTF8StringEncoding];
	NSString* strErr = [[NSString alloc] initWithData:dataErr encoding:NSUTF8StringEncoding];
	
	//[dataOut writeToFile:@"/Users/yingyuandong/Desktop/test.txt" atomically:YES];
	
	//NSLog(@"SvnChecker: output:%@",strOut);
	//NSLog(@"SvnChecker: error:%@",strErr);
	
	if(strOut.length > 0)
	{
		_lastMsg = [self parseStringMsg:strOut];
	}else if(error != NULL)
	{
		NSDictionary* errMsg = [NSDictionary dictionaryWithObjectsAndKeys:strErr,@"msg", nil];
		*error = [NSError errorWithDomain:@"" code:1 userInfo:errMsg];
	}
}

-(void) privateCheckAsync:(void (^)(NSError*,SvnMsg*)) block
{
	NSError* err;
	
	[self check:&err];
	block(err,self.lastMsg);
}

-(void) checkAsync:(void (^)(NSError*,SvnMsg*)) block
{
	[self performSelectorInBackground:@selector(privateCheckAsync:) withObject:block];
}

@end
