//
//  TimeIntervalValueTransformer.m
//  SvnNoti
//
//  Created by ying yuandong on 13-4-20.
//  Copyright (c) 2013年 ying yuandong. All rights reserved.
//

#import "TimeIntervalValueTransformer.h"

@implementation TimeIntervalValueTransformer


- (id)transformedValue:(id)value
{
	int num = [(NSNumber*)value intValue];
	return [NSNumber numberWithInt:sqrt(num)];;
}
- (id)reverseTransformedValue:(id)value
{
	int num = [(NSNumber*)value intValue];
	return [NSNumber numberWithInt:num*num ];
}

@end
