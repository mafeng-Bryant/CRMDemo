//
//  FileViewController.m
//  CRM
//
//  Created by 马峰 on 14-12-29.
//  Copyright (c) 2014年 马峰. All rights reserved.
//

#import "FileViewController.h"
#import "FileView.h"
#import "MenuIcon.h"
#import "UrlImageButton.h"
#import "WebToViewController.h"
#import "OrderHomeViewController.h"
#import "Toast+UIView.h"


@interface FileViewController ()<jumpWebViewDelegate>
@property(nonatomic,strong)  FileView* fileView;

@end

@implementation FileViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.maskView = [[UIView alloc]init];
    self.view.backgroundColor = [UIColor colorWithPatternImage:self.backImage];
    self.maskView.frame = CGRectMake(0, 0, 1024, 768);
    self.maskView.backgroundColor = [UIColor blackColor];
    self.maskView.alpha =0.4;
    self.maskView.hidden = NO;
    self.maskView.userInteractionEnabled = YES;
    [self.view addSubview:self.maskView];
    
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.frame = CGRectMake((1024-400)/2.0+170, 150,100,30);
    titleLabel.lineBreakMode = UILineBreakModeCharacterWrap;
    titleLabel.numberOfLines = 2;
    titleLabel.text = self.menuIcon.title;//CDMC
    titleLabel.textAlignment = UITextAlignmentCenter;
    titleLabel.backgroundColor = [UIColor clearColor];
    titleLabel.font = [UIFont systemFontOfSize:25];
    titleLabel.contentMode =  UIViewContentModeTop;
    titleLabel.textColor = [UIColor whiteColor];
    [self.view addSubview:titleLabel];
    
    self.fileView = [[FileView alloc]init];
    self.fileView.frame = CGRectMake((1024-400)/2.0, 200.0, 400, 400);
    [self.fileView setfileInfomation:self.menuIcon];
    self.fileView.delegate = self;
    
    
    [UIView animateWithDuration:0.25 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        [self.view addSubview:self.fileView];
  
        
    } completion:^(BOOL finished) {
        
        
    }];
    

    UITapGestureRecognizer* tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clickTapGesture:)];
    tapGesture.numberOfTapsRequired =1;
    [self.maskView addGestureRecognizer:tapGesture];
    
}
- (void)clickTapGesture:(UITapGestureRecognizer*)tap
{
    if (self.spaceDelegate && [self.spaceDelegate respondsToSelector:@selector(clickSpacebackMethod)]) {
        
        [UIView animateWithDuration:0.25 delay:0 options:UIViewAnimationOptionTransitionFlipFromTop animations:^{
            
            [self.fileView removeFromSuperview];
            
            
        } completion:^(BOOL finished) {
            
            [self.spaceDelegate clickSpacebackMethod];
       }];
        
    }
}
- (void)jumeWebview:(UrlImageButton*)bt
{
   // 订单管理 test
    NSArray* arr = bt.menuIcon.argsArray;
    if (arr.count >0) {
        for (NSDictionary* dic in arr) {
            if ([[dic objectForKey:@"app"] isEqualToString:@"order"]) {
                
                OrderHomeViewController* order = [[OrderHomeViewController alloc]initWithNibName:@"OrderHomeViewController" bundle:nil];
                [self.navigationController pushViewController:order animated:YES];
                break;
             }else {
            
                WebToViewController* webVC = [[WebToViewController alloc]init];
                webVC.url = bt.menuIcon.jumpPageString;
                webVC.titleString = bt.menuIcon.title;
                if (bt.menuIcon.argsArray.count>0) {
                    webVC.argsArr = bt.menuIcon.argsArray;
                }
                if ([bt.menuIcon.jumpPageString length]>0) {
                    [self.navigationController pushViewController:webVC animated:YES];
                }else {
                    
                    [self.view makeToast:@"页面未配置" duration:1 position:@"center"];
                    
                }
                break;
                
            
            
            }
            
            
        }
        
        
    }else {
    
        WebToViewController* webVC = [[WebToViewController alloc]init];
        webVC.url = bt.menuIcon.jumpPageString;
        webVC.titleString = bt.menuIcon.title;
        if (bt.menuIcon.argsArray.count>0) {
            webVC.argsArr = bt.menuIcon.argsArray;
        }
        if ([bt.menuIcon.jumpPageString length]>0) {
            [self.navigationController pushViewController:webVC animated:YES];
        }else {
            
            [self.view makeToast:@"页面未配置" duration:1 position:@"center"];
            
        }
    
    
    }
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
