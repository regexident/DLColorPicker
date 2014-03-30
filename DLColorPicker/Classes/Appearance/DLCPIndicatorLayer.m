//
//  DLCPIndicatorLayer.m
//  DLColorPicker
//
//  Created by Vincent Esche on 10/28/13.
//  Copyright (c) 2013 Vincent Esche. All rights reserved.
//

#import "DLCPIndicatorLayer.h"

@implementation DLCPIndicatorLayer

- (instancetype)init {
    self = [super init];
    if (self) {
        [self commonInit_DLCPIndicatorLayer];
    }
    return self;
}

- (instancetype)initWithLayer:(id)layer {
    self = [super initWithLayer:layer];
    if (self) {
        [self commonInit_DLCPIndicatorLayer];
    }
    return self;
}

- (void)commonInit_DLCPIndicatorLayer {
	CGFloat size = 40.0;
	self.bounds = CGRectMake(0.0, 0.0, size, size);
	
	self.borderColor = [UIColor colorWithWhite:1.0 alpha:0.75].CGColor;
	self.borderWidth = 1.5;
	self.cornerRadius = size / 2;
	
	self.shadowColor = [UIColor blackColor].CGColor;
	self.shadowOffset = CGSizeMake(0.0, 1.5);
	self.shadowOpacity = 0.25;
	self.shadowRadius = 1.5;
	
	self.colors = @[(__bridge id)[UIColor colorWithWhite:1.0 alpha:0.25].CGColor,
					(__bridge id)[UIColor colorWithWhite:1.0 alpha:0.15].CGColor,
					(__bridge id)[UIColor colorWithWhite:1.0 alpha:0.00].CGColor,
					(__bridge id)[UIColor colorWithWhite:1.0 alpha:0.15].CGColor];
	self.locations = @[@0.0, @0.49, @0.51, @1.0];
}

@end
