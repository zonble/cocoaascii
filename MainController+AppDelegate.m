//
//  MainController+AppDelegate.m
//  ASCIIConverter
//
//  Created by zonble on 2009/07/23.
//

#import "MainController+AppDelegate.h"


@implementation MainController(AppDelegate)

- (BOOL)applicationShouldHandleReopen:(NSApplication *)theApplication hasVisibleWindows:(BOOL)flag
{
	[self showWindow:self];
	return YES;
}
- (void)applicationDidUnhide:(NSNotification *)aNotification
{
	[self showWindow:self];
}
- (void)applicationDidBecomeActive:(NSNotification *)aNotification
{
	[self showWindow:self];
}


@end
