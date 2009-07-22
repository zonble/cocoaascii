//
//  NSImage+ASCII.h
//  NSImageASCII
//
//  Created by zonble on 2009/07/22.
//  Copyright 2009 Lithoglyph Inc.. All rights reserved.
//

#import <Cocoa/Cocoa.h>


@interface NSImage(ASCII)

- (NSString *)asciiArtWithWidth:(NSInteger)width height:(NSInteger)height;

@end
