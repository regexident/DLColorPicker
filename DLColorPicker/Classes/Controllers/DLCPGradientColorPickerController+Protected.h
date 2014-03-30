//
//  DLCPGradientColorPickerController+Protected.h
//  DLColorPicker
//
//  Created by Vincent Esche on 10/28/13.
//  Copyright (c) 2013 Vincent Esche. All rights reserved.
//

#import "DLCPGradientColorPickerController.h"

#import "DLCPColorPickerController+Protected.h"

#import "DLCPHexPicker.h"
#import "DLCPSaturationBrightnessPicker.h"
#import "DLCPHuePicker.h"
#import "DLCPAlphaPicker.h"

@interface DLCPGradientColorPickerController () <UITextFieldDelegate>

@property(readwrite, strong, nonatomic) IBOutlet DLCPHexPicker *beforePicker;
@property(readwrite, strong, nonatomic) IBOutlet DLCPHexPicker *afterPicker;
@property(readwrite, strong, nonatomic) IBOutlet DLCPSaturationBrightnessPicker *saturationBrightnessPicker;
@property(readwrite, strong, nonatomic) IBOutlet DLCPHuePicker *huePicker;
@property(readwrite, strong, nonatomic) IBOutlet DLCPAlphaPicker *alphaPicker;

@end
