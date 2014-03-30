//
//  DLCPHexPicker.h
//  DLColorPicker
//
//  Created by Vincent Esche on 10/28/13.
//  Copyright (c) 2013 Vincent Esche. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DLCPHexPicker : UIControl

#pragma mark - Properties

@property (readwrite, copy, nonatomic) NSString *hex;
@property (readwrite, strong, nonatomic) UIColor *color;
@property (readwrite, assign, nonatomic, getter = isEditable) BOOL editable;
@property (readwrite, assign, nonatomic, getter = isHexVisible) BOOL hexVisible;

#pragma mark - Appearance

@property (readwrite, assign, nonatomic) CGFloat cornerRadius;

@property (readwrite, assign, nonatomic) CGFloat borderWidth;
@property (readwrite, strong, nonatomic) UIColor *borderColor;

@property (readwrite, strong, nonatomic) UIColor *shadowColor;
@property (readwrite, assign, nonatomic) CGFloat shadowRadius;
@property (readwrite, assign, nonatomic) CGFloat shadowOpacity;
@property (readwrite, assign, nonatomic) CGSize shadowOffset;

@end
