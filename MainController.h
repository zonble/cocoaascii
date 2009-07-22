//
//  MainController.h
//  ASCIIConverter
//
//  Created by zonble on 2009/07/22.
//

#import <Cocoa/Cocoa.h>


@interface MainController : NSWindowController 
{
	IBOutlet NSTextView *_textView;
	IBOutlet NSTextField *_widthField;
	IBOutlet NSTextField *_heightField;
	IBOutlet NSImageView *_imageView;
}

- (IBAction)generate:(id)sender;
- (IBAction)changeWidth:(id)sender;
- (IBAction)changeHeight:(id)sender;
- (IBAction)save:(id)sender;

@end
