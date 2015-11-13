//
//  UrlImageButton.m
//  test image
//
//  Created by Xuyan Yang on 8/06/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "UrlImageButton.h"
#import "SDWebImageManager.h"
#import "NSURLAdditions.h"
#import "MenuIcon.h"
#import "UrlImageButton.h"


@implementation UrlImageButton

@synthesize iconIndex;


- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
		iconIndex = -1;

		isScale = NO;
	}
    return self;
}
- (void)setImage:(BOOL)animated withUrl:(NSString *)iconUrl withIsBkg:(BOOL)isBkg
{       
	_animated = animated;
	_isBackgroundImage = isBkg;
	
	if(isBkg)
	{
		[self setBackgroundImage:[self getDefaultImage] forState:UIControlStateNormal];
	}
	else {
		[self setImage:[self getDefaultImage] forState:UIControlStateNormal];
	}

	NSURL* tempUrl = [NSURL URLWithString:iconUrl];
	
	NSURL* finallyUrl = nil;
	if([NSURL isWebURL:tempUrl])
	{
		finallyUrl = tempUrl;
	}
	else {
		finallyUrl = [NSURL URLWithString:iconUrl];
	}
	
	[self setImageWithURL:finallyUrl];
}	

- (void) setBackgroundImageFromUrl:(BOOL)animated withUrl:(NSString *)iconUrl
{       
	[self setImage:animated withUrl:iconUrl withIsBkg:YES];
}	

- (void) setImageFromUrl:(BOOL) animated withUrl:(NSString *)iconUrl
{       
	
	[self setImage:animated withUrl:iconUrl withIsBkg:NO];
}	

	
- (void)setImageWithURL:(NSURL *)url
{
	[self setImageWithURL:url placeholderImage:nil];
}

- (void)setImageWithURL:(NSURL *)url placeholderImage:(UIImage *)placeholder
{
	SDWebImageManager *manager = [SDWebImageManager sharedManager];
	
    // Remove in progress downloader from queue
    [manager cancelForDelegate:self];
	
 //   [self setImage:placeholder forState:UIControlStateNormal];
	
    if (url)
    {
        [manager downloadWithURL:url delegate:self];
    }
}

- (void)cancelCurrentImageLoad
{
	[[SDWebImageManager sharedManager] cancelForDelegate:self];
}

-(UIImage*) getDefaultImage
{
	CGSize frameSize = self.frame.size;
	if(frameSize.width ==96&&frameSize.height==63)
	{
		return [UIImage  imageNamed:@"rr_side.png"];
	}
	else if(frameSize.width ==100&&frameSize.height==66){
		return [UIImage  imageNamed:@"rr_side.png"];
	}
	else if(frameSize.width ==160&&frameSize.height==106){
		return [UIImage  imageNamed:@"rr_side.png"];
	}
	else if(frameSize.width ==310&&frameSize.height==206){
		return [UIImage  imageNamed:@"rr_side.png"];
	}
	else if(frameSize.width ==94&&frameSize.height==70){
		return [UIImage  imageNamed:@"rr_side.png"];
	}
	return nil;

}

- (void)setMenuIconInfomation:(MenuIcon*)menuIcon
{
  
    self.iconArrays = [NSMutableArray arrayWithArray:menuIcon.childArray];
    int w = 25, h =25;
    int n = 3;//一行按钮个数
    int span = (120 - n * w) / (n + 1);
    int count = [menuIcon.childArray count];
    for (int i =0; i<count; i++) {
       
        MenuIcon* menuIcon = (MenuIcon*)[ self.iconArrays objectAtIndex:i];
        UrlImageButton *imageButton;
        
        if (i <=2) {
         
            imageButton = [[UrlImageButton alloc] initWithFrame:
                       CGRectMake(span + (span + w) * (i % n),
                                  span + (span + h) * (i / n) + 10, w, h)];
            
        }else {
            
            imageButton = [[UrlImageButton alloc] initWithFrame:
                           CGRectMake(span + (span + w) * (i % n),
                                      span + (span + h) * (i / n) + 19, w, h)];
         }
        
        imageButton.layer.cornerRadius = 20.0;
        imageButton.backgroundColor = [UIColor clearColor];
        imageButton.userInteractionEnabled = NO;
        

        NSMutableString* mutableString = [NSMutableString stringWithString:menuIcon.iconString];
        [mutableString replaceOccurrencesOfString:@"\\" withString:@"//" options:NSCaseInsensitiveSearch range:NSMakeRange(0, [mutableString length])];
           NSString*  newString = [mutableString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        NSString* baseUrlString =[BASE_URL stringByAppendingString:newString];
        
        [imageButton setImageFromUrl:YES withUrl:baseUrlString];
        imageButton.iconId = menuIcon.iconId;

        
        [self addSubview:imageButton];
    }
}

#pragma mark -

- (void)webImageManager:(SDWebImageManager *)imageManager didFinishWithImage:(UIImage *)image
{
//	if(_animated)
//	{
//	    [UIView beginAnimations:nil context:nil];
//	    [UIView setAnimationDuration:0.5];
//	    [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromRight forView:self cache:YES];
//	}
	
	if(_isBackgroundImage)
	{
	    [self setBackgroundImage:image forState:UIControlStateNormal];
	}
	else {
		[self setImage:image forState:UIControlStateNormal];
	}

//	if(_animated)
//	{
//		[UIView commitAnimations];
//	}
}

@end
