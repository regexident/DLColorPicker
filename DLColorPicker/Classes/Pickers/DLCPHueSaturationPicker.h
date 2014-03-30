//
//  DLCPHueSaturationPicker.h
//  DLColorPicker
//
//  Created by Vincent Esche on 10/28/13.
//  Copyright (c) 2013 Vincent Esche. All rights reserved.
//

#import "DLCPDoubleAxisSlider.h"

@interface DLCPHueSaturationPicker : DLCPDoubleAxisSlider

@property (readwrite, assign, nonatomic) CGFloat hue;
@property (readwrite, assign, nonatomic) CGFloat saturation;

@property (readwrite, assign, nonatomic) CGFloat visualBrightness;

- (void)setHue:(CGFloat)hue saturation:(CGFloat)saturation;

@end
