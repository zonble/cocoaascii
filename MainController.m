//
//  MainController.m
//  ASCIIConverter
//
//  Created by zonble on 2009/07/22.
//

#import "MainController.h"
#import "NSImage+ASCII.h"

#define kWidthPreference @"kWidthPreference"
#define kHeightPreference @"kHeightPreference"

@implementation MainController

- (void)awakeFromNib
{
	[[self window] center];

	NSInteger width = [[NSUserDefaults standardUserDefaults] integerForKey:kWidthPreference];
	if (!width) {
		width = 100;
	}
	if (width > 200) {
		width = 200;
	}
	
	NSInteger height = [[NSUserDefaults standardUserDefaults] integerForKey:kHeightPreference];
	if (!height) {
		height = 40;
	}
	if (height > 200) {
		height = 200;
	}
	
	[_widthField setIntValue:width];
	[_heightField setIntValue:height];
	[[_textView textStorage] setFont:[NSFont fontWithName:@"Monaco" size:12.0]];
}

- (IBAction)generate:(id)sender
{
	NSInteger width = [_widthField intValue];
	NSInteger height = [_heightField intValue];
	NSImage *image = [_imageView image];
	NSString *asciiArt = [image asciiArtWithWidth:width height:height];
	[[[_textView textStorage] mutableString] setString:asciiArt];
	[[_textView textStorage] setFont:[NSFont fontWithName:@"Monaco" size:12.0]];
}
- (IBAction)changeWidth:(id)sender
{
	NSInteger width = [_widthField intValue];
	if (width > 200) {
		width = 200;
	}
	if (width) {
		[[NSUserDefaults standardUserDefaults] setInteger:width forKey:kWidthPreference];
	}
}
- (IBAction)changeHeight:(id)sender
{
	NSInteger height = [_heightField intValue];
	if (height > 200) {
		height = 200;
	}	
	if (height) {
		[[NSUserDefaults standardUserDefaults] setInteger:height forKey:kHeightPreference];
	}
}
- (IBAction)save:(id)sender
{
	
}

@end
