//
//  SvnChecker.h
//  SvnNoti
//
//  Created by ying yuandong on 13-4-20.
//  Copyright (c) 2013年 ying yuandong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SvnMsg.h"

@interface SvnChecker : NSObject

+(id) checkerWithURLString:(NSString*) url;

@property(copy,nonatomic) NSString* svnCmd;
@property(copy) NSString* url;
@property(readonly) SvnMsg* lastMsg;

-(void) check:(NSError**) error;
-(void) checkAsync:(void (^)(NSError*,SvnMsg*)) block;

@end
