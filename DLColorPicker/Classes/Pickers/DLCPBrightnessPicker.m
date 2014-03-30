//
//  DLCPBrightnessPicker.m
//  DLColorPicker
//
//  Created by Vincent Esche on 10/28/13.
//  Copyright (c) 2013 Vincent Esche. All rights reserved.
//

#import "DLCPBrightnessPicker.h"

#import "DLCPSingleAxisSlider+Protected.h"

@interface DLCPBrightnessBackgroundLayer : DLCPBackgroundLayer

@property (readwrite, strong, nonatomic) CAGradientLayer *brightnessLayer;

@end

@implementation DLCPBrightnessBackgroundLayer

- (instancetype)init {
    self = [super init];
    if (self) {
        [self commonInit_DLCPBrightnessBackgroundLayer];
	}
    return self;
}

- (instancetype)initWithLayer:(id)layer {
    self = [super initWithLayer:layer];
    if (self) {
        [self commonInit_DLCPBrightnessBackgroundLayer];
    }
    return self;
}

- (void)commonInit_DLCPBrightnessBackgroundLayer {
	CAGradientLayer *brightnessLayer = [CAGradientLayer layer];
	brightnessLayer.masksToBounds = YES;
	brightnessLayer.colors = @[
						(__bridge id)[UIColor colorWithWhite:0.0 alpha:1.0].CGColor,
						(__bridge id)[UIColor colorWithWhite:1.0 alpha:1.0].CGColor];
	brightnessLayer.startPoint = CGPointMake(0.0, 0.5);
	brightnessLayer.endPoint = CGPointMake(1.0, 0.5);
	[self addSublayer:brightnessLayer];
	self.brightnessLayer = brightnessLayer;
}

- (void)layoutSublayers {
	CGFloat borderWidth = self.borderWidth;
	
	CGRect frame = self.bounds;
	CGFloat cornerRadius = self.cornerRadius;
	if (self.insetSubLayers) {
		frame = CGRectInset(self.bounds, borderWidth, borderWidth);
		cornerRadius -= borderWidth;
	}
	
	CALayer *brightnessLayer = self.brightnessLayer;
	brightnessLayer.frame = frame;
	brightnessLayer.cornerRadius = cornerRadius;
}

@end

@interface DLCPBrightnessPicker ()

@end

@implementation DLCPBrightnessPicker

+ (Class)backgroundLayerClass {
	return [DLCPBrightnessBackgroundLayer class];
}

+ (CGFloat)defaultXValue {
	return 0.0;
}

+ (CGFloat)defaultYValue {
	return 1.0;
}

- (void)setBrightness:(CGFloat)brightness {
	self.xValue = brightness;
}

- (CGFloat)brightness {
	return self.xValue;
}

+ (NSSet *)keyPathsForValuesAffectingBrightness {
    return [NSSet setWithObject:NSStringFromSelector(@selector(xValue))];
}

- (void)updateForNormalizedLocation:(CGPoint)normalizedLocation {
	[super updateForNormalizedLocation:normalizedLocation];
	self.indicatorLayer.backgroundColor = [UIColor colorWithWhite:normalizedLocation.x alpha:1.0].CGColor;
}

@end
