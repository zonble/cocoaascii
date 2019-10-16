//
//  ASCIIImageView.h
//  ASCIIConverter
//
//  Created by zonble on 2009/07/23.
//

@import Cocoa;

@class ASCIIImageView;

@interface NSObject (ImageViewDelegate)
- (void)imageViewImageDidChange:(ASCIIImageView *)imageView;
- (void)imageViewImageDidDoubleClick:(ASCIIImageView *)imageView;
@end


@interface ASCIIImageView : NSImageView
{
	IBOutlet id delegate;
}

//@property (assign, nonatomic) IBOutlet id delegate;

@end
