//
//  DLCPColorPickerController.m
//  DLColorPicker
//
//  Created by Vincent Esche on 10/28/13.
//  Copyright (c) 2013 Vincent Esche. All rights reserved.
//

#import "DLCPColorPickerController.h"

@interface DLCPColorPickerController() <UITextFieldDelegate, UIGestureRecognizerDelegate>

@property (readwrite, strong, nonatomic) UITapGestureRecognizer *tapGestureRecognizer;

@end

@implementation DLCPColorPickerController

#pragma mark - Class methods

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        if (![self commonPickerControllerInit]) {
			return nil;
		}
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)decoder {
    self = [super initWithCoder:decoder];
    if (self) {
        if (![self commonPickerControllerInit]) {
			return nil;
		}
    }
    return self;
}

- (BOOL)commonPickerControllerInit {
	_tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didTapBackgroundView:)];
	[_tapGestureRecognizer setNumberOfTapsRequired:1];
	_tapGestureRecognizer.delegate = self;
	
	_backgroundTapBehaviour = DLCPColorPickerControllerBackgroundTapBehaviourFinish;
	
	self.sourceColor = [[self class] defaultColor];
	
	return YES;
}

+ (UIColor *)defaultColor {
	return [UIColor redColor];
}

- (void)viewDidLoad {
	[super viewDidLoad];
	
	if (floor(NSFoundationVersionNumber) <= NSFoundationVersionNumber_iOS_6_1) {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
		self.edgesForExtendedLayout = UIRectEdgeNone;
#pragma clang diagnostic pop
	}
	
	self.view.userInteractionEnabled = YES;
	self.view.multipleTouchEnabled = NO;
	[self.view addGestureRecognizer:self.tapGestureRecognizer];
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch {
	return touch.view == self.view;
}

- (void)didTapBackgroundView:(UITapGestureRecognizer *)tapGestureRecognizer {
	DLCPColorPickerControllerBackgroundTapBehaviour behaviour = self.backgroundTapBehaviour;
	switch (behaviour) {
		case DLCPColorPickerControllerBackgroundTapBehaviourCancel: {
			[self.delegate colorPickerControllerDidCancel:self];
			break;
		}
		case DLCPColorPickerControllerBackgroundTapBehaviourFinish: {
			[self.delegate colorPickerController:self didFinishWithColor:self.resultColor];
			break;
		}
		case DLCPColorPickerControllerBackgroundTapBehaviourIgnore:
		default: {
			break;
		}
	}
}

- (IBAction)finishColorPicker:(id)sender {
    [self.delegate colorPickerController:self didFinishWithColor:self.resultColor];
}

- (IBAction)cancelColorPicker:(id)sender {
	[self.delegate colorPickerControllerDidCancel:self];
}

- (void)informDelegateDidChangeColor {
	if (self.delegate && [(id)self.delegate respondsToSelector:@selector(colorPickerController:didChangeColor:)]) {
		[self.delegate colorPickerController:self didChangeColor:self.resultColor];
	}
}

- (void)setSourceColor:(UIColor *)sourceColor {
	_sourceColor = sourceColor;
	self.resultColor = sourceColor;
}

- (void)setResultColor:(UIColor *)resultColor {
	_resultColor = resultColor;
	[self informDelegateDidChangeColor];
}

- (void)changeValuesOfResultColorInformingDelegate:(void(^)(void))block {
	NSParameterAssert(block);
	[self willChangeValueForKey:NSStringFromSelector(@selector(resultColor))];
	block();
	[self didChangeValueForKey:NSStringFromSelector(@selector(resultColor))];
	[self informDelegateDidChangeColor];
}

@end
