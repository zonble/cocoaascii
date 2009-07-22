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
	
	NSString *_currentFilePath;
}

- (IBAction)convert:(id)sender;
- (IBAction)changeWidth:(id)sender;
- (IBAction)changeHeight:(id)sender;
- (IBAction)loadImage:(id)sender;
- (IBAction)save:(id)sender;
- (IBAction)saveAs:(id)sender;
- (IBAction)copy:(id)sender;

@end
