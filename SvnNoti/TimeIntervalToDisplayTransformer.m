//
//  TimeIntervalToDisplayTransformer.m
//  SvnNoti
//
//  Created by ying yuandong on 13-4-20.
//  Copyright (c) 2013年 ying yuandong. All rights reserved.
//

#import "TimeIntervalToDisplayTransformer.h"

@implementation TimeIntervalToDisplayTransformer


- (id)transformedValue:(id)value
{
	return [NSString stringWithFormat:@"%d min",((NSNumber*)value).intValue];
}
- (id)reverseTransformedValue:(id)value
{
	return value;
}


@end
