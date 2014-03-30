//
//  DLCPAlphaPicker.m
//  DLColorPicker
//
//  Created by Vincent Esche on 10/28/13.
//  Copyright (c) 2013 Vincent Esche. All rights reserved.
//

#import "DLCPAlphaPicker.h"

#import "DLCPDoubleAxisSlider+Protected.h"

#import "DLCPCheckerBoard.h"

@interface DLCPAlphaBackgroundLayer : DLCPBackgroundLayer

@property (readwrite, strong, nonatomic) CAGradientLayer *gradientLayer;

@end

@implementation DLCPAlphaBackgroundLayer

+ (void)initialize {
	if ([self class] == [DLCPAlphaBackgroundLayer class]) {
		[self patternColor];
	}
}

- (instancetype)init {
    self = [super init];
    if (self) {
        [self commonInit_DLCPAlphaBackgroundLayer];
	}
    return self;
}

- (instancetype)initWithLayer:(id)layer {
    self = [super initWithLayer:layer];
    if (self) {
        [self commonInit_DLCPAlphaBackgroundLayer];
    }
    return self;
}

- (void)commonInit_DLCPAlphaBackgroundLayer {
	CAGradientLayer *gradientLayer = [CAGradientLayer layer];
	gradientLayer.startPoint = CGPointMake(0.0, 0.5);
	gradientLayer.endPoint = CGPointMake(1.0, 0.5);
	gradientLayer.colors = @[(__bridge id)[UIColor colorWithWhite:1.0 alpha:0.0].CGColor,
							 (__bridge id)[UIColor colorWithWhite:1.0 alpha:1.0].CGColor];
	gradientLayer.masksToBounds = YES;
	[self addSublayer:gradientLayer];
	self.gradientLayer = gradientLayer;
	gradientLayer.backgroundColor = [[self class] patternColor];
}

+ (CGColorRef)patternColor {
	static CGColorRef colorRef = nil;
	static dispatch_once_t onceToken;
	dispatch_once(&onceToken, ^{
		colorRef = DLCPCreateCheckerBoardPatternColorWithSize(0.50, 1.00, 0.5, 8.0);
	});
	return colorRef;
}

- (void)layoutSublayers {
	[super layoutSublayers];
	
	CGRect frame = self.bounds;
	CGFloat cornerRadius = self.cornerRadius;
	if (self.insetSubLayers) {
		CGFloat borderWidth = self.borderWidth;
		frame = CGRectInset(self.bounds, borderWidth, borderWidth);
		cornerRadius -= borderWidth;
	}
	
	CALayer *gradientLayer = self.gradientLayer;
	gradientLayer.frame = frame;
	gradientLayer.cornerRadius = cornerRadius;
}

@end

@interface DLCPAlphaPicker ()

@end

@implementation DLCPAlphaPicker

+ (Class)backgroundLayerClass {
	return [DLCPAlphaBackgroundLayer class];
}

+ (CGFloat)defaultXValue {
	return 1.0;
}

+ (CGFloat)defaultYValue {
	return 0.0;
}

- (void)setAlpha:(CGFloat)alpha {
	self.xValue = alpha;
}

- (CGFloat)alpha {
	return self.xValue;
}

+ (NSSet *)keyPathsForValuesAffectingAlpha {
    return [NSSet setWithObject:NSStringFromSelector(@selector(xValue))];
}

- (void)setMinAlpha:(CGFloat)minAlpha {
	self.minXValue = minAlpha;
}

- (CGFloat)minAlpha {
	return self.minXValue;
}

+ (NSSet *)keyPathsForValuesAffectingMinAlpha {
    return [NSSet setWithObjects:NSStringFromSelector(@selector(minXValue)), nil];
}

- (void)setMaxAlpha:(CGFloat)maxAlpha {
	self.maxXValue = maxAlpha;
}

- (CGFloat)maxAlpha {
	return self.maxXValue;
}

+ (NSSet *)keyPathsForValuesAffectingMaxAlpha {
    return [NSSet setWithObjects:NSStringFromSelector(@selector(maxXValue)), nil];
}

- (void)updateForNormalizedLocation:(CGPoint)normalizedLocation {
	[super updateForNormalizedLocation:normalizedLocation];
	self.indicatorLayer.backgroundColor = [UIColor colorWithWhite:1.0 alpha:normalizedLocation.x].CGColor;
}

@end
