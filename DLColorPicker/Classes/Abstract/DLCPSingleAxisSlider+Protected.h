//
//  DLCPSingleAxisSlider+Protected.h
//  DLColorPicker
//
//  Created by Vincent Esche on 3/28/14.
//  Copyright (c) 2014 Vincent Esche. All rights reserved.
//

#import "DLCPSingleAxisSlider.h"

#import "DLCPBackgroundLayer.h"

@interface DLCPSingleAxisSlider ()

@property (readwrite, strong, nonatomic) CALayer *indicatorLayer;

@property (readwrite, assign, nonatomic) CGFloat xValue;
@property (readwrite, assign, nonatomic) CGFloat minXValue;
@property (readwrite, assign, nonatomic) CGFloat maxXValue;

+ (BOOL)isFlipped;

- (CGRect)effectiveCanvasRect;
- (CGPoint)point:(CGPoint)point retrictedToRect:(CGRect)rect;
- (CGFloat)boundedXValue:(CGFloat)xValue;

- (CGPoint)normalizedLocation:(CGPoint)location inRect:(CGRect)rect flipped:(BOOL)flipped;
- (CGPoint)denormalizedLocation:(CGPoint)location inRect:(CGRect)rect flipped:(BOOL)flipped;

- (void)indicatorDidMoveToNormalizedLocation:(CGPoint)normalizedLocation;
- (void)updateForNormalizedLocation:(CGPoint)normalizedLocation;

- (void)setPrimitiveXValue:(CGFloat)xValue;

@end
