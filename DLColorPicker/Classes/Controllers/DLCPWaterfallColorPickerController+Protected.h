//
//  DLCPWaterfallColorPickerController+Protected.h
//  DLColorPicker
//
//  Created by Vincent Esche on 10/28/13.
//  Copyright (c) 2013 Vincent Esche. All rights reserved.
//

#import "DLCPWaterfallColorPickerController.h"

#import "DLCPColorPickerController+Protected.h"

#import "DLCPHexPicker.h"
#import "DLCPHueSaturationPicker.h"
#import "DLCPBrightnessPicker.h"
#import "DLCPAlphaPicker.h"

@interface DLCPWaterfallColorPickerController () <UITextFieldDelegate>

@property(readwrite, strong, nonatomic) IBOutlet DLCPHexPicker *beforePicker;
@property(readwrite, strong, nonatomic) IBOutlet DLCPHexPicker *afterPicker;
@property(readwrite, strong, nonatomic) IBOutlet DLCPHueSaturationPicker *hueSaturationPicker;
@property(readwrite, strong, nonatomic) IBOutlet DLCPBrightnessPicker *brightnessPicker;
@property(readwrite, strong, nonatomic) IBOutlet DLCPAlphaPicker *alphaPicker;

@end
