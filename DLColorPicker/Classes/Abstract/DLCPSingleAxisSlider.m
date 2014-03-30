//
//  DLCPSingleAxisSlider.m
//  DLColorPicker
//
//  Created by Vincent Esche on 3/28/14.
//  Copyright (c) 2014 Vincent Esche. All rights reserved.
//

#import "DLCPSingleAxisSlider.h"
#import "DLCPSingleAxisSlider+Protected.h"

#import "DLCPIndicatorLayer.h"
#import "UIControl+DLCP.h"

@implementation DLCPSingleAxisSlider

@dynamic cornerRadius, borderWidth, borderColor, shadowColor, shadowRadius, shadowOpacity, shadowOffset;

- (instancetype)initWithCoder:(NSCoder *)coder {
    self = [super initWithCoder:coder];
    if (self) {
        [self commonInit_DLCPSingleAxisSlider];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self commonInit_DLCPSingleAxisSlider];
    }
    return self;
}

- (void)commonInit_DLCPSingleAxisSlider {
	self.indicatorLayer = [[[self class] indicatorLayerClass] layer];
	[self.layer addSublayer:self.indicatorLayer];
	
	self.minXValue = [[self class] defaultMinXValue];
	self.maxXValue = [[self class] defaultMaxXValue];
	self.xValue = [[self class] defaultXValue];
}

+ (Class)layerClass {
	return [self backgroundLayerClass];
}

+ (Class)backgroundLayerClass {
	return [DLCPBackgroundLayer class];
}

+ (Class)indicatorLayerClass {
	return [DLCPIndicatorLayer class];
}

- (CGRect)effectiveCanvasRect {
	CGRect canvasRect = self.bounds;
	CGSize indicatorSize = self.indicatorSize;
	CGFloat indicatorMargin = 2.0;
	CGFloat margin = self.layer.borderWidth + indicatorMargin;
	CGFloat insetX = MIN(CGRectGetWidth(canvasRect) / 2, (indicatorSize.width / 2) + margin);
	CGFloat insetY = MIN(CGRectGetHeight(canvasRect) / 2, (indicatorSize.height / 2) + margin);
	return CGRectInset(self.bounds, insetX, insetY);
}

- (CGPoint)point:(CGPoint)point retrictedToRect:(CGRect)rect {
	point.x = MIN(MAX(point.x, CGRectGetMinX(rect)), CGRectGetMaxX(rect));
	point.y = MIN(MAX(point.y, CGRectGetMinY(rect)), CGRectGetMaxY(rect));
	return point;
}

- (CGSize)indicatorSize {
	return self.indicatorLayer.bounds.size;
}

- (CGRect)canvasRect {
	return self.bounds;
}

+ (BOOL)isFlipped {
	return YES;
}

- (CGPoint)normalizedLocation:(CGPoint)location inRect:(CGRect)rect flipped:(BOOL)flipped {
	CGFloat x = (location.x - CGRectGetMinX(rect)) / CGRectGetWidth(rect);
	CGFloat y = (location.y - CGRectGetMinY(rect)) / CGRectGetHeight(rect);
	x = MAX(MIN(x, 1.0), 0.0);
	y = MAX(MIN(y, 1.0), 0.0);
	if (flipped) {
		y = 1.0 - y;
	}
	return CGPointMake(x, y);
}

- (CGPoint)denormalizedLocation:(CGPoint)location inRect:(CGRect)rect flipped:(BOOL)flipped {
	location.x = MAX(MIN(location.x, 1.0), 0.0);
	location.y = MAX(MIN(location.y, 1.0), 0.0);
	if (flipped) {
		location.y = 1.0 - location.y;
	}
	CGFloat x = CGRectGetMinX(rect) + (CGRectGetWidth(rect) * location.x);
	CGFloat y = CGRectGetMinY(rect) + (CGRectGetHeight(rect) * location.y);
	return CGPointMake(x, y);
}

- (void)indicatorDidMoveToNormalizedLocation:(CGPoint)normalizedLocation {
	self.xValue = normalizedLocation.x;
	[self sendActionsForControlEvents:UIControlEventValueChanged];
}

- (void)updateForNormalizedLocation:(CGPoint)normalizedLocation {
	CGPoint position = [self denormalizedLocation:normalizedLocation inRect:self.bounds flipped:[[self class] isFlipped]];
	position = [self point:position retrictedToRect:self.effectiveCanvasRect];
	position.x = round(position.x);
	position.y = round(position.y);
	self.indicatorLayer.position = position;
}

- (void)trackIndicatorWithTouch:(UITouch *)touch {
	CGPoint denormalizedLocation = [touch locationInView:self];
	CGPoint normalizedLocation = [self normalizedLocation:denormalizedLocation inRect:self.bounds flipped:[[self class] isFlipped]];
	[self indicatorDidMoveToNormalizedLocation:normalizedLocation];
}

- (BOOL)beginTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event {
	[self trackIndicatorWithTouch:touch];
	return YES;
}

- (BOOL)continueTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event {
	[CATransaction begin];
    [CATransaction setAnimationDuration:0.0];
	[self trackIndicatorWithTouch:touch];
	[CATransaction commit];
	return YES;
}

+ (CGFloat)defaultMinXValue {
	return 0.0;
}

+ (CGFloat)defaultMaxXValue {
	return 1.0;
}

+ (CGFloat)defaultXValue {
	return 0.5;
}

- (CGFloat)boundedXValue:(CGFloat)xValue {
	return MIN(MAX(xValue, self.minXValue), self.maxXValue);
}

- (void)setXValue:(CGFloat)xValue {
	[self setPrimitiveXValue:xValue];
	[self updateForNormalizedLocation:[self currentNormalizedLocation]];
}

- (void)setPrimitiveXValue:(CGFloat)xValue {
	[self willChangeValueForKey:NSStringFromSelector(@selector(xValue))];
	_xValue = [self boundedXValue:xValue];
	[self didChangeValueForKey:NSStringFromSelector(@selector(xValue))];
}

- (CGPoint)currentNormalizedLocation {
	return CGPointMake(self.xValue, 0.5);
}

@end
