//
//  MainController+Toolbar.m
//  ASCIIConverter
//
//  Created by zonble on 2009/07/23.
//

#import "MainController+Toolbar.h"

static NSString *loadToolbarIdentifier = @"Load Image";
static NSString *saveToolbarIdentifier = @"Save";
static NSString *copyToolbarIdentifier = @"Copy";

@implementation MainController (Toolbar)

- (NSArray *)toolbarDefaultItemIdentifiers:(NSToolbar *)toolbar
{
	return @[loadToolbarIdentifier, NSToolbarSeparatorItemIdentifier, saveToolbarIdentifier, copyToolbarIdentifier, NSToolbarSeparatorItemIdentifier, NSToolbarPrintItemIdentifier, NSToolbarFlexibleSpaceItemIdentifier, NSToolbarCustomizeToolbarItemIdentifier];
}

- (NSArray *)toolbarAllowedItemIdentifiers:(NSToolbar *)toolbar
{
	return @[loadToolbarIdentifier, saveToolbarIdentifier, copyToolbarIdentifier, NSToolbarSeparatorItemIdentifier, NSToolbarSpaceItemIdentifier, NSToolbarFlexibleSpaceItemIdentifier, NSToolbarCustomizeToolbarItemIdentifier, NSToolbarPrintItemIdentifier];
}

- (NSToolbarItem *)toolbar:(NSToolbar *)toolbar itemForItemIdentifier:(NSString *)itemIdentifier willBeInsertedIntoToolbar:(BOOL)flag
{
	NSToolbarItem *item = [[NSToolbarItem alloc] initWithItemIdentifier:itemIdentifier];
	if ([itemIdentifier isEqualToString:loadToolbarIdentifier]) {
		item.label = NSLocalizedString(loadToolbarIdentifier, @"");
		item.image = [NSImage imageNamed:@"insert_image"];
		item.target = self;
		item.action = @selector(loadImage:);
	}
	else if ([itemIdentifier isEqualToString:saveToolbarIdentifier]) {
		item.label = NSLocalizedString(saveToolbarIdentifier, @"");
		item.image = [NSImage imageNamed:@"save"];
		item.target = self;
		item.action = @selector(save:);
	}
	else if ([itemIdentifier isEqualToString:copyToolbarIdentifier]) {
		item.label = NSLocalizedString(copyToolbarIdentifier, @"");
		item.image = [NSImage imageNamed:@"copy"];
		item.target = self;
		item.action = @selector(copy:);
	}
	return item;
}

- (void)toolbarWillAddItem:(NSNotification *)notification
{
	NSLog(@"notification:%@", [[notification object] description]);
	NSLog(@"notification:%@", [[notification userInfo] description]);
	NSToolbarItem *item = notification.userInfo[@"item"];
	if (item && [item.itemIdentifier isEqualToString:NSToolbarPrintItemIdentifier]) {
		item.target = _textView;
		item.action = @selector(print:);
	}
}

@end
