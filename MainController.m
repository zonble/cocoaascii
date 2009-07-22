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

- (void) dealloc
{
	[_currentFilePath release];
	[super dealloc];
}


- (void)awakeFromNib
{
	NSToolbar *toolbar = [[[NSToolbar alloc] initWithIdentifier:@"toolbar"] autorelease];
	[toolbar setDelegate:self];
	[toolbar setAutosavesConfiguration:YES];
	[toolbar setAllowsUserCustomization:YES];
	[[self window] setToolbar:toolbar];
	[NSApp setDelegate:self];
	
	[[self window] center];
//	[[self window] setDelegate:self];

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

#pragma mark -

- (IBAction)convert:(id)sender
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
- (void)openPanelDidEnd:(NSOpenPanel *)panel returnCode:(NSInteger)returnCode contextInfo:(void  *)contextInfo
{
	if (returnCode != NSOKButton)
		return;
	NSString *filename = [panel filename];
	NSImage *image = [[[NSImage alloc] initWithContentsOfFile:filename] autorelease];
	if (!image) {
		return;
	}
	[_imageView setImage:image];
	[self convert:nil];
}
- (IBAction)loadImage:(id)sender
{
	NSOpenPanel *openPanel = [NSOpenPanel openPanel];
	[openPanel setMessage:NSLocalizedString(@"The image file to convert:", @"")];
	[openPanel setPrompt:NSLocalizedString(@"Load...", @"")];
	NSArray *types = [NSArray arrayWithObjects:@"gif", @"jpg", @"jpeg", @"png", @"bmp", @"tif", @"tiff", @"psd", @"pdf", @"ai", nil];
	[openPanel setAllowedFileTypes:types];
	[openPanel setAllowsOtherFileTypes:NO];
	[openPanel setAllowsMultipleSelection:NO];
	[openPanel beginSheetForDirectory:nil file:nil types:types modalForWindow:[self window] modalDelegate:self didEndSelector:@selector(openPanelDidEnd:returnCode:contextInfo:) contextInfo:NULL];
	
}
- (void)saveTextToPath:(NSString *)path
{
	NSString *text = [[_textView textStorage] string];
	NSData *data = [text dataUsingEncoding:NSUTF8StringEncoding];
	BOOL result = [data writeToFile:path atomically:YES];
	if (!result) {
		if (_currentFilePath) {
			id tmp = _currentFilePath;
			_currentFilePath = nil;
			[tmp release];	
		}
		NSRunAlertPanel(NSLocalizedString(@"Failed to save the file!", @"The message in the save panel."), NSLocalizedString(@"Please try again.", @"The message in the save panel."), NSLocalizedString(@"OK", @""), nil, nil);
	}
	else {
		if ([_currentFilePath isEqualToString:path]) {
			return;
		}
		id tmp = _currentFilePath;
		_currentFilePath  = [path retain];
		[tmp release];
	}
}
- (void)savePanelDidEnd:(NSSavePanel *)sheet returnCode:(NSInteger)returnCode contextInfo:(void *)contextInfo
{
	if (returnCode != NSOKButton)
		return;
	NSString *filename = [sheet filename];
	[self saveTextToPath:filename];
}

- (IBAction)save:(id)sender
{
	if (_currentFilePath) {
		[self saveTextToPath:_currentFilePath];
	}
	else {
		[self saveAs:nil];
	}	
}
- (IBAction)saveAs:(id)sender
{
	NSSavePanel *savePanel = [NSSavePanel savePanel];
	[savePanel setMessage:NSLocalizedString(@"Save the converted text to a plain text file:", @"")];
	[savePanel setPrompt:NSLocalizedString(@"Save", @"")];
	[savePanel setAllowedFileTypes:[NSArray arrayWithObject:@"txt"]];
	[savePanel setAllowsOtherFileTypes:NO];
	[savePanel beginSheetForDirectory:nil file:@"ascii.txt" modalForWindow:[self window] modalDelegate:self didEndSelector:@selector(savePanelDidEnd:returnCode:contextInfo:) contextInfo:NULL];	
}
- (IBAction)copy:(id)sender
{
	id responder = [[self window] firstResponder];
	if ([responder respondsToSelector:@selector(copy:)]) {
		[responder copy:sender];
	}
}
	
@end
