//
//  UIControl+DLCP.m
//  DLColorPicker
//
//  Created by Vincent Esche on 30/03/14.
//  Copyright (c) 2014 Vincent Esche. All rights reserved.
//

#import "UIControl+DLCP.h"

@implementation UIControl (DLCP)

- (CGFloat)cornerRadius {
	return self.layer.cornerRadius;
}

- (void)setCornerRadius:(CGFloat)cornerRadius {
	self.layer.cornerRadius = cornerRadius;
}

- (CGFloat)borderWidth {
	return self.layer.borderWidth;
}

- (void)setBorderWidth:(CGFloat)borderWidth {
	self.layer.borderWidth = borderWidth;
}

- (UIColor *)borderColor {
	return [UIColor colorWithCGColor:self.layer.borderColor];
}

- (void)setBorderColor:(UIColor *)borderColor {
	self.layer.borderColor = borderColor.CGColor;
}

- (UIColor *)shadowColor {
	return [UIColor colorWithCGColor:self.layer.shadowColor];
}

- (void)setShadowColor:(UIColor *)shadowColor {
	self.layer.shadowColor = shadowColor.CGColor;
}

- (CGFloat)shadowRadius {
	return self.layer.shadowRadius;
}

- (void)setShadowRadius:(CGFloat)shadowRadius {
	self.layer.shadowRadius = shadowRadius;
}

- (CGFloat)shadowOpacity {
	return self.layer.shadowOpacity;
}

- (void)setShadowOpacity:(CGFloat)shadowOpacity {
	self.layer.shadowOpacity = shadowOpacity;
}

- (CGSize)shadowOffset {
	return self.layer.shadowOffset;
}

- (void)setShadowOffset:(CGSize)shadowOffset {
	self.layer.shadowOffset = shadowOffset;
}

@end
