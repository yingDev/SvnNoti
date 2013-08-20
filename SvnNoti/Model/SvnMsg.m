//
//  SvnMsg.m
//  SvnNoti
//
//  Created by ying yuandong on 13-4-20.
//  Copyright (c) 2013年 ying yuandong. All rights reserved.
//

#import "SvnMsg.h"

@implementation SvnMsg

-(void) encodeWithCoder:(NSCoder *)aCoder
{
	//todo:impl
}

-(id) initWithCoder:(NSCoder *)aDecoder
{
	return nil;
}

-(NSString*) description
{
	return [NSString stringWithFormat:@"rev:%@\nauthor:%@\ntime:%@\nmessage:%@",self.revision,self.author,self.time,self.message];
}

@end
