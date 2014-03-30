//
//  DLCPSaturationBrightnessPicker.h
//  DLColorPicker
//
//  Created by Vincent Esche on 10/28/13.
//  Copyright (c) 2013 Vincent Esche. All rights reserved.
//

#import "DLCPDoubleAxisSlider.h"

@interface DLCPSaturationBrightnessPicker : DLCPDoubleAxisSlider

@property (readwrite, assign, nonatomic) CGFloat saturation;
@property (readwrite, assign, nonatomic) CGFloat brightness;

@property (readwrite, assign, nonatomic) CGFloat visualHue;

- (void)setSaturation:(CGFloat)saturation brightness:(CGFloat)brightness;

@end
