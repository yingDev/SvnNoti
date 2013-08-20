//
//  ClickableLable.m
//  SvnNoti
//
//  Created by ying yuandong on 13-4-21.
//  Copyright (c) 2013年 ying yuandong. All rights reserved.
//

#import "ClickableLable.h"

@implementation ClickableLable

- (id)initWithFrame:(NSRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
	{
		[self setBezeled:NO];
		[self setEditable:NO];
		[self setSelectable:NO];
		[self setDrawsBackground:NO];
		NSFont* newfont = [NSFont fontWithName:@"Arial" size:13];
		[self setFont:newfont];
		
		NSShadow* shadow = [[NSShadow alloc] init];
		[shadow setShadowColor:[NSColor whiteColor]];
		
		NSSize size = NSMakeSize(0, 1);
		[shadow setShadowOffset:size];
		[shadow setShadowBlurRadius:0.5f];
		
		[self setWantsLayer:YES];
		
		[self setShadow:shadow];
    }
    
    return self;
}

- (void)drawRect:(NSRect)dirtyRect
{
	if([self.theDelegate respondsToSelector:@selector(onDrawBackground:)])
	{
		[self.theDelegate onDrawBackground:self];
	}
    [super drawRect:dirtyRect];
}

- (void)mouseDown:(NSEvent *)theEvent
{
	[super mouseDown:theEvent];
	if([self.theDelegate respondsToSelector:@selector(onClick:)])
	{
		[self.theDelegate onClick:self];
	}
}

@end
