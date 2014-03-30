//
//  DLCPSaturationBrightnessPicker.m
//  DLColorPicker
//
//  Created by Vincent Esche on 10/28/13.
//  Copyright (c) 2013 Vincent Esche. All rights reserved.
//

#import "DLCPSaturationBrightnessPicker.h"

#import "DLCPDoubleAxisSlider+Protected.h"

@interface DLCPSaturationBrightnessBackgroundLayer : DLCPBackgroundLayer

@property (readwrite, assign, nonatomic) CGFloat hue;

@property (readwrite, strong, nonatomic) CAGradientLayer *saturationLayer;
@property (readwrite, strong, nonatomic) CAGradientLayer *brightnessLayer;

@end

@implementation DLCPSaturationBrightnessBackgroundLayer

- (instancetype)init {
    self = [super init];
    if (self) {
        [self commonInit_DLCPSaturationBrightnessBackgroundLayer];
	}
    return self;
}

- (instancetype)initWithLayer:(id)layer {
    self = [super initWithLayer:layer];
    if (self) {
        [self commonInit_DLCPSaturationBrightnessBackgroundLayer];
    }
    return self;
}

- (void)commonInit_DLCPSaturationBrightnessBackgroundLayer {
	CAGradientLayer *saturationLayer = [CAGradientLayer layer];
	saturationLayer.masksToBounds = YES;
	saturationLayer.colors = @[(__bridge id)[UIColor colorWithHue:self.hue saturation:0.0 brightness:1.0 alpha:1.0].CGColor,
							   (__bridge id)[UIColor colorWithHue:self.hue saturation:1.0 brightness:1.0 alpha:1.0].CGColor];
	saturationLayer.startPoint = CGPointMake(0.0, 0.5);
	saturationLayer.endPoint = CGPointMake(1.0, 0.5);
	[self addSublayer:saturationLayer];
	self.saturationLayer = saturationLayer;
	
	CAGradientLayer *brightnessLayer = [CAGradientLayer layer];
	brightnessLayer.masksToBounds = YES;
	brightnessLayer.colors = @[(__bridge id)[UIColor colorWithWhite:0.0 alpha:0.0].CGColor,
							   (__bridge id)[UIColor colorWithWhite:0.0 alpha:1.0].CGColor];
	[self addSublayer:brightnessLayer];
	self.brightnessLayer = brightnessLayer;
}

- (void)setHue:(CGFloat)hue {
	_hue = hue;
	[self updateSaturationLayer];
}

- (void)updateSaturationLayer {
	self.saturationLayer.colors = @[(__bridge id)[UIColor colorWithHue:self.hue saturation:0.0 brightness:1.0 alpha:1.0].CGColor,
									(__bridge id)[UIColor colorWithHue:self.hue saturation:1.0 brightness:1.0 alpha:1.0].CGColor];
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
	
	CALayer *saturationLayer = self.saturationLayer;
	CALayer *brightnessLayer = self.brightnessLayer;
	
	saturationLayer.frame = frame;
	saturationLayer.cornerRadius = cornerRadius;
	
	brightnessLayer.frame = frame;
	brightnessLayer.cornerRadius = cornerRadius;
}

@end

@interface DLCPSaturationBrightnessPicker ()

@end

@implementation DLCPSaturationBrightnessPicker

- (instancetype)initWithCoder:(NSCoder *)coder {
    self = [super initWithCoder:coder];
    if (self) {
		[self commonInit_DLCPSaturationBrightnessPicker];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
		[self commonInit_DLCPSaturationBrightnessPicker];
    }
    return self;
}

- (void)commonInit_DLCPSaturationBrightnessPicker {
	self.visualHue = 1.0;
}

+ (Class)backgroundLayerClass {
	return [DLCPSaturationBrightnessBackgroundLayer class];
}

#pragma mark - Default Values

+ (CGFloat)defaultXValue {
	return 1.0;
}

+ (CGFloat)defaultYValue {
	return 0.0;
}

- (void)setSaturation:(CGFloat)saturation brightness:(CGFloat)brightness {
	[self setXValue:saturation yValue:brightness];
}

- (void)setSaturation:(CGFloat)saturation {
	self.xValue = saturation;
}

- (CGFloat)saturation {
	return self.xValue;
}

+ (NSSet *)keyPathsForValuesAffectingSaturation {
    return [NSSet setWithObject:NSStringFromSelector(@selector(xValue))];
}

- (void)setBrightness:(CGFloat)brightness {
	self.yValue = brightness;
}

- (CGFloat)brightness {
	return self.yValue;
}

+ (NSSet *)keyPathsForValuesAffectingBrightness {
    return [NSSet setWithObject:NSStringFromSelector(@selector(yValue))];
}

#pragma mark - Saturation Accessors

- (void)setVisualHue:(CGFloat)visualHue {
	visualHue = MIN(MAX(visualHue, 0.0), 1.0);
	_visualHue = visualHue;
	((DLCPSaturationBrightnessBackgroundLayer *)self.layer).hue = visualHue;
	[self updateForNormalizedLocation:CGPointMake(self.xValue, self.yValue)];
}

- (void)updateForNormalizedLocation:(CGPoint)normalizedLocation {
	[super updateForNormalizedLocation:normalizedLocation];
	self.indicatorLayer.backgroundColor = [UIColor colorWithHue:self.visualHue
													 saturation:self.saturation
													 brightness:self.brightness
														  alpha:1.0].CGColor;
}

@end
