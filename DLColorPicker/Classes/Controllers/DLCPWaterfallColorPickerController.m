//
//  DLCPWaterfallColorPickerController.m
//  DLColorPicker
//
//  Created by Vincent Esche on 10/28/13.
//  Copyright (c) 2013 Vincent Esche. All rights reserved.
//

#import "DLCPWaterfallColorPickerController.h"
#import "DLCPWaterfallColorPickerController+Protected.h"

@implementation DLCPWaterfallColorPickerController

- (void)viewDidLoad {
	[super viewDidLoad];

	self.beforePicker.editable = NO;
	
	[self updatePickers];
	
	[self.beforePicker addTarget:self action:@selector(resetResultColor:) forControlEvents:UIControlEventTouchUpInside];
	[self.afterPicker addTarget:self action:@selector(afterPickerColorDidChange:) forControlEvents:UIControlEventValueChanged];
	[self.brightnessPicker addTarget:self action:@selector(brightnessPickerColorDidChange:) forControlEvents:UIControlEventValueChanged];
	[self.alphaPicker addTarget:self action:@selector(alphaPickerColorDidChange:) forControlEvents:UIControlEventValueChanged];
	[self.hueSaturationPicker addTarget:self action:@selector(hueSaturationPickerColorDidChange:) forControlEvents:UIControlEventValueChanged];
}

- (IBAction)resetResultColor:(DLCPHexPicker *)sender {
	self.resultColor = self.sourceColor;
}

- (IBAction)afterPickerColorDidChange:(DLCPHexPicker *)sender {
	[self changeValuesOfResultColorInformingDelegate:^{
		self.resultColor = sender.color;
	}];
}

- (IBAction)brightnessPickerColorDidChange:(DLCPBrightnessPicker *)sender {
	[self changeValuesOfResultColorInformingDelegate:^{
		CGFloat hue, saturation, brightness, alpha;
		[self.resultColor getHue:&hue saturation:&saturation brightness:&brightness alpha:&alpha];
		self.resultColor = [UIColor colorWithHue:hue saturation:saturation brightness:sender.brightness alpha:alpha];
	}];
}

- (IBAction)hueSaturationPickerColorDidChange:(DLCPHueSaturationPicker *)sender {
	[self changeValuesOfResultColorInformingDelegate:^{
		CGFloat hue, saturation, brightness, alpha;
		[self.resultColor getHue:&hue saturation:&saturation brightness:&brightness alpha:&alpha];
		self.resultColor = [UIColor colorWithHue:sender.hue saturation:sender.saturation brightness:brightness alpha:alpha];
	}];
}

- (IBAction)alphaPickerColorDidChange:(DLCPAlphaPicker *)sender {
	[self changeValuesOfResultColorInformingDelegate:^{
		CGFloat hue, saturation, brightness, alpha;
		[self.resultColor getHue:&hue saturation:&saturation brightness:&brightness alpha:&alpha];
		self.resultColor = [UIColor colorWithHue:hue saturation:saturation brightness:brightness alpha:sender.alpha];
	}];
}

- (void)setSourceColor:(UIColor *)sourceColor {
	super.sourceColor = sourceColor;
	self.resultColor = sourceColor;
}

- (void)setResultColor:(UIColor *)resultColor {
	super.resultColor = resultColor;
	[self updatePickers];
}

- (void)updatePickers {
	self.beforePicker.color = self.sourceColor;
	self.afterPicker.color = self.resultColor;
	
	CGFloat hue, saturation, brightness, alpha;
	[self.resultColor getHue:&hue saturation:&saturation brightness:&brightness alpha:&alpha];
	
	[self.hueSaturationPicker setHue:hue saturation:saturation];
	self.hueSaturationPicker.visualBrightness = brightness;
	
	self.brightnessPicker.brightness = brightness;
	
	self.alphaPicker.alpha = alpha;
}

@end
