//
//  DLCPHexPicker.m
//  DLColorPicker
//
//  Created by Vincent Esche on 10/28/13.
//  Copyright (c) 2013 Vincent Esche. All rights reserved.
//

#import "DLCPHexPicker.h"

#import "UIControl+DLCP.h"

#import "DLCPCheckerBoard.h"
#import "DLCPBackgroundLayer.h"

@interface DLCPHexBackgroundLayer : DLCPBackgroundLayer

@property (readwrite, strong, nonatomic) CALayer *colorLayer;
@property (readwrite, strong, nonatomic) CALayer *checkerboardLayer;

@end

@implementation DLCPHexBackgroundLayer

+ (void)initialize {
	if ([self class] == [DLCPHexBackgroundLayer class]) {
		[self patternColor];
	}
}

- (instancetype)init {
    self = [super init];
    if (self) {
        [self commonInit_DLCPHexBackgroundLayer];
	}
    return self;
}

- (instancetype)initWithLayer:(id)layer {
    self = [super initWithLayer:layer];
    if (self) {
        [self commonInit_DLCPHexBackgroundLayer];
    }
    return self;
}

- (void)commonInit_DLCPHexBackgroundLayer {
	CALayer *checkerboardLayer = [CALayer layer];
	checkerboardLayer.masksToBounds = YES;
	checkerboardLayer.backgroundColor = [[self class] patternColor];
	[self addSublayer:checkerboardLayer];
	self.checkerboardLayer = checkerboardLayer;
	
	CALayer *colorLayer = [CALayer layer];
	colorLayer.masksToBounds = YES;
	[self addSublayer:colorLayer];
	self.colorLayer = colorLayer;
}

+ (CGColorRef)patternColor {
	static CGColorRef colorRef = nil;
	static dispatch_once_t onceToken;
	dispatch_once(&onceToken, ^{
		colorRef = DLCPCreateCheckerBoardPatternColorWithSize(0.50, 1.00, 0.5, 8.0);
	});
	return colorRef;
}

- (void)layoutSublayers {
	[super layoutSublayers];
	
	CGRect frame = self.bounds;
	CGFloat cornerRadius = self.cornerRadius;
	if (self.insetSubLayers) {
		CGFloat borderWidth = self.borderWidth;
		frame = CGRectInset(self.bounds, borderWidth, borderWidth);
		cornerRadius -= borderWidth;
	}
	
	CALayer *colorLayer = self.colorLayer;
	colorLayer.frame = frame;
	colorLayer.cornerRadius = cornerRadius;
	
	CALayer *checkerboardLayer = self.checkerboardLayer;
	checkerboardLayer.frame = frame;
	checkerboardLayer.cornerRadius = cornerRadius;
}

- (void)setColor:(UIColor *)color {
	self.colorLayer.backgroundColor = color.CGColor;
}

@end

@interface DLCPHexPicker () <UITextFieldDelegate>

@property (readwrite, strong, nonatomic) CALayer *colorLayer;
@property (readwrite, strong, nonatomic) UITextField *textField;

@end

@implementation DLCPHexPicker

@dynamic cornerRadius, borderWidth, borderColor, shadowColor, shadowRadius, shadowOpacity, shadowOffset;

