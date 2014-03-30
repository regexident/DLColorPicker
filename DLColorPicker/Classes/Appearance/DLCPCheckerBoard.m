//
//  DLCPCheckerBoard.m
//  DLColorPicker
//
//  Created by Vincent Esche on 10/28/13.
//  Copyright (c) 2013 Vincent Esche. All rights reserved.
//

#import "DLCPCheckerBoard.h"

typedef void(^DLCPImageDrawBlock)(CGContextRef context, NSUInteger width, NSUInteger height);

CGImageRef DLCPCreateImage(NSUInteger width, NSUInteger height, DLCPImageDrawBlock drawBlock) {
	NSCParameterAssert(drawBlock);
	CGColorSpaceRef space = CGColorSpaceCreateDeviceRGB();
	CGContextRef context = CGBitmapContextCreate(NULL, width, height, 8, 4 * width, space,
												 kCGBitmapByteOrderDefault | kCGImageAlphaPremultipliedLast);
	CGColorSpaceRelease(space);
	CGContextSetInterpolationQuality(context,kCGInterpolationHigh);
	drawBlock(context, width, height);
	CGImageRef image = CGBitmapContextCreateImage(context);
	CGContextRelease(context);
	return image;
}

static void drawPatternImage(void *info, CGContextRef ctx) {
    CGImageRef image = (CGImageRef)info;
    CGContextDrawImage(ctx, CGRectMake(0.0, 0.0, CGImageGetWidth(image), CGImageGetHeight(image)), image);
}

static void releasePatternImage(void *info) {
    CGImageRelease((CGImageRef)info);
}

CGPatternRef DLCPCreatePatternFromImage(CGImageRef image) {
	NSCParameterAssert(image);
	size_t width = CGImageGetWidth(image);
	size_t height = CGImageGetHeight(image);
	static const CGPatternCallbacks callbacks = {0, &drawPatternImage, &releasePatternImage};
	return CGPatternCreate(image,
						   CGRectMake (0, 0, width, height),
						   CGAffineTransformMake (1, 0, 0, 1, 0, 0),
						   width, height,
						   kCGPatternTilingConstantSpacing,
						   true, &callbacks);
}

CGColorRef DLCPCreateColorFromPattern(CGPatternRef pattern) {
    CGColorSpaceRef space = CGColorSpaceCreatePattern(NULL);
    CGFloat components[1] = {1.0};
    CGColorRef color = CGColorCreateWithPattern(space, pattern, components);
    CGColorSpaceRelease(space);
    return color;
}

CGColorRef DLCPCreateCheckerBoardPatternColorWithSize(CGFloat checkerDarkBrightness, CGFloat checkerLightBrightness, CGFloat opacity, NSUInteger size) {
	NSCParameterAssert(size);
	CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceGray();
	
	CGImageRef imageRef = DLCPCreateImage(size * 2, size * 2, ^(CGContextRef context, NSUInteger width, NSUInteger height) {
		CGContextSetInterpolationQuality(context, kCGInterpolationNone);
		
		CGFloat checkerDarkComponents[2] = {checkerDarkBrightness, opacity};
		CGColorRef darkColor = CGColorCreate(colorSpace, checkerDarkComponents);
		CGContextSetFillColorWithColor(context, darkColor);
		CGContextFillRect(context, CGRectMake(0.0, 0.0, width, height));
		CGColorRelease(darkColor);
		
		CGFloat checkerLightComponents[2] = {checkerLightBrightness, opacity};
		CGColorRef lightColor = CGColorCreate(colorSpace, checkerLightComponents);
		CGContextSetFillColorWithColor(context, lightColor);
		CGContextFillRect(context, CGRectMake(size, 0.0, size, size));
		CGContextFillRect(context, CGRectMake(0.0, size, size, size));
		CGColorRelease(lightColor);
		
		CGColorSpaceRelease(colorSpace);
	});
	CGPatternRef patternRef = DLCPCreatePatternFromImage(imageRef);
	CGColorRef colorRef = DLCPCreateColorFromPattern(patternRef);
	return colorRef;
}
