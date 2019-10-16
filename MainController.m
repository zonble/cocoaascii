//
//  MainController.m
//  ASCIIConverter
//
//  Created by zonble on 2009/07/22.
//

#import "MainController.h"
#import "NSImage+ASCII.h"
#import "ASCIIImageView.h"
#import "MainController+Toolbar.h"
#import "MainController+AppDelegate.h"

#define kWidthPreference @"kWidthPreference"
#define kHeightPreference @"kHeightPreference"

@implementation MainController

- (NSFont *)_defaultFont
{
	return [NSFont fontWithName:@"Monaco" size:10.0];
}

- (void)awakeFromNib
{
	NSToolbar *toolbar = [[NSToolbar alloc] initWithIdentifier:@"toolbar"];
	toolbar.delegate = self;
	toolbar.autosavesConfiguration = YES;
	toolbar.allowsUserCustomization = YES;
	self.window.toolbar = toolbar;
	NSApp.delegate = self;

	[self.window center];
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

	_widthField.integerValue = width;
	_heightField.integerValue = height;
	_textView.textStorage.font = [self _defaultFont];
}

#pragma mark -

- (IBAction)convert:(id)sender
{
	NSInteger width = _widthField.integerValue;
	NSInteger height = _heightField.integerValue;
	NSImage *image = _imageView.image;
	NSString *asciiArt = [image asciiArtWithWidth:width height:height];
	_textView.textStorage.mutableString.string = asciiArt;
	_textView.textStorage.font = [self _defaultFont];
}

- (IBAction)changeWidth:(id)sender
{
	NSInteger width = _widthField.integerValue;
	if (width > 200) {
		width = 200;
	}
	if (width) {
		[[NSUserDefaults standardUserDefaults] setInteger:width forKey:kWidthPreference];
		if (_imageView.image) {
			[self convert:nil];
		}
	}
}

- (IBAction)changeHeight:(id)sender
{
	NSInteger height = _heightField.integerValue;
	if (height > 200) {
		height = 200;
	}
	if (height) {
		[[NSUserDefaults standardUserDefaults] setInteger:height forKey:kHeightPreference];
		if ([_imageView image]) {
			[self convert:nil];
		}
	}
}

- (void)openPanelDidEnd:(NSOpenPanel *)panel returnCode:(NSInteger)returnCode contextInfo:(void *)contextInfo
{
	if (returnCode != NSOKButton) {
		return;
	}
	NSString *filename = [panel filename];
	NSImage *image = [[NSImage alloc] initWithContentsOfFile:filename];
	if (!image) {
		return;
	}
	_imageView.image = image;
}

- (IBAction)loadImage:(id)sender
{
	NSOpenPanel *openPanel = [NSOpenPanel openPanel];
	openPanel.message = NSLocalizedString(@"The image file to convert:", @"");
	openPanel.prompt = NSLocalizedString(@"Load...", @"");
	NSArray *types = @[@"gif", @"jpg", @"jpeg", @"png", @"bmp", @"tif", @"tiff", @"psd", @"pdf", @"ai"];
	openPanel.allowedFileTypes = types;
	openPanel.allowsOtherFileTypes = NO;
	openPanel.allowsMultipleSelection = NO;
	[openPanel beginSheetForDirectory:nil file:nil types:types modalForWindow:[self window] modalDelegate:self didEndSelector:@selector(openPanelDidEnd:returnCode:contextInfo:) contextInfo:NULL];

}

- (void)saveTextToPath:(NSString *)path
{
	NSString *text = _textView.textStorage.string;
	NSData *data = [text dataUsingEncoding:NSUTF8StringEncoding];
	BOOL result = [data writeToFile:path atomically:YES];
	if (!result) {
		_currentFilePath = nil;
		NSRunAlertPanel(NSLocalizedString(@"Failed to save the file!", @"The message in the save panel."), NSLocalizedString(@"Please try again.", @"The message in the save panel."), NSLocalizedString(@"OK", @""), nil, nil);
	}
	else {
		if ([_currentFilePath isEqualToString:path]) {
			return;
		}
		_currentFilePath = path;
	}
}

- (void)savePanelDidEnd:(NSSavePanel *)sheet returnCode:(NSInteger)returnCode contextInfo:(void *)contextInfo
{
	if (returnCode != NSOKButton) {
		return;
	}
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
	savePanel.message = NSLocalizedString(@"Save the converted text to a plain text file:", @"");
	savePanel.prompt = NSLocalizedString(@"Save", @"");
	savePanel.allowedFileTypes = @[@"txt"];
	savePanel.allowsOtherFileTypes = NO;
	[savePanel beginSheetForDirectory:nil file:@"ascii.txt" modalForWindow:[self window] modalDelegate:self didEndSelector:@selector(savePanelDidEnd:returnCode:contextInfo:) contextInfo:NULL];
}

- (IBAction)copy:(id)sender
{
	id responder = self.window.firstResponder;
	if ([responder respondsToSelector:@selector(copy:)]) {
		[responder copy:sender];
	}
}

- (IBAction)openZonbleBlogURL:(id)sender
{
	NSURL *URL = [NSURL URLWithString:@"http://zonble.net/"];
	[[NSWorkspace sharedWorkspace] openURL:URL];
}

#pragma mark -

- (void)imageViewImageDidChange:(ASCIIImageView *)imageView
{
	[self convert:nil];
}

- (void)imageViewImageDidDoubleClick:(ASCIIImageView *)imageView
{
	[self loadImage:nil];
}

@end
