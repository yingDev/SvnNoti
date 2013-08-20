//
//  SvnMsg.h
//  SvnNoti
//
//  Created by ying yuandong on 13-4-20.
//  Copyright (c) 2013年 ying yuandong. All rights reserved.
//

#import <Foundation/Foundation.h>

#define kREV @"revision"
#define kAUTHOR @"author"
#define kTIME @"time"
#define kMESSAGE @"message"

@interface SvnMsg : NSObject<NSCoding>

@property(copy) NSString* revision;
@property(copy) NSString* author;
@property(copy) NSString* time;
@property(copy) NSString* message;



@end
