//
//  NSImage+ASCII.m
//  NSImageASCII
//
//  Created by zonble on 2009/07/22.
//

#import "NSImage+ASCII.h"

NSString *stringForBrightness(CGFloat brightness) {
	if (brightness < (19.0 / 255)) {
		return @"&";
	}
	else if (brightness < (50.0 / 255)) {
		return @"8";
	}
	else if (brightness < (75.0 / 255)) {
		return @"0";
	}
	else if (brightness < (100.0 / 255)) {
		return @"$";
	}
	else if (brightness < (130.0 / 255)) {
		return @"2";
	}
	else if (brightness < (165.0 / 255)) {
		return @"1";
	}
	else if (brightness < (180.0 / 255)) {
		return @"|";
	}
	else if (brightness < (200.0 / 255)) {
		return @";";
	}
	else if (brightness < (218.0 / 255)) {
		return @":";
	}
	else if (brightness < (229.0 / 255)) {
		return @"'";
	}
	return @" ";
}

@implementation NSImage (ASCII)

- (NSString *)asciiArtWithWidth:(NSInteger)width height:(NSInteger)height
{
	if (!width || !height) {
		return nil;
	}

	NSMutableString *string = [NSMutableString string];

	NSBitmapImageRep *bitmapImage = [[NSBitmapImageRep alloc]
			initWithBitmapDataPlanes:NULL
						  pixelsWide:width
						  pixelsHigh:height
					   bitsPerSample:8
					 samplesPerPixel:4
							hasAlpha:YES
							isPlanar:NO
					  colorSpaceName:NSDeviceRGBColorSpace
						 bytesPerRow:0
						bitsPerPixel:0];
	bitmapImage.size = NSMakeSize(width, height);

	[NSGraphicsContext saveGraphicsState];
	[NSGraphicsContext setCurrentContext:[NSGraphicsContext graphicsContextWithBitmapImageRep:bitmapImage]];
	[self drawInRect:NSMakeRect(0, 0, width, height)];
	[NSGraphicsContext restoreGraphicsState];
	for (NSInteger i = 0; i < height; i++) {
		for (NSInteger j = 0; j < width; j++) {
			NSColor *color = [bitmapImage colorAtX:j y:i];
			NSColor *wColor = [color colorUsingColorSpaceName:NSDeviceWhiteColorSpace];
			[string appendString:stringForBrightness([wColor whiteComponent])];
		}
		[string appendString:@"\n"];
	}
	return string;
}

@end