- (id)initWithFrame:(CGRect)frame {
	self = [super initWithFrame:frame];
    if (self) {
        if (![self commonHexPickerInit]) {
			return nil;
		}
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)decoder {
	self = [super initWithCoder:decoder];
    if (self) {
        if (![self commonHexPickerInit]) {
			return nil;
		}
    }
    return self;
}

- (BOOL)commonHexPickerInit {
	self.textField = [[UITextField alloc] initWithFrame:[self textFieldFrame]];
	self.textField.adjustsFontSizeToFitWidth = YES;
	self.textField.font = [self.textField.font fontWithSize:100];
	[self addSubview:self.textField];
	
	self.editable = YES;
	self.hexVisible = YES;
	
	self.textField.textAlignment = NSTextAlignmentCenter;
	self.textField.delegate = self;
	return YES;
}

+ (Class)layerClass {
	return [self backgroundLayerClass];
}

+ (Class)backgroundLayerClass {
	return [DLCPHexBackgroundLayer class];
}

- (void)layoutSubviews {
	self.textField.frame = [self textFieldFrame];
}

- (CGRect)textFieldFrame {
	CGRect bounds = self.bounds;
	return CGRectInset(bounds, bounds.size.width * 0.1, bounds.size.height * 0.25);
}

+ (NSSet *)keyPathsForValuesAffectingHex {
    return [NSSet setWithObject:NSStringFromSelector(@selector(color))];
}

- (UIColor *)textColorForColor:(UIColor *)color {
	CGFloat red, green, blue, alpha;
	[color getRed:&red green:&green blue:&blue alpha:&alpha];
	CGFloat luminance = (red * 0.299) + (green * 0.587) + (blue * 0.144);
	CGFloat brightness = (luminance > 0.5) ? 0.0 : 1.0;
	return [UIColor colorWithWhite:brightness alpha:1.0];
}

- (void)updateWithColor:(UIColor *)color {
	((DLCPHexBackgroundLayer *)self.layer).color = color;
	self.textField.textColor = [self textColorForColor:color];
	NSString *hexString = (color) ? [[self class] hexStringFromColor:color] : nil;
	self.textField.text = hexString;
}

+ (UIColor *)colorFromHexString:(NSString *)hexString {
	NSParameterAssert(hexString);
	
    hexString = [[hexString stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
	
	NSUInteger length = [hexString length];
    if (length < 6 || length > 7) {
		return nil;
	}
	
	NSUInteger offset = ([hexString hasPrefix:@"#"]) ? 1 : 0;
	
 	unsigned int rgb[3];
	for (NSUInteger i = 0; i < 3; i++) {
		NSString *string = [hexString substringWithRange:NSMakeRange(i * 2 + offset, 2)];
		NSScanner *scanner = [NSScanner scannerWithString:string];
		if (![scanner scanHexInt:(rgb + i)]) {
			return nil;
		}
	}
    
    return [UIColor colorWithRed:((CGFloat)rgb[0] / 255) green:((CGFloat)rgb[1] / 255) blue:((CGFloat)rgb[2] / 255) alpha:1.0];
}

+ (NSString *)hexStringFromColor:(UIColor *)color {
	NSParameterAssert(color);
    CGFloat rgba[4];
	[color getRed:(rgba + 0) green:(rgba + 1) blue:(rgba + 2) alpha:(rgba + 3)];
	return [NSString stringWithFormat:@"#%02X%02X%02X", (unsigned char)(rgba[0] * 255), (unsigned char)(rgba[1] * 255), (unsigned char)(rgba[2] * 255)];
}

#pragma mark - Properties

- (void)setHex:(NSString *)hex {
	_hex = hex;
	self.color = [[self class] colorFromHexString:hex];
}

- (void)setColor:(UIColor *)color {
	_color = color;
	[self updateWithColor:color];
}

- (void)setEditable:(BOOL)editable {
	_editable = editable;
	[self.textField resignFirstResponder];
}

- (void)setHexVisible:(BOOL)hexVisible {
	_hexVisible = hexVisible;
	self.editable &= hexVisible;
	self.textField.hidden = !hexVisible;
}

#pragma mark - UITextFieldDelegate Protocol

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
	if (!self.editable) {
		[self sendActionsForControlEvents:UIControlEventTouchUpInside];
	}
	return self.editable;
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
	self.hex = textField.text;
	[self sendActionsForControlEvents:UIControlEventValueChanged];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
	if ([[self class] colorFromHexString:textField.text]) {
		[textField resignFirstResponder];
		return YES;
	}
    return NO;
}

@end
