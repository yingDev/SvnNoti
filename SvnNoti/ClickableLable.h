//
//  ClickableLable.h
//  SvnNoti
//
//  Created by ying yuandong on 13-4-21.
//  Copyright (c) 2013年 ying yuandong. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@class ClickableLable;

@protocol ClickableLabelDelegate <NSObject>

-(void) onClick:(ClickableLable*) sender;
-(void) onDrawBackground:(ClickableLable*) sender;

@end

@interface ClickableLable : NSTextField

@property(weak) NSObject<ClickableLabelDelegate>* theDelegate;

@end
