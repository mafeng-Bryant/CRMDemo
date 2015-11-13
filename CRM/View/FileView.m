//
//  FileView.m
//  CRM
//
//  Created by 马峰 on 14-12-29.
//  Copyright (c) 2014年 马峰. All rights reserved.
//

#import "FileView.h"
#import "MenuIcon.h"
#import "UrlImageButton.h"
#import "CustomBadge.h"

@interface FileView()
@property(nonatomic,strong) CustomBadge*badge;


@end

@implementation FileView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {

        self.layer.cornerRadius =25.0;
        [self setBackgroundColor:UIColorFromRGB(116, 151, 189)];
  
    
    }
    return self;
}
- (void)setfileInfomation:(MenuIcon*)menuIcon
{
    self.menuIcon =menuIcon;
     int w = 60, h =60;
    int n = 3;//一行按钮个数
    int span = (400 - n * w) / (n + 1);
    int count = [menuIcon.childArray count];
    self.menuArray = [NSMutableArray arrayWithArray:self.menuIcon.childArray];
    for (int i =0; i<count; i++) {
        
        MenuIcon* menuIcon = (MenuIcon*)[self.menuArray objectAtIndex:i];
        
        UrlImageButton *imageButton;
        
        UILabel *btnLabel = [[UILabel alloc] init];
       
		btnLabel.lineBreakMode = UILineBreakModeCharacterWrap;
		btnLabel.numberOfLines = 2;
		btnLabel.text = menuIcon.title;//CDMC
		btnLabel.textAlignment = UITextAlignmentCenter;
		btnLabel.backgroundColor = [UIColor clearColor];
        btnLabel.font = [UIFont systemFontOfSize:15];
        btnLabel.contentMode =  UIViewContentModeTop;
        btnLabel.textColor = [UIColor whiteColor];
		[self addSubview:btnLabel];
        
        if (i <=2) {
            
            imageButton = [[UrlImageButton alloc] initWithFrame:
                           CGRectMake(span + (span + w) * (i % n),
                                      span + (span + h) * (i / n) + 10, w, h)];
             btnLabel.frame = CGRectMake(imageButton.frame.origin.x ,CGRectGetHeight(imageButton.frame)+62,60, 45);
        }else {
            
            imageButton = [[UrlImageButton alloc] initWithFrame:
                           CGRectMake(span + (span + w) * (i % n),
                                      span + (span + h) * (i / n) + 19, w, h)];
             btnLabel.frame = CGRectMake(imageButton.frame.origin.x ,CGRectGetHeight(imageButton.frame)+62+120,60, 45);
        }
        
        imageButton.layer.cornerRadius = 20.0;
        imageButton.backgroundColor = [UIColor clearColor];
        
        NSMutableString* mutableString = [NSMutableString stringWithString:menuIcon.iconString];
        [mutableString replaceOccurrencesOfString:@"\\" withString:@"//" options:NSCaseInsensitiveSearch range:NSMakeRange(0, [mutableString length])];
        NSString*  newString = [mutableString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        NSString* baseUrlString =[BASE_URL stringByAppendingString:newString];
        [imageButton setImageFromUrl:YES withUrl:baseUrlString];
        imageButton.iconId = menuIcon.iconId;
        imageButton.menuIcon = menuIcon;
        [imageButton addTarget:self action:@selector(clickFileButton:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:imageButton];
        
        if (menuIcon.noticeCount > 0) {
            
            self.badge = [CustomBadge customBadgeWithString:@""
                                            withStringColor:[UIColor whiteColor]
                                             withInsetColor:[UIColor redColor]
                                             withBadgeFrame:YES
                                        withBadgeFrameColor:[UIColor clearColor]
                                                  withScale:1.0
                                                withShining:YES];
            
            [self.badge setFrame:CGRectMake(imageButton.frame.size.width-15, -8, _badge.frame.size.width, _badge.frame.size.height)];
            [imageButton addSubview:_badge];
            _badge.hidden = NO;
            
            [self showIconBadge:[[NSNumber numberWithInt:menuIcon.noticeCount] stringValue]];
        }
        
        
    }
    
    
}
-(void)showIconBadge:(NSString *)valueBadge{
    if([valueBadge length] <= 0 || [valueBadge isEqualToString:@"0"])
        _badge.hidden = YES;
    else{
        _badge.hidden = NO;
        [_badge autoBadgeSizeWithString:valueBadge];
    }
    
}
- (void)clickFileButton:(UrlImageButton*)imageButton
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(jumeWebview:)]) {
        
        [self.delegate jumeWebview:imageButton];
    }
}


@end
