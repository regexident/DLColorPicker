//
//  DLCPColorPickerController.h
//  DLColorPicker
//
//  Created by Vincent Esche on 10/28/13.
//  Copyright (c) 2013 Vincent Esche. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, DLCPColorPickerControllerBackgroundTapBehaviour) {
	DLCPColorPickerControllerBackgroundTapBehaviourIgnore,
	DLCPColorPickerControllerBackgroundTapBehaviourCancel,
	DLCPColorPickerControllerBackgroundTapBehaviourFinish
};

@class DLCPColorPickerController;

@protocol DLCPColorPickerControllerDelegate

- (void)colorPickerController:(DLCPColorPickerController *)controller didFinishWithColor:(UIColor *)color;

- (void)colorPickerControllerDidCancel:(DLCPColorPickerController *)controller;

@optional

- (void)colorPickerController:(DLCPColorPickerController *)controller didChangeColor:(UIColor *)color;

@end

@interface DLCPColorPickerController : UIViewController

@property (readwrite, strong, nonatomic) UIColor *sourceColor;
@property (readwrite, strong, nonatomic) UIColor *resultColor;

@property (readwrite, weak, nonatomic) id<DLCPColorPickerControllerDelegate> delegate;
@property (readwrite, assign, nonatomic) DLCPColorPickerControllerBackgroundTapBehaviour backgroundTapBehaviour;

// Calls the delegate's `colorPickerController:didFinishWithColor:` method.
// The delegate is responsible for actually hiding the controller
- (IBAction)finishColorPicker:(id)sender;

// Calls the delegate's `colorPickerControllerDidCancel:` method.
// The delegate is responsible for actually hiding the controller
- (IBAction)cancelColorPicker:(id)sender;

@end
