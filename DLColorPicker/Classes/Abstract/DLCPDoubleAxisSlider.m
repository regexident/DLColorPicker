//
//  DLCPDoubleAxisSlider.m
//  DLColorPicker
//
//  Created by Vincent Esche on 3/28/14.
//  Copyright (c) 2014 Vincent Esche. All rights reserved.
//

#import "DLCPDoubleAxisSlider.h"
#import "DLCPDoubleAxisSlider+Protected.h"

@implementation DLCPDoubleAxisSlider

- (instancetype)initWithCoder:(NSCoder *)coder {
    self = [super initWithCoder:coder];
    if (self) {
        [self commonInit_DLCPDoubleAxisSlider];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self commonInit_DLCPDoubleAxisSlider];
    }
    return self;
}

- (void)commonInit_DLCPDoubleAxisSlider {
    self.minYValue = [[self class] defaultMinYValue];
	self.maxYValue = [[self class] defaultMaxYValue];
	self.yValue = [[self class] defaultYValue];
}

+ (CGFloat)defaultMinYValue {
	return 0.0;
}

+ (CGFloat)defaultMaxYValue {
	return 1.0;
}

+ (CGFloat)defaultYValue {
	return 0.5;
}

- (CGFloat)boundedYValue:(CGFloat)yValue {
	return MIN(MAX(yValue, self.minYValue), self.maxYValue);
}

- (void)setYValue:(CGFloat)yValue {
	[self setPrimitiveYValue:yValue];
	[self updateForNormalizedLocation:[self currentNormalizedLocation]];
}

- (void)setPrimitiveYValue:(CGFloat)yValue {
	[self willChangeValueForKey:NSStringFromSelector(@selector(yValue))];
	_yValue = [self boundedYValue:yValue];
	[self didChangeValueForKey:NSStringFromSelector(@selector(yValue))];
}

- (void)setXValue:(CGFloat)xValue yValue:(CGFloat)yValue {
	[self setPrimitiveXValue:xValue];
	[self setPrimitiveYValue:yValue];
	[self updateForNormalizedLocation:[self currentNormalizedLocation]];
}

- (CGPoint)currentNormalizedLocation {
	return CGPointMake(self.xValue, self.yValue);
}

- (void)indicatorDidMoveToNormalizedLocation:(CGPoint)normalizedLocation {
	[self setXValue:normalizedLocation.x yValue:normalizedLocation.y];
	[self sendActionsForControlEvents:UIControlEventValueChanged];
}

@end
