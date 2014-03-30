//
//  DLCPGradientColorPickerController.m
//  DLColorPicker
//
//  Created by Vincent Esche on 10/28/13.
//  Copyright (c) 2013 Vincent Esche. All rights reserved.
//

#import "DLCPGradientColorPickerController.h"
#import "DLCPGradientColorPickerController+Protected.h"

@implementation DLCPGradientColorPickerController

- (void)viewDidLoad {
	[super viewDidLoad];

	self.beforePicker.editable = NO;
	
	[self updatePickers];
	
	[self.beforePicker addTarget:self action:@selector(resetResultColor:) forControlEvents:UIControlEventTouchUpInside];
	[self.afterPicker addTarget:self action:@selector(afterPickerColorDidChange:) forControlEvents:UIControlEventValueChanged];
	[self.huePicker addTarget:self action:@selector(huePickerColorDidChange:) forControlEvents:UIControlEventValueChanged];
	[self.alphaPicker addTarget:self action:@selector(alphaPickerColorDidChange:) forControlEvents:UIControlEventValueChanged];
	[self.saturationBrightnessPicker addTarget:self action:@selector(saturationBrightnessPickerColorDidChange:) forControlEvents:UIControlEventValueChanged];
}

- (IBAction)resetResultColor:(DLCPHexPicker *)sender {
	self.resultColor = self.sourceColor;
}

- (IBAction)afterPickerColorDidChange:(DLCPHexPicker *)sender {
	[self changeValuesOfResultColorInformingDelegate:^{
		self.resultColor = sender.color;
	}];
}

- (IBAction)huePickerColorDidChange:(DLCPHuePicker *)sender {
	[self changeValuesOfResultColorInformingDelegate:^{
		CGFloat hue, saturation, brightness, alpha;
		[self.resultColor getHue:&hue saturation:&saturation brightness:&brightness alpha:&alpha];
		self.resultColor = [UIColor colorWithHue:sender.hue saturation:saturation brightness:brightness alpha:alpha];
	}];
}

- (IBAction)alphaPickerColorDidChange:(DLCPAlphaPicker *)sender {
	[self changeValuesOfResultColorInformingDelegate:^{
		CGFloat hue, saturation, brightness, alpha;
		[self.resultColor getHue:&hue saturation:&saturation brightness:&brightness alpha:&alpha];
		self.resultColor = [UIColor colorWithHue:hue saturation:saturation brightness:brightness alpha:sender.alpha];
	}];
}

- (IBAction)saturationBrightnessPickerColorDidChange:(DLCPSaturationBrightnessPicker *)sender {
	[self changeValuesOfResultColorInformingDelegate:^{
		CGFloat hue, saturation, brightness, alpha;
		[self.resultColor getHue:&hue saturation:&saturation brightness:&brightness alpha:&alpha];
		self.resultColor = [UIColor colorWithHue:hue saturation:sender.saturation brightness:sender.brightness alpha:alpha];
	}];
}

- (void)setHexVisible:(BOOL)hexVisible {
	_hexVisible = hexVisible;
	self.beforePicker.hexVisible = hexVisible;
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
	
	self.saturationBrightnessPicker.visualHue = hue;
	[self.saturationBrightnessPicker setSaturation:saturation brightness:brightness];
	
	self.huePicker.hue = hue;
	
	self.alphaPicker.alpha = alpha;
}

@end
