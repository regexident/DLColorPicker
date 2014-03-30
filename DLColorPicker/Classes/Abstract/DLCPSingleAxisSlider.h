//
//  DLCPSingleAxisSlider.h
//  DLColorPicker
//
//  Created by Vincent Esche on 3/28/14.
//  Copyright (c) 2014 Vincent Esche. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DLCPSingleAxisSlider : UIControl

@property (readonly, strong, nonatomic) CALayer *indicatorLayer;

#pragma mark - Appearance

@property (readwrite, assign, nonatomic) CGFloat cornerRadius;

@property (readwrite, assign, nonatomic) CGFloat borderWidth;
@property (readwrite, strong, nonatomic) UIColor *borderColor;

@property (readwrite, strong, nonatomic) UIColor *shadowColor;
@property (readwrite, assign, nonatomic) CGFloat shadowRadius;
@property (readwrite, assign, nonatomic) CGFloat shadowOpacity;
@property (readwrite, assign, nonatomic) CGSize shadowOffset;

@end
