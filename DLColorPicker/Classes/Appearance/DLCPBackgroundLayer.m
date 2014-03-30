//
//  DLCPBackgroundLayer.m
//  DLColorPicker
//
//  Created by Vincent Esche on 10/28/13.
//  Copyright (c) 2013 Vincent Esche. All rights reserved.
//

#import "DLCPBackgroundLayer.h"

@interface DLCPBackgroundLayer ()

@end

@implementation DLCPBackgroundLayer

- (instancetype)init {
    self = [super init];
    if (self) {
        [self commonInit_DLCPBackgroundLayer];
    }
    return self;
}

- (instancetype)initWithLayer:(id)layer {
    self = [super initWithLayer:layer];
    if (self) {
        [self commonInit_DLCPBackgroundLayer];
    }
    return self;
}

- (void)commonInit_DLCPBackgroundLayer {
	self.insetSubLayers = NO;
	
	self.borderColor = [UIColor colorWithWhite:1.0 alpha:0.75].CGColor;
	self.borderWidth = 1.5;
	
	self.shadowColor = [UIColor blackColor].CGColor;
	self.shadowOffset = CGSizeMake(0.0, 1.0);
	self.shadowOpacity = 0.25;
	self.shadowRadius = 1.0;
	
	self.cornerRadius = 5.0;
}

- (void)setInsetSubLayers:(BOOL)insetSubLayers {
	_insetSubLayers = insetSubLayers;
	[self setNeedsLayout];
}

- (void)setBorderWidth:(CGFloat)borderWidth {
	super.borderWidth = borderWidth;
	[self setNeedsLayout];
}

- (void)setCornerRadius:(CGFloat)cornerRadius {
	super.cornerRadius = cornerRadius;
	[self setNeedsLayout];
}

@end
