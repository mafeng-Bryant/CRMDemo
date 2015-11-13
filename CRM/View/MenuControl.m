//
//  MenuControl.m
//  BoandaProject
//
//  Created by 张仁松 on 13-7-2.
//  Copyright (c) 2013年 szboanda. All rights reserved.
//

#import "MenuControl.h"
#import "CustomBadge.h"
#import "UrlImageButton.h"
#import "MenuIcon.h"


@interface MenuControl()
@property(nonatomic,strong) CustomBadge *badge;
@property(nonatomic,strong) CustomBadge *leftbadge;


@end


@implementation MenuControl
@synthesize menuInfo,badge,leftbadge,pressBtn;

-(id)initWithFrame:(CGRect)frame andMenuInfo:(MenuIcon*)menuIcon
{
    self = [super initWithFrame:frame];
    if (self) {
        self.menuIcon = menuIcon;
         UrlImageButton *btn = [[UrlImageButton alloc] initWithFrame:
                          CGRectMake(15,17,120, 120)];
     
        
        if (self.menuIcon.childArray.count > 0) {
    
            [btn setBackgroundColor:UIColorFromRGB(116, 151, 189)];
            btn.layer.cornerRadius = 25.0;
            [btn setMenuIconInfomation:self.menuIcon];
            
            }else {
                
                
                
               NSMutableString* mutableString = [NSMutableString stringWithString:self.menuIcon.iconString];
               [mutableString replaceOccurrencesOfString:@"\\" withString:@"//" options:NSCaseInsensitiveSearch range:NSMakeRange(0, [mutableString length])];
                    NSString*  newString = [mutableString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
                NSString* baseUrlString =[BASE_URL stringByAppendingString:newString];
                [btn setImageFromUrl:YES withUrl:baseUrlString];
                btn.iconId = self.menuIcon.iconId;
           }
        
        
        [btn addTarget:self action:@selector(btnPressed:) forControlEvents:UIControlEventTouchUpInside];
		[self addSubview:btn];
        btn.menuIcon =self.menuIcon;
        
        self.pressBtn = btn;
        
        UILabel *btnLabel = [[UILabel alloc] initWithFrame:
                             CGRectMake(0 ,140,150, 45)];
		btnLabel.lineBreakMode = UILineBreakModeCharacterWrap;
		btnLabel.numberOfLines = 2;
		btnLabel.text = self.menuIcon.title;//CDMC
		btnLabel.textAlignment = UITextAlignmentCenter;
		btnLabel.backgroundColor = [UIColor clearColor];
        btnLabel.contentMode =  UIViewContentModeTop;
        btnLabel.textColor = [UIColor whiteColor];
		[self addSubview:btnLabel];
        
        self.badge = [CustomBadge customBadgeWithString:@""
                                                 withStringColor:[UIColor whiteColor]
                                                  withInsetColor:[UIColor redColor]
                                                  withBadgeFrame:YES
                                             withBadgeFrameColor:[UIColor clearColor]
                                                       withScale:1.0
                                                     withShining:YES];
        
        [self.badge setFrame:CGRectMake(frame.size.width-15, 10, badge.frame.size.width, badge.frame.size.height)];
        [self addSubview:badge];
        badge.hidden = YES;

    }
    return self;
}

//此处代码让control本身来处理UIControlEventTouchUpInside消息
//如果设置btn.userInteractionEnabled = NO; btn没有点击状态 不好看
-(void)btnPressed:(id)sender{
    
    [self sendActionsForControlEvents:UIControlEventTouchUpInside];
}

-(void)showIconBadge:(NSString *)valueBadge{
    
    
     if([valueBadge length] <= 0 || [valueBadge isEqualToString:@"0"])
        badge.hidden = YES;
    else{
        badge.hidden = NO;
        [badge autoBadgeSizeWithString:valueBadge];
    }
        
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

//add yes加号 no 减号
-(void)addShakeBadge:(BOOL)add{
    NSString *flag = @"";
    UIColor *insetColor = nil;
    if(add){
        flag = @"+";
        insetColor = [UIColor blueColor];
    }
    else{
        flag = @"X";
        insetColor = [UIColor blackColor];
    }
    self.leftbadge = [CustomBadge customBadgeWithString:flag
                                    withStringColor:[UIColor whiteColor]
                                     withInsetColor:insetColor
                                     withBadgeFrame:YES
                                withBadgeFrameColor:[UIColor whiteColor]
                                          withScale:1.0
                                        withShining:YES];
    
    [self.badge setFrame:CGRectMake(-40, -badge.frame.size.height*1/3, badge.frame.size.width, badge.frame.size.height)];
    [self addSubview:leftbadge];
}

-(void)removeShakeBadge{
    
}


-(void)addLongPressTarget:(id)target  andAction:(SEL)aSelector{
    
    UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:target action:aSelector];
   // longPress.minimumPressDuration = 2;
    [pressBtn addGestureRecognizer:longPress];
    
}
@end
