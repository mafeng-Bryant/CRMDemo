//
//  MenuPageView.m
//  BoandaProject
//
//  Created by 张仁松 on 13-7-2.
//  Copyright (c) 2013年 szboanda. All rights reserved.
//

#import "MenuPageView.h"
#import "MenuControl.h"
#import "MenuIcon.h"

@interface MenuPageView()
@property(nonatomic,strong)id target;
@property(nonatomic,strong)NSArray *menuItems;
@end

@implementation MenuPageView
@synthesize target,menuItems;

-(id)initWithFrame:(CGRect)frame andMenuPageInfo:(NSArray*)menuIconArray andTarget:(id)aTarget andAction:(SEL)aSelector
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.target = aTarget;
        // Initialization code
//        UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 50, 768, 42)];
//        titleLabel.backgroundColor = [UIColor clearColor];
//        titleLabel.textAlignment = NSTextAlignmentCenter;
//        titleLabel.textColor = [UIColor blueColor];
//        titleLabel.font = [UIFont systemFontOfSize:23.0];
//        titleLabel.shadowColor = [UIColor lightGrayColor];
//        titleLabel.text = [pageInfo objectForKey:@"PageTitle"];
//        //[self addSubview:titleLabel];
        self.menuItems = menuIconArray;
        
        int w = 130, h =130;
        int n = 5;//一行按钮个数
        int span = (1024 - n * w) / (n + 1);
        int count = [menuItems count];
        
        for (int i = 0; i < count; i++) {
            
            MenuIcon *menuIcon = [self.menuItems objectAtIndex:i];
            MenuControl *control;
            
            if (i<=4) {
                
               control = [[MenuControl alloc] initWithFrame:
                                        CGRectMake(span + (span + w) * (i % n),
                                                   span + (span + h) * (i / n) + 15, w, h) andMenuInfo:menuIcon];
            } else {
            
             control = [[MenuControl alloc] initWithFrame:
                                        CGRectMake(span + (span + w) * (i % n),
                                                   span + (span + h) * (i / n) + 65, w, h) andMenuInfo:menuIcon];
            
            }
            
       
            [control addTarget:aTarget action:aSelector forControlEvents:UIControlEventTouchUpInside];
            
            
            
         //   [control addShakeBadge:YES];
            
            [self addSubview:control];
            control.pressBtn.tag = i;
            [control addLongPressTarget:self andAction:@selector(handleLongGesture:)];
        }
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

-(void)handleLongGesture:(UIGestureRecognizer *)gestureRecognizer{
        
       if (gestureRecognizer.state == UIGestureRecognizerStateBegan) {
           
           UIView *touchView = gestureRecognizer.view;
           NSInteger index = touchView.tag;
           if(index < [menuItems count]){
               
           //    NSDictionary *menuItem = [menuItems objectAtIndex:index];
//               [target performSelector:@selector(handleLongPress:andPageIndex:) withObject:menuItem withObject:[NSNumber numberWithInteger:self.tag]];
           }
       }
}
@end
