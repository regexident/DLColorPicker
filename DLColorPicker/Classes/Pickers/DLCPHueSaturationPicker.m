//
//  DLCPHueSaturationPicker.m
//  DLColorPicker
//
//  Created by Vincent Esche on 10/28/13.
//  Copyright (c) 2013 Vincent Esche. All rights reserved.
//

#import "DLCPHueSaturationPicker.h"

#import "DLCPDoubleAxisSlider+Protected.h"

@interface DLCPHueSaturationBackgroundLayer : DLCPBackgroundLayer

@property (readwrite, assign, nonatomic) CGFloat brightness;

@property (readwrite, strong, nonatomic) CAGradientLayer *hueLayer;
@property (readwrite, strong, nonatomic) CAGradientLayer *saturationLayer;
@property (readwrite, strong, nonatomic) CALayer *brightnessLayer;

@end

@implementation DLCPHueSaturationBackgroundLayer

- (instancetype)init {
    self = [super init];
    if (self) {
        [self commonInit_DLCPHueSaturationBackgroundLayer];
	}
    return self;
}

- (instancetype)initWithLayer:(id)layer {
    self = [super initWithLayer:layer];
    if (self) {
        [self commonInit_DLCPHueSaturationBackgroundLayer];
    }
    return self;
}

- (void)commonInit_DLCPHueSaturationBackgroundLayer {
	CAGradientLayer *hueLayer = [CAGradientLayer layer];
	hueLayer.masksToBounds = YES;
	hueLayer.colors = @[(__bridge id)[UIColor colorWithHue:(  0.0 / 360) saturation:1.0 brightness:1.0 alpha:1.0].CGColor,
						(__bridge id)[UIColor colorWithHue:( 60.0 / 360) saturation:1.0 brightness:1.0 alpha:1.0].CGColor,
						(__bridge id)[UIColor colorWithHue:(120.0 / 360) saturation:1.0 brightness:1.0 alpha:1.0].CGColor,
						(__bridge id)[UIColor colorWithHue:(180.0 / 360) saturation:1.0 brightness:1.0 alpha:1.0].CGColor,
						(__bridge id)[UIColor colorWithHue:(240.0 / 360) saturation:1.0 brightness:1.0 alpha:1.0].CGColor,
						(__bridge id)[UIColor colorWithHue:(300.0 / 360) saturation:1.0 brightness:1.0 alpha:1.0].CGColor,
						(__bridge id)[UIColor colorWithHue:(360.0 / 360) saturation:1.0 brightness:1.0 alpha:1.0].CGColor];
	hueLayer.startPoint = CGPointMake(0.0, 0.5);
	hueLayer.endPoint = CGPointMake(1.0, 0.5);
	[self addSublayer:hueLayer];
	self.hueLayer = hueLayer;
	
	CAGradientLayer *saturationLayer = [CAGradientLayer layer];
	saturationLayer.masksToBounds = YES;
	saturationLayer.colors = @[(__bridge id)[UIColor colorWithWhite:1.0 alpha:0.0].CGColor,
							   (__bridge id)[UIColor colorWithWhite:1.0 alpha:1.0].CGColor];
	[self addSublayer:saturationLayer];
	self.saturationLayer = saturationLayer;
	
	CALayer *brightnessLayer = [CALayer layer];
	brightnessLayer.masksToBounds = YES;
	brightnessLayer.backgroundColor = [UIColor blackColor].CGColor;
	brightnessLayer.opacity = 0.0;
	[self addSublayer:brightnessLayer];
	self.brightnessLayer = brightnessLayer;
}

- (void)setBrightness:(CGFloat)brightness {
	_brightness = brightness;
	[self updateBrightnessLayer];
}

- (void)updateBrightnessLayer {
	self.brightnessLayer.opacity = 1.0 - self.brightness;
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
	
	CALayer *hueLayer = self.hueLayer;
	hueLayer.frame = frame;
	hueLayer.cornerRadius = cornerRadius;
	
	CALayer *saturationLayer = self.saturationLayer;
	saturationLayer.frame = frame;
	saturationLayer.cornerRadius = cornerRadius;
	
	CALayer *brightnessLayer = self.brightnessLayer;
	brightnessLayer.frame = frame;
	brightnessLayer.cornerRadius = cornerRadius;
}

@end

@interface DLCPHueSaturationPicker ()

@end

@implementation DLCPHueSaturationPicker

- (instancetype)initWithCoder:(NSCoder *)coder {
    self = [super initWithCoder:coder];
    if (self) {
        self.visualBrightness = 1.0;
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.visualBrightness = 1.0;
    }
    return self;
}

+ (Class)backgroundLayerClass {
	return [DLCPHueSaturationBackgroundLayer class];
}

+ (CGFloat)defaultXValue {
	return 0.0;
}

+ (CGFloat)defaultYValue {
	return 1.0;
}

- (void)setHue:(CGFloat)hue saturation:(CGFloat)saturation {
	[self setXValue:hue yValue:saturation];
}

- (void)setHue:(CGFloat)hue {
	self.xValue = hue;
}

- (CGFloat)hue {
	return self.xValue;
}

+ (NSSet *)keyPathsForValuesAffectingHue {
    return [NSSet setWithObject:NSStringFromSelector(@selector(xValue))];
}

- (void)setSaturation:(CGFloat)saturation {
	self.yValue = saturation;
}

- (CGFloat)saturation {
	return self.yValue;
}

+ (NSSet *)keyPathsForValuesAffectingSaturation {
    return [NSSet setWithObject:NSStringFromSelector(@selector(yValue))];
}

- (void)setVisualBrightness:(CGFloat)visualBrightness {
	visualBrightness = MIN(MAX(visualBrightness, 0.0), 1.0);
	_visualBrightness = visualBrightness;
	((DLCPHueSaturationBackgroundLayer *)self.layer).brightness = visualBrightness;
	[self updateForNormalizedLocation:CGPointMake(self.xValue, self.yValue)];
}

- (void)updateForNormalizedLocation:(CGPoint)normalizedLocation {
	[super updateForNormalizedLocation:normalizedLocation];
	self.indicatorLayer.backgroundColor = [UIColor colorWithHue:self.hue
													 saturation:self.saturation
													 brightness:self.visualBrightness
														  alpha:1.0].CGColor;
}

@end
