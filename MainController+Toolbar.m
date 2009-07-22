//
//  MainController+Toolbar.m
//  ASCIIConverter
//
//  Created by zonble on 2009/07/23.
//

#import "MainController+Toolbar.h"

static NSString *loadToolbarIdentifier = @"Load";
static NSString *saveToolbarIdentifier = @"Save";
static NSString *copyToolbarIdentifier = @"Copy";

@implementation MainController(Toolbar)

- (NSArray *)toolbarDefaultItemIdentifiers:(NSToolbar *)toolbar
{
	return [NSArray arrayWithObjects:loadToolbarIdentifier, NSToolbarSeparatorItemIdentifier, saveToolbarIdentifier, copyToolbarIdentifier, NSToolbarSeparatorItemIdentifier, NSToolbarPrintItemIdentifier, NSToolbarFlexibleSpaceItemIdentifier, NSToolbarCustomizeToolbarItemIdentifier,nil];
}

- (NSArray *)toolbarAllowedItemIdentifiers:(NSToolbar *)toolbar
{
	return [NSArray arrayWithObjects:loadToolbarIdentifier, saveToolbarIdentifier, copyToolbarIdentifier, NSToolbarSeparatorItemIdentifier, NSToolbarSpaceItemIdentifier, NSToolbarFlexibleSpaceItemIdentifier, NSToolbarCustomizeToolbarItemIdentifier, NSToolbarPrintItemIdentifier,nil];
}
- (NSToolbarItem *)toolbar:(NSToolbar *)toolbar itemForItemIdentifier:(NSString *)itemIdentifier willBeInsertedIntoToolbar:(BOOL)flag
{
	NSToolbarItem *item = [[[NSToolbarItem alloc] initWithItemIdentifier:itemIdentifier] autorelease];
	if ([itemIdentifier isEqualToString:loadToolbarIdentifier]) {
		[item setLabel:NSLocalizedString(loadToolbarIdentifier, @"")];
		[item setImage:[NSImage imageNamed:@"insert_image"]];
		[item setTarget:self];
		[item setAction:@selector(loadImage:)];
	}
	else if ([itemIdentifier isEqualToString:saveToolbarIdentifier]) {
		[item setLabel:NSLocalizedString(saveToolbarIdentifier, @"")];
		[item setImage:[NSImage imageNamed:@"save"]];
		[item setTarget:self];
		[item setAction:@selector(save:)];
	}
	else if ([itemIdentifier isEqualToString:copyToolbarIdentifier]) {
		[item setLabel:NSLocalizedString(copyToolbarIdentifier, @"")];
		[item setImage:[NSImage imageNamed:@"copy"]];
		[item setTarget:self];
		[item setAction:@selector(copy:)];
	}
	return item;
}
- (void)toolbarWillAddItem:(NSNotification *)notification
{
	NSLog(@"notification:%@", [[notification object] description]);
	NSLog(@"notification:%@", [[notification userInfo] description]);
	NSToolbarItem *item = [[notification userInfo] objectForKey:@"item"];
	if (item && [[item itemIdentifier] isEqualToString:NSToolbarPrintItemIdentifier]) {
		[item setTarget:_textView];
		[item setAction:@selector(print:)];
	}
}

@end
