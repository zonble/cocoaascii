//
//  ASCIIImageView.m
//  ASCIIConverter
//
//  Created by zonble on 2009/07/23.
//

#import "ASCIIImageView.h"


@implementation ASCIIImageView

- (void)setImage:(NSImage *)image
{
	[super setImage:image];
	if (delegate && [delegate respondsToSelector:@selector(imageViewImageDidChange:)]) {
		[delegate imageViewImageDidChange:self];
	}
}

- (void)mouseDown:(NSEvent *)event
{
	[super mouseDown:event];
	[self mouseUp:event];
}

- (void)mouseUp:(NSEvent *)event
{
	if ([event clickCount] > 1) {
		if (delegate && [delegate respondsToSelector:@selector(imageViewImageDidDoubleClick:)]) {
			[delegate imageViewImageDidDoubleClick:self];
		}		
	}
}

@end
