//
//  DLCPDoubleAxisSlider+Protected.h
//  DLColorPicker
//
//  Created by Vincent Esche on 3/28/14.
//  Copyright (c) 2014 Vincent Esche. All rights reserved.
//

#import "DLCPDoubleAxisSlider.h"
#import "DLCPDoubleAxisSlider+Protected.h"

#import "DLCPSingleAxisSlider+Protected.h"

@interface DLCPDoubleAxisSlider ()

@property (readwrite, assign, nonatomic) CGFloat yValue;
@property (readwrite, assign, nonatomic) CGFloat minYValue;
@property (readwrite, assign, nonatomic) CGFloat maxYValue;

- (void)setPrimitiveYValue:(CGFloat)xValue;
- (void)setXValue:(CGFloat)xValue yValue:(CGFloat)yValue;

@end
