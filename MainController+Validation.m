//
//  MainController+Validation.m
//  ASCIIConverter
//
//  Created by zonble on 2009/07/23.
//

#import "MainController+Validation.h"


@implementation MainController(Validation)

- (BOOL)validate:(SEL)action
{
	if (action == @selector(loadImage:)) {
		return YES;
	}
	else if (action == @selector(save:) || action == @selector(saveAs:)) {
		if ([[[[_textView textStorage] string] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] length])
			return YES;
	}
	else if (action == @selector(copy:)) {
		id responder = [[self window] firstResponder];
		if ([responder respondsToSelector:@selector(copy:)])
			return YES;		
	}
	else if (action == @selector(openZonbleBlogURL:)) {
		return YES;
	}
	return NO;
}

- (BOOL)validateMenuItem:(NSMenuItem *)menuItem
{
	SEL action = [menuItem action];
	return [self validate:action];
}
- (BOOL)validateToolbarItem:(NSToolbarItem *)theItem
{
	SEL action = [theItem action];
	return [self validate:action];
}

@end
