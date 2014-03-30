//
//  DLCPHuePicker.h
//  DLColorPicker
//
//  Created by Vincent Esche on 10/28/13.
//  Copyright (c) 2013 Vincent Esche. All rights reserved.
//

#import "DLCPSingleAxisSlider.h"

@interface DLCPHuePicker : DLCPSingleAxisSlider

@property (readwrite, strong, nonatomic) UIColor *color;

@property (readwrite, assign, nonatomic) CGFloat hue;

@end
