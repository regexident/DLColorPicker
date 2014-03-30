//
//  DLCPHuePicker.m
//  DLColorPicker
//
//  Created by Vincent Esche on 10/28/13.
//  Copyright (c) 2013 Vincent Esche. All rights reserved.
//

#import "DLCPHuePicker.h"

#import "DLCPSingleAxisSlider+Protected.h"

@interface DLCPHueBackgroundLayer : DLCPBackgroundLayer

@property (readwrite, strong, nonatomic) CAGradientLayer *hueLayer;

@end

@implementation DLCPHueBackgroundLayer

- (instancetype)init {
    self = [super init];
    if (self) {
        [self commonInit_DLCPHueBackgroundLayer];
	}
    return self;
}

- (instancetype)initWithLayer:(id)layer {
    self = [super initWithLayer:layer];
    if (self) {
        [self commonInit_DLCPHueBackgroundLayer];
    }
    return self;
}

- (void)commonInit_DLCPHueBackgroundLayer {
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
}

@end

@interface DLCPHuePicker ()

@end

@implementation DLCPHuePicker

+ (Class)backgroundLayerClass {
	return [DLCPHueBackgroundLayer class];
}

+ (CGFloat)defaultXValue {
	return 0.0;
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

- (void)updateForNormalizedLocation:(CGPoint)normalizedLocation {
	[super updateForNormalizedLocation:normalizedLocation];
	self.indicatorLayer.backgroundColor = [UIColor colorWithHue:self.hue
													 saturation:1.0
													 brightness:1.0
														  alpha:1.0].CGColor;
}

@end
