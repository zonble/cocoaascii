//
//  NSImage+ASCII.m
//  NSImageASCII
//
//  Created by zonble on 2009/07/22.
//

#import "NSImage+ASCII.h"


NSString *stringForBrightness(CGFloat brightness)
{
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

@implementation NSImage(ASCII)

- (NSString *)asciiArtWithWidth:(NSInteger)width height:(NSInteger)height
{
	if (!width)
		return nil;
	if (!height)
		return nil;
	
	NSMutableString *string = [NSMutableString string];
	
	NSImage *tempImage = [[NSImage alloc] initWithSize:NSMakeSize(width, height)];
	[tempImage lockFocus];
	[self drawInRect:NSMakeRect(0, 0, [tempImage size].width, [tempImage size].height) fromRect:NSZeroRect operation:NSCompositeSourceOver fraction:1.0];	
	[tempImage unlockFocus];

	NSBitmapImageRep *bitmapImage = [[NSBitmapImageRep alloc] initWithData:[tempImage TIFFRepresentation]];
	
	for (int i = 0; i < [tempImage size].height; i++) {
		for (int j = 0; j < [tempImage size].width; j++) {
			NSColor *color = [bitmapImage colorAtX:j y:i];
			NSColor *wColor = [color colorUsingColorSpaceName:NSDeviceWhiteColorSpace];
			[string appendString:stringForBrightness([wColor whiteComponent])];
		}
		[string appendString:@"\n"];
	}
	[bitmapImage release];
	[tempImage release];
	return string;
}

@end
